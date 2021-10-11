unit AddFav;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, XPButton, XPLabel, ExtCtrls, XPEdit, WBFuncs,
  OleCtrls, SHDocVw;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

 type
   TAddFavFrm = class(TForm)
    logo: TImage;
    tx2: TXPLabel;
    tx1: TXPLabel;
    OK: TXPButton;
    Cancel: TXPButton;
    AddAddress: TXPEdit;
    tx3: TXPLabel;
    tx4: TXPLabel;
    tx5: TXPLabel;

    procedure OKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);

  private

  public

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  AddFavFrm: TAddFavFrm;

implementation

uses NP, OP;

{$R *.dfm}

procedure TAddFavFrm.OKClick(Sender: TObject);
begin 
WB_AddtoFavorites(MainFrm.GetCurrentWB);
end;

procedure TAddFavFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cancel.SetFocus;
end;

procedure TAddFavFrm.FormShow(Sender: TObject);
begin
if SetFrm.ch18.Checked then
begin
SetWindowLong(AddFavFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(AddFavFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TAddFavFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TAddFavFrm.WMMoving(var msg: TWMMoving);
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

procedure TAddFavFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_ESCAPE then
Close;
end;

procedure TAddFavFrm.FormDestroy(Sender: TObject);
begin
AddAddress.Free;
Cancel.Free;
logo.Free;
OK.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
end;

end.
