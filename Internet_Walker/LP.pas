unit LP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, XPButton, StdCtrls, ComCtrls, ExtCtrls;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

  type
   TLicFrm = class(TForm)
    fr1: TPanel;
    ReadMe: TRichEdit;
    PrintText: TXPButton;
    Cancel: TXPButton;
    PrintDlg: TPrintDialog;
    procedure PrintTextClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

  private

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  public

  end;

var
  LicFrm: TLicFrm;

implementation

uses OP;

{$R *.dfm}

procedure TLicFrm.PrintTextClick(Sender: TObject);
var
FFileName: String;
begin
if PrintDlg.Execute then
ReadMe.Print(FFileName);
end;

procedure TLicFrm.CancelClick(Sender: TObject);
begin
LicFrm.Close;
end;

procedure TLicFrm.FormDestroy(Sender: TObject);
begin
LicFrm.OnActivate := nil;
PrintText.Free;
PrintDlg.Free;
Cancel.Free;
ReadMe.Free;
fr1.Free;
end;

procedure TLicFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TLicFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
LicFrm.Close;
end;

procedure TLicFrm.WMMoving(var msg: TWMMoving);
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

procedure TLicFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ReadMe.SetFocus;
end;

procedure TLicFrm.FormShow(Sender: TObject);
begin
if SetFrm.ch18.Checked then
begin
SetWindowLong(LicFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(LicFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

end.
