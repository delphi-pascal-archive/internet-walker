unit OpenAddress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPButton, StdCtrls, ExtCtrls, NP, XPLabel;

    type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;



type
  TOpenFrm = class(TForm)
    OK: TXPButton;
    Cancel: TXPButton;
    Choose: TXPButton;
    logo: TImage;
    AddressList: TComboBox;
    tx1: TXPLabel;
    tx2: TXPLabel;
    tx3: TXPLabel;
    tx4: TXPLabel;
    procedure OKClick(Sender: TObject);
    procedure ChooseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private

  public

    TextString: String;

        procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  OpenFrm: TOpenFrm;

implementation

uses OP;


{$R *.dfm}

procedure TOpenFrm.OKClick(Sender: TObject);
begin
if AddressList.Text = '' then
begin
Exit end else
begin
MainFrm.CreateTabBrowser(TextString, ExtractFileName(TextString));
if SetFrm.ch39.Checked then
begin
if not MainFrm.FullScreenItem.Checked then
MainFrm.FullScreenItem.Click;
end;
end;
end;

procedure TOpenFrm.ChooseClick(Sender: TObject);
begin
if OpenSaveFileDialog(Handle, '*.html',
'Файлы HTML|*.htm;*.html|Графические файлы|*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf|Документы Ms WORD|*.rtf; *.doc|Документы Ms EXCEL|*.xls|Текстовые документы|*.txt|XML файлы|*.xml|Веб-архив|*.mht|Все ресурсы|*.*', ParamStr(1),
'Открыть', TextString, True) then
begin
AddressList.Text := TextString;
end;
AddressList.SetFocus;
end;

procedure TOpenFrm.FormShow(Sender: TObject);
begin
AddressList.Clear;
if SetFrm.ch18.Checked then
begin
SetWindowLong(OpenFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(OpenFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TOpenFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TextString := '';
AddressList.SetFocus;
end;

procedure TOpenFrm.FormDestroy(Sender: TObject);
begin
OpenFrm.OnActivate := nil;
AddressList.Free;
Choose.Free;
Cancel.Free;
logo.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
OK.Free;
end;

procedure TOpenFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
Close;
end;

procedure TOpenFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TOpenFrm.WMMoving(var msg: TWMMoving);
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

end.
