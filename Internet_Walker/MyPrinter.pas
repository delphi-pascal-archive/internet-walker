unit MyPrinter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Printers, WinsPool, XPButton, XPLabel, StdCtrls, ShellApi,
  XPGroupBox;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

 type
  TPrintFrm = class(TForm)
    fr1: TXPGroupBox;
    PrintBox: TComboBox;
    tx1: TXPLabel;
    CancelBt: TXPButton;
    UpdateBt: TXPLabel;
    PropertiesBt: TXPLabel;
    InstallBt: TXPLabel;
    FolderBt: TXPLabel;
    procedure FolderBtClick(Sender: TObject);
    procedure PropertiesBtClick(Sender: TObject);
    procedure InstallBtClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure XPLabel1Click(Sender: TObject);
    procedure UpdateBtMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure UpdateBtMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure UpdateBtMouseLeave(Sender: TObject);
    procedure PropertiesBtMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure FolderBtMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure InstallBtMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure PropertiesBtMouseLeave(Sender: TObject);
    procedure FolderBtMouseLeave(Sender: TObject);
    procedure InstallBtMouseLeave(Sender: TObject);
    procedure InstallBtMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FolderBtMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure PropertiesBtMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);

  private

  public

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  PrintFrm: TPrintFrm;

implementation

uses OP;

{$R *.dfm}

procedure TPrintFrm.FolderBtClick(Sender: TObject);
begin
WinExec('Control printers', Sw_restore);
end;

procedure TPrintFrm.PropertiesBtClick(Sender: TObject);
const
Defaults: TPrinterDefaults = (pDatatype: nil;
pDevMode: nil;
DesiredAccess: STANDARD_RIGHTS_REQUIRED or PRINTER_ACCESS_USE);
var
hPrinter: THandle;
Device: array[0..255] of char;
Driver: array[0..255] of char;
Port: array[0..255] of char;
hDeviceMode: THandle;
begin
Printer.PrinterIndex := PrintBox.ItemIndex;
Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
if not OpenPrinter(@Device, hPrinter, @Defaults) then
RaiseLastWin32Error;
try
PrinterProperties(Handle, hPrinter);
finally
ClosePrinter(hPrinter);
end;
end;

procedure TPrintFrm.InstallBtClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'rundll32.exe',
'shell32.dll,SHHelpShortcuts_RunDLL AddPrinter',
'', Sw_ShowNormal);
end;

procedure TPrintFrm.FormDestroy(Sender: TObject);
begin
PropertiesBt.Free;
InstallBt.Free;
PrintBox.Free;
UpdateBt.Free;
CancelBt.Free;
FolderBt.Free;
fr1.Free;
tx1.Free;
end;

procedure TPrintFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CancelBt.SetFocus;
end;

procedure TPrintFrm.FormShow(Sender: TObject);
begin
PrintBox.Clear;
PrintBox.Items := Printer.Printers;
PrintBox.ItemIndex := 0;
if SetFrm.ch18.Checked then
begin
SetWindowLong(PrintFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(PrintFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TPrintFrm.XPLabel1Click(Sender: TObject);
begin
PrintBox.Clear;
PrintBox.Items := Printer.Printers;
PrintBox.ItemIndex := 0;
end;

procedure TPrintFrm.UpdateBtMouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
UpdateBt.ForegroundColor := clRed;
end;

procedure TPrintFrm.UpdateBtMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
UpdateBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.UpdateBtMouseLeave(Sender: TObject);
begin
UpdateBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.PropertiesBtMouseMove(Sender: TObject;
Shift: TShiftState; X, Y: Integer);
begin
PropertiesBt.ForegroundColor := clRed;
end;

procedure TPrintFrm.FolderBtMouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
FolderBt.ForegroundColor := clRed;
end;

procedure TPrintFrm.InstallBtMouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
InstallBt.ForegroundColor := clRed;
end;

procedure TPrintFrm.PropertiesBtMouseLeave(Sender: TObject);
begin
PropertiesBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.FolderBtMouseLeave(Sender: TObject);
begin
FolderBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.InstallBtMouseLeave(Sender: TObject);
begin
InstallBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.InstallBtMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
InstallBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.FolderBtMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
FolderBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.PropertiesBtMouseUp(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
PropertiesBt.ForegroundColor := $00FF8000;
end;

procedure TPrintFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TPrintFrm.WMMoving(var msg: TWMMoving);
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
