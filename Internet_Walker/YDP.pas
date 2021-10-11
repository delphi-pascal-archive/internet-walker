unit YDP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, XPButton, StdCtrls, XPLabel, XPGroupBox, AppEvnts,
  NB30, XPCheckBox, ComCtrls, CommDlg, Registry, WinSock;

  const
   mbMessage = WM_USER + 1024;

  type
    TWmMoving = record
     Msg: Cardinal;
     fwSide: Cardinal;
     lpRect: PRect;
     Result: Integer;
   end;

 type
   TDatesFrm = class(TForm)
    fr1: TXPGroupBox;
    tx1: TXPLabel;
    tx2: TXPLabel;
    tx4: TXPLabel;
    tx5: TXPLabel;
    ed2: TEdit;
    ed1: TEdit;
    ed3: TEdit;
    ed4: TEdit;
    tx3: TXPLabel;
    ed5: TEdit;
    OK: TXPButton;
    AppEvent: TApplicationEvents;
    Save: TXPButton;
    Print: TXPButton;
    PrintDlg: TPrintDialog;
    TextPrint: TRichEdit;
    tx6: TXPLabel;
    ed6: TEdit;
    ed7: TEdit;
    tx7: TXPLabel;
    tx8: TXPLabel;
    ed8: TEdit;
    procedure AppEventIdle(Sender: TObject; var Done: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private

    R: TRegistry;

    function GetLocaleInformation(Flag: Integer): string;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message mbMessage;

  public

  end;

var
  DatesFrm: TDatesFrm;

  msgCaption: PChar;

implementation

uses NP, OP;

{$R *.dfm}

function GetDomainName: AnsiString;
type
WKSTA_INFO_100 = record
wki100_platform_id: Integer;
wki100_computername: PWideChar;
wki100_langroup: PWideChar;
wki100_ver_major: Integer;
wki100_ver_minor: Integer;
end;
WKSTA_USER_INFO_1 = record
wkui1_username: PChar;
wkui1_logon_domain: PChar;
wkui1_logon_server: PChar;
wkui1_oth_domains: PChar;
end;
type
TWin95_NetUserGetInfo = function(ServerName, UserName: PChar; Level: DWORD; var
BfrPtr: Pointer): Integer;
stdcall;
TWin95_NetApiBufferFree = function(BufPtr: Pointer): Integer;
stdcall;
TWin95_NetWkstaUserGetInfo = function(Reserved: PChar; Level: Integer; var
BufPtr: Pointer): Integer;
stdcall;
TWinNT_NetWkstaGetInfo = function(ServerName: PWideChar; level: Integer; var
BufPtr: Pointer): Integer;
stdcall;
TWinNT_NetApiBufferFree = function(BufPtr: Pointer): Integer;
stdcall;

function IsWinNT: Boolean;
var
VersionInfo: TOSVersionInfo;
begin
VersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
Result := GetVersionEx(VersionInfo);
if Result then
Result := VersionInfo.dwPlatformID = VER_PLATFORM_WIN32_NT;
end;
var
Win95_NetUserGetInfo: TWin95_NetUserGetInfo;
Win95_NetWkstaUserGetInfo: TWin95_NetWkstaUserGetInfo;
Win95_NetApiBufferFree: TWin95_NetApiBufferFree;
WinNT_NetWkstaGetInfo: TWinNT_NetWkstaGetInfo;
WinNT_NetApiBufferFree: TWinNT_NetApiBufferFree;
WSNT: ^WKSTA_INFO_100;
WS95: ^WKSTA_USER_INFO_1;
EC: DWORD;
hNETAPI: THandle;
begin
try
Result := '';
if IsWinNT then
begin
hNETAPI := LoadLibrary('NETAPI32.DLL');
if hNETAPI <> 0 then
begin @WinNT_NetWkstaGetInfo := GetProcAddress(hNETAPI, 'NetWkstaGetInfo');
@WinNT_NetApiBufferFree  := GetProcAddress(hNETAPI, 'NetApiBufferFree');
EC := WinNT_NetWkstaGetInfo(nil, 100, Pointer(WSNT));
if EC = 0 then
begin
Result := WideCharToString(WSNT^.wki100_langroup);
WinNT_NetApiBufferFree(Pointer(WSNT));
end;
end;
end
else
begin
hNETAPI := LoadLibrary('RADMIN32.DLL');
if hNETAPI <> 0 then
begin @Win95_NetApiBufferFree := GetProcAddress(hNETAPI, 'NetApiBufferFree');
@Win95_NetUserGetInfo := GetProcAddress(hNETAPI, 'NetUserGetInfoA');
EC := Win95_NetWkstaUserGetInfo(nil, 1, Pointer(WS95));
if EC = 0 then
begin
Result := WS95^.wkui1_logon_domain;
Win95_NetApiBufferFree(Pointer(WS95));
end;
end;
end;
finally
if hNETAPI <> 0 then
FreeLibrary(hNETAPI);
end;
end;

function GetMACAdress: string;
var
NCB: PNCB;
Adapter: PAdapterStatus;
RetCode: char;
I: integer;
Lenum: PlanaEnum;
SystemID: string;
begin
Result    := '';
SystemID := '';
Getmem(NCB, SizeOf(TNCB));
Fillchar(NCB^, SizeOf(TNCB), 0);
Getmem(Lenum, SizeOf(TLanaEnum));
Fillchar(Lenum^, SizeOf(TLanaEnum), 0);
Getmem(Adapter, SizeOf(TAdapterStatus));
Fillchar(Adapter^, SizeOf(TAdapterStatus), 0);
Lenum.Length    := chr(0);
NCB.ncb_command := chr(NCBENUM);
NCB.ncb_buffer  := Pointer(Lenum);
NCB.ncb_length  := SizeOf(Lenum);
RetCode         := Netbios(NCB);
i := 0;
repeat
Fillchar(NCB^, SizeOf(TNCB), 0);
Ncb.ncb_command  := chr(NCBRESET);
Ncb.ncb_lana_num := lenum.lana[I];
RetCode          := Netbios(Ncb);
Fillchar(NCB^, SizeOf(TNCB), 0);
Ncb.ncb_command  := chr(NCBASTAT);
Ncb.ncb_lana_num := lenum.lana[I];
Ncb.ncb_callname := '*               ';
Ncb.ncb_buffer := Pointer(Adapter);
Ncb.ncb_length := SizeOf(TAdapterStatus);
RetCode        := Netbios(Ncb);
if (RetCode = chr(0)) or (RetCode = chr(6)) then
begin
SystemId := IntToHex(Ord(Adapter.adapter_address[0]), 2) + '-' +
IntToHex(Ord(Adapter.adapter_address[1]), 2) + '-' +
IntToHex(Ord(Adapter.adapter_address[2]), 2) + '-' +
IntToHex(Ord(Adapter.adapter_address[3]), 2) + '-' +
IntToHex(Ord(Adapter.adapter_address[4]), 2) + '-' +
IntToHex(Ord(Adapter.adapter_address[5]), 2);
end;
Inc(i);
until (I >= Ord(Lenum.Length)) or (SystemID <> '00-00-00-00-00-00');
FreeMem(NCB);
FreeMem(Adapter);
FreeMem(Lenum);
GetMacAdress := SystemID;
end;

function GetLocalIP: String;
const WSVer = $101;
var
wsaData: TWSAData;
P: PHostEnt;
Buf: array [0..127] of Char;
begin
Result := '';
if WSAStartup(WSVer, wsaData) = 0 then begin
if GetHostName(@Buf, 128) = 0 then begin
P := GetHostByName(@Buf);
if P <> nil then Result := iNet_ntoa(PInAddr(p^.h_addr_list^)^);
end;
WSACleanup;
end;
end;

function IPAddrToName(IPAddr : string): string;
var
SockAddrIn: TSockAddrIn;
HostEnt: PHostEnt;
WSAData: TWSAData;
begin
WSAStartup($101, WSAData);
SockAddrIn.sin_addr.s_addr:= inet_addr(PChar(IPAddr));
HostEnt:= gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
if HostEnt <> nil then
result := StrPas(Hostent^.h_name)
else
result:='';
end;

function TDatesFrm.GetLocaleInformation(Flag: Integer): string;
var
pcLCA: array [0..20] of Char;
begin
if GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, Flag, pcLCA, 19) <= 0 then
pcLCA[0] := #0;
Result := pcLCA;
end;

procedure TDatesFrm.AppEventIdle(Sender: TObject;
var Done: Boolean);
var
UserName, CompName: array[0..255] of char;
size: dword;
begin
try
ed1.Text := GetLocalIP;
ed2.Text := IPAddrToName(ed1.Text);
size := 55;
if GetUserName(UserName, size) then
ed3.Text := UserName;
ed4.Text := GetDomainName;
ed5.Text := GetMACAdress;
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('\Software\Microsoft\Windows NT\CurrentVersion\NetworkCards\5',false);
ed6.Text := R.ReadString('Description');
size := 55;
if GetComputerName(CompName, size) then
ed7.Text := CompName;
ed8.Text := GetLocaleInformation(LOCALE_SCOUNTRY);
except
end;
end;

procedure TDatesFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
Close;
end;

procedure TDatesFrm.FormDestroy(Sender: TObject);
begin
AppEvent.Free;
PrintDlg.Free;
Print.Free;
Save.Free;
ed1.Free;
ed2.Free;
ed3.Free;
ed4.Free;
ed5.Free;
ed6.Free;
ed7.Free;
ed8.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
tx6.Free;
tx7.Free;
tx8.Free;
fr1.Free;
OK.Free;
end;

procedure TDatesFrm.PrintClick(Sender: TObject);
var
FFileName: String;
begin
TextPrint.Lines.Clear;
TextPrint.Lines.Add('Ethernet адаптер: ' + ed6.Text);
TextPrint.Lines.Add('IP-адрес: ' + ed1.Text);
TextPrint.Lines.Add('Имя компьютера: ' + ed2.Text);
TextPrint.Lines.Add('Имя NET BIOS: ' + ed7.Text);
TextPrint.Lines.Add('Пользователь: ' + ed3.Text);
TextPrint.Lines.Add('Рабочая группа: ' + ed4.Text);
if ed5.Text = '' then
TextPrint.Lines.Add('MAC-адрес: Неопределен') else
TextPrint.Lines.Add('MAC-адрес: ' + ed5.Text);
if PrintDlg.Execute then
TextPrint.Print(FFileName);
end;

procedure TDatesFrm.SaveClick(Sender: TObject);
var
s: String;
begin
try
TextPrint.Lines.Clear;
TextPrint.Lines.Clear;
TextPrint.Lines.Add('Ethernet адаптер: ' + ed6.Text);
TextPrint.Lines.Add('IP-адрес: ' + ed1.Text);
TextPrint.Lines.Add('Имя компьютера: ' + ed2.Text);
TextPrint.Lines.Add('Имя NET BIOS: ' + ed7.Text);
TextPrint.Lines.Add('Пользователь: ' + ed3.Text);
TextPrint.Lines.Add('Рабочая группа: ' + ed4.Text);
if ed5.Text = '' then
TextPrint.Lines.Add('MAC-адрес: Неопределен') else
TextPrint.Lines.Add('MAC-адрес: ' + ed5.Text);
TextPrint.Lines.Add('Местоположение: ' + ed8.Text);
if OpenSaveFileDialog(DatesFrm.Handle, '*.*', 'Текстовые документы (*.txt)|*.txt',
ParamStr(1), 'Сохранить', s, False) then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if FileExists(s) then
if Application.MessageBox(PChar('Файл "' + s +
'" существует.' + #13 + 'Заменить его?'), 'Подтвердите замену',
MB_ICONQUESTION + mb_YesNo) <> idYes then

else
TextPrint.Lines.SaveToFile(s);
if not FileExists(s) then
TextPrint.Lines.SaveToFile(s);
end;
except
end;

end;

procedure TDatesFrm.ChangeMessageBoxPosition(var Msg: TMessage);
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
x := DatesFrm.Left + ((DatesFrm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := DatesFrm.Top + ((DatesFrm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TDatesFrm.WMMoving(var msg: TWMMoving);
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

procedure TDatesFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
OK.SetFocus;
end;

procedure TDatesFrm.FormShow(Sender: TObject);
begin
if SetFrm.ch18.Checked then
begin
SetWindowLong(DatesFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(DatesFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
end;

procedure TDatesFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

end.
