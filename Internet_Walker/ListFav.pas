unit ListFav;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShlObj, StdCtrls, ExtCtrls, XPButton, XPCheckBox, ShellApi;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TOrgFavFrm = class(TForm)
    Cancel: TXPButton;
    fr1: TPanel;
    FavoriteList: TListBox;
    ch1: TXPCheckBox;

    procedure FavoriteListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  OrgFavFrm: TOrgFavFrm;

implementation

uses NP, OP;

{$R *.dfm}

function GetIEFavourites(const favpath: string): TStrings;
var
searchrec: TSearchrec;
str: TStrings;
path, dir, filename: string;
Buffer: array [0..2047] of Char;
found: Integer;
begin
str := TStringList.Create;
path := FavPath + '\*.url';
dir := ExtractFilepath(path);
found := FindFirst(path, faAnyFile, searchrec);
while found = 0 do
begin
SetString(filename, Buffer, GetPrivateProfileString('InternetShortcut',
PChar('URL'), nil, Buffer, SizeOf(Buffer), PChar(dir+searchrec.name)));
str.Add(filename);
found := FindNext(searchrec);
end;
found := FindFirst(dir + '\*.*', faAnyFile, searchrec);
while found=0 do
begin
if ((searchrec.Attr and faDirectory) > 0) and (searchrec.name[1] <> '.') then
str.AddStrings(GetIEFavourites(dir + '\' + searchrec.name));
found := FindNext(searchrec);
end;
FindClose(searchrec);
Result := str;
end;

procedure TOrgFavFrm.FavoriteListClick(Sender: TObject);
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
Close;
except
end;
end;

procedure TOrgFavFrm.FormShow(Sender: TObject);
var
pidl: PItemIDList;
FavPath: array [0..MAX_PATH] of char;
begin
SHGetSpecialFolderLocation(Handle, CSIDL_FAVORITES, pidl);
SHGetPathFromIDList(pidl, favpath);
FavoriteList.Items := GetIEFavourites(StrPas(FavPath));
if SetFrm.ch18.Checked then
begin
SetWindowLong(OrgFavFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(OrgFavFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TOrgFavFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cancel.SetFocus;
end;

procedure TOrgFavFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TOrgFavFrm.WMMoving(var msg: TWMMoving);
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

procedure TOrgFavFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
Close;
end;

procedure TOrgFavFrm.FormDestroy(Sender: TObject);
begin
FavoriteList.Free;
Cancel.Free;
ch1.Free;
fr1.Free;
end;

end.
