library ShutDownDlg;

uses
  SysUtils,
  Windows,
  Messages,
  Classes;

{$R *.res}

procedure ShowShutDownDialog;
begin
SendMessage(FindWindow('Progman', 'Program Manager'), WM_CLOSE, 0, 0);
end;

exports
ShowShutDownDialog;
end.
 