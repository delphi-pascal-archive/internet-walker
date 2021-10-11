library CheckIC;

uses
  Windows, Forms, WinInet;

{$R *.res}

procedure CheckInetConnect;
const
INTERNET_CONNECTION_MODEM = 1;
INTERNET_CONNECTION_LAN   = 2;
INTERNET_CONNECTdState = 3;
var
dwConnectionTypes: DWORD;
begin
dwConnectionTypes:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTdState;
if InternetGetConnectedState(@dwConnectionTypes,0) then
Application.MessageBox('Есть соединение.',
'Проверка соединения',
mb_IconAsterisk + mb_Ok)
else
Application.MessageBox('Нет соединения.',
'Проверка соединения',
mb_IconAsterisk + mb_Ok);
end;

exports
CheckInetConnect;
end.
 