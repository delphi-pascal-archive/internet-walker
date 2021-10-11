unit ListLink;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ShellApi, XPCheckBox, XPPanel;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

 type
   TLinksFrm = class(TForm)
    FavoriteList: TListBox;
    StatusBar: TStatusBar;
    fr1: TXPPanel;
    ch1: TXPCheckBox;

    procedure FormShow(Sender: TObject);
    procedure FavoriteListClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);

  private

  public

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  LinksFrm: TLinksFrm;

implementation

uses NP, OP;

{$R *.dfm}

procedure TLinksFrm.FormShow(Sender: TObject);
var
i: Integer;
begin
if FavoriteList.Count = 0 then
begin
LinksFrm.Caption := 'Список ссылок';
end else
begin
i := FavoriteList.Items.Count;
LinksFrm.Caption := 'Список ссылок - ' + IntToStr(i);
end;
if SetFrm.ch18.Checked then
begin
SetWindowLong(LinksFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(LinksFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TLinksFrm.FavoriteListClick(Sender: TObject);
var
i: Integer;
ext: string;
begin
try
if ch1.Checked then
begin
ext := LowerCase(ExtractFileExt(FavoriteList.Items[FavoriteList.ItemIndex]));
if (ext = '.txt') or (ext = '.rtf')
then begin
end
else if (ext = '.bmp')
then begin
end
else begin
ShellExecute(Handle, nil, PChar(FavoriteList.Items[FavoriteList.ItemIndex]),
nil, nil, SW_RESTORE);
end;
end else
begin
i := FavoriteList.ItemIndex;
MainFrm.edURL.Text := FavoriteList.Items.Strings[i];
MainFrm.btnGo.OnClick(Self);
end;
except
end;
end;

procedure TLinksFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TLinksFrm.WMMoving(var msg: TWMMoving);
var
r: TRect;
begin
if SetFrm.ch21.Checked then begin
r := Screen.WorkareaRect;
if msg.lprect^.left < r.left then
OffsetRect(msg.lprect^, r.left - msg.lprect^.left, 0);
if msg.lprect^.top < r.top then
OffsetRect(msg.lprect^, 0, r.top - msg.lprect^.top);
if msg.lprect^.right > r.right then
OffsetRect(msg.lprect^, r.right - msg.lprect^.right, 0);
if msg.lprect^.bottom > r.bottom then
OffsetRect(msg.lprect^, 0, r.bottom - msg.lprect^.bottom);
end;
inherited;
end;

procedure TLinksFrm.FormDestroy(Sender: TObject);
begin
FavoriteList.Free;
StatusBar.Free;
fr1.Free;
ch1.Free;
end;

procedure TLinksFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FavoriteList.SetFocus;
end;

procedure TLinksFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_ESCAPE then
Close;
end;

end.
