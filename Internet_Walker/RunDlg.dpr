library RunDlg;

uses
  SysUtils, ComObj,
  Classes;

{$R *.res}

procedure RunProgramDialog;
var
ShellApplication: Variant;
begin
ShellApplication := CreateOleObject('Shell.Application');
ShellApplication.FileRun;
end;

exports
RunProgramDialog;
end.
 