unit AP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, XPLabel, XPButton, StdCtrls, ComCtrls, ShellApi, jpeg;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

 type
   TAboutFrm = class(TForm)
    tx1: TXPLabel;
    tx7: TXPLabel;
    tx8: TXPLabel;
    Cancel: TXPButton;
    Logo: TImage;
    tx4: TXPLabel;
    tx6: TXPLabel;
    tx3: TXPLabel;
    sp1: TBevel;
    tx2: TXPLabel;
    tx5: TXPLabel;
    sp2: TBevel;
    tx9: TXPLabel;
    tx10: TXPLabel;

    procedure tx3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx9MouseLeave(Sender: TObject);
    procedure tx9MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx10MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx10MouseLeave(Sender: TObject);
    procedure tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx10MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx3MouseLeave(Sender: TObject);
    procedure tx3MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx4MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx4MouseLeave(Sender: TObject);
    procedure tx5MouseLeave(Sender: TObject);
    procedure tx5MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx3MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx4MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx5MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx4Click(Sender: TObject);
    procedure tx5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure tx9Click(Sender: TObject);
    procedure tx10Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClick(Sender: TObject);

  private

  public

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  AboutFrm: TAboutFrm;

implementation

uses OP;

{$R *.dfm}

procedure TAboutFrm.tx3Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://viacoding.ucoz.ru/', nil,nil, Sw_ShowNormal);
end;

procedure TAboutFrm.FormShow(Sender: TObject);
begin
if SetFrm.ch18.Checked then
begin
SetWindowLong(AboutFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(AboutFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TAboutFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TAboutFrm.WMMoving(var msg: TWMMoving);
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

procedure TAboutFrm.tx9MouseLeave(Sender: TObject);
begin
tx9.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx9MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx9.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx10MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx10.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx10MouseLeave(Sender: TObject);
begin
tx10.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx9.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx10MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx10.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx3MouseLeave(Sender: TObject);
begin
tx3.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx3MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx3.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx4MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx4.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx4MouseLeave(Sender: TObject);
begin
tx4.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx5MouseLeave(Sender: TObject);
begin
tx5.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx5MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx5.ForegroundColor := clBlack;
end;

procedure TAboutFrm.tx3MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx3.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx4MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx4.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx5MouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
tx5.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx4Click(Sender: TObject);
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Internet Walker Project'+
'', '', '',SW_SHOW);
end;

procedure TAboutFrm.tx5Click(Sender: TObject);
begin
ShellExecute(Handle, 'open',
'mailto:viacoding@mail.ru?Subject=Internet Walker Project'+
'', '', '',SW_SHOW);
end;

procedure TAboutFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_ESCAPE then
Close;
end;

procedure TAboutFrm.tx9Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'mailto:blackvorons@mail.ru', nil,nil, Sw_ShowNormal);
end;

procedure TAboutFrm.tx10Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'mailto:nenfik@yandex.ru', nil,nil, Sw_ShowNormal);
end;

procedure TAboutFrm.FormDestroy(Sender: TObject);
begin
Cancel.Free;
logo.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
tx6.Free;
tx7.Free;
tx8.Free;
tx9.Free;
tx10.Free;
end;

procedure TAboutFrm.FormClick(Sender: TObject);
begin
Cancel.SetFocus;
end;

end.
