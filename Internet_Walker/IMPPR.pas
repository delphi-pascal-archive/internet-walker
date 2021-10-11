unit IMPPR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPLabel, jpeg, ExtCtrls, XPButton, XPEdit, StdCtrls, ShlObj;

  const
   AlignCenter = Wm_User + 1024;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TImportFrm = class(TForm)
    fr1: TPanel;
    logo: TImage;
    tx1: TXPLabel;
    OK: TXPButton;
    Cancel: TXPButton;
    tx2: TXPLabel;
    tx3: TXPLabel;
    tx4: TXPLabel;
    tx5: TXPLabel;
    edExport: TXPEdit;
    listFav: TListBox;
    edResult: TEdit;
    ChooseBt: TXPButton;

    procedure FormShow(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ChooseBtClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);

  private

  public

    TextString: String;

    msgCaption: PChar;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  ImportFrm: TImportFrm;

implementation

{$R *.dfm}    uses NP, OP;

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

procedure TImportFrm.FormShow(Sender: TObject);
var
pidl: PItemIDList;
FavPath: array [0..MAX_PATH] of char;
begin
SHGetSpecialFolderLocation(Handle, CSIDL_FAVORITES, pidl);
SHGetPathFromIDList(pidl, favpath);
listFav.Items := GetIEFavourites(StrPas(FavPath));
if SetFrm.ch18.Checked then
begin
SetWindowLong(ImportFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(ImportFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TImportFrm.OKClick(Sender: TObject);
begin
PostMessage(ImportFrm.Handle, WM_USER + 1024, 0, 0);
if FileExists(TextString) then
if Application.MessageBox(PChar('Файл "' + TextString +
'" существует.' + #13 + 'Заменить его?'), 'Подтвердите замену',
MB_ICONQUESTION + mb_YesNo) <> idYes then
begin
end else
begin
listFav.Items.SaveToFile(TextString);
end;
if not FileExists(TextString) then
begin
listFav.Items.SaveToFile(TextString);
end;
if OK.Caption = 'Готово' then
ImportFrm.Close;
end;

procedure TImportFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TextString := '';
ChooseBt.Visible := True;
edExport.Visible := True;
tx1.Caption := 'Мастер экспорта избранного';
tx2.Caption := 'Мастер экспорта избранного позволяет легко';
tx3.Caption := 'экспортировать данные из Internet Explorer';
tx4.Caption := 'в другие приложения или файлы.';
tx5.Caption := 'Экспортировать в файл.';
edResult.Visible := False;
edResult.Text := '';
OK.Caption := 'OK';
edExport.Text := '';
edExport.SetFocus;
end;

procedure TImportFrm.FormDestroy(Sender: TObject);
begin
ImportFrm.OnActivate := nil;
ChooseBt.Free;
edExport.Free;
edResult.Free;
Cancel.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
fr1.Free;
OK.Free;
end;

procedure TImportFrm.ChangeMessageBoxPosition(var Msg: TMessage);
var
MbHwnd: longword;
MbRect: TRect;
x, y, w, h: integer;
begin
MbHwnd := FindWindow(MAKEINTRESOURCE(WC_DIALOG), msgCaption);
if (MbHwnd <> 0) then
begin
GetWindowRect(MBHWnd, MBRect);
with MbRect do
begin
w := Right - Left;
h := Bottom - Top;
end;
x := ImportFrm.Left + ((ImportFrm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := ImportFrm.Top + ((ImportFrm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TImportFrm.ChooseBtClick(Sender: TObject);
begin
if OpenSaveFileDialog(Handle, '*.html',
'Файлы HTML (*.htm;*.html)|*.htm;*.html|Текстовые документы (*.txt)|*.txt|', ParamStr(1),
'', TextString, False) then
begin
ChooseBt.Visible := False;
edExport.Visible := False;
tx1.Caption := 'Завершение работы мастера';
tx2.Caption := 'Работа мастера экспорта успешно завершена.';
tx3.Caption := 'После нажатия кнопки "Готово" произойдет следующее.';
tx4.Caption := '';
tx5.Caption := '';
edResult.Visible := True;
edResult.Text := 'Экспорт избранного в "' + TextString + '".';
OK.Caption := 'Готово';
edExport.Text := TextString;
edResult.Top := 104;
end;
end;

procedure TImportFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TImportFrm.WMMoving(var msg: TWMMoving);
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
