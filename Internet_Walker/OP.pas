unit OP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, XPButton, ExtCtrls, jpeg, XPLabel, XPCheckBox, XPEdit,
  StdCtrls, rmBaseEdit, rmBtnEdit, XPGroupBox, Registry, XPPanel, ShlObj,
  LbSpeedButton, FileCtrl, ImgList, IniFiles, ActiveX, ComObj;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

  const
   AlignCenter = Wm_User + 1024;

  type
   TTabSheet = class(ComCtrls.TTabSheet);

 type
  TSetFrm = class(TForm)
    OK: TXPButton;
    Cancel: TXPButton;
    Apply: TXPButton;
    PageControl: TPageControl;
    GeneralTab: TTabSheet;
    IntTab: TTabSheet;
    WindowTab: TTabSheet;
    ch2: TXPCheckBox;
    ch4: TXPCheckBox;
    ch5: TXPCheckBox;
    ch3: TXPCheckBox;
    ch12: TXPCheckBox;
    ch13: TXPCheckBox;
    ch14: TXPCheckBox;
    ch15: TXPCheckBox;
    ch18: TXPCheckBox;
    ch19: TXPCheckBox;
    ch20: TXPCheckBox;
    ch21: TXPCheckBox;
    ConnectTab: TTabSheet;
    ch7: TXPCheckBox;
    ch8: TXPCheckBox;
    ch9: TXPCheckBox;
    tx4: TXPLabel;
    tx5: TXPLabel;
    tx6: TXPLabel;
    tx7: TXPLabel;
    OptionsTab: TTabSheet;
    ch28: TXPCheckBox;
    ch29: TXPCheckBox;
    ch30: TXPCheckBox;
    ch31: TXPCheckBox;
    ch32: TXPCheckBox;
    ch33: TXPCheckBox;
    ch34: TXPCheckBox;
    ch35: TXPCheckBox;
    InetTab: TTabSheet;
    FullScreenTab: TTabSheet;
    fr3: TXPGroupBox;
    HTMLEditor: TrmBtnEdit;
    fr4: TXPGroupBox;
    DownloadPathEditor: TrmBtnEdit;
    fr7: TXPGroupBox;
    tx9: TXPLabel;
    tx10: TXPLabel;
    tx11: TXPLabel;
    tx13: TXPLabel;
    tx12: TXPLabel;
    ch17: TXPCheckBox;
    fr5: TXPGroupBox;
    HomePageEditor: TXPEdit;
    tx3: TXPLabel;
    SourcePage: TXPButton;
    CurrentPage: TXPButton;
    FindPage: TXPButton;
    EmptyPage: TXPButton;
    tx8: TXPLabel;
    TextName: TXPEdit;
    ch16: TXPCheckBox;
    fr8: TXPGroupBox;
    ch24: TXPCheckBox;
    ch23: TXPCheckBox;
    ch25: TXPCheckBox;
    ch22: TXPCheckBox;
    fr2: TXPGroupBox;
    ch6: TXPCheckBox;
    fr1: TXPGroupBox;
    ch1: TXPCheckBox;
    tx2: TXPLabel;
    tx1: TXPLabel;
    ch26: TXPCheckBox;
    ch27: TXPCheckBox;
    fr9: TXPGroupBox;
    ch37: TXPCheckBox;
    ch36: TXPCheckBox;
    fr11: TXPGroupBox;
    fr10: TXPGroupBox;
    ch38: TXPCheckBox;
    ch39: TXPCheckBox;
    fr6: TXPGroupBox;
    ch11: TXPCheckBox;
    ch10: TXPCheckBox;
    ch40: TXPCheckBox;

    procedure HTMLEditorBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SourcePageClick(Sender: TObject);
    procedure CurrentPageClick(Sender: TObject);
    procedure FindPageClick(Sender: TObject);
    procedure EmptyPageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TextNameChange(Sender: TObject);
    procedure tx9Click(Sender: TObject);
    procedure tx10Click(Sender: TObject);
    procedure tx11Click(Sender: TObject);
    procedure tx12Click(Sender: TObject);
    procedure tx13Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure OKClick(Sender: TObject);

  private

    LinkFile:IPersistFile;

    ShellObject:IUnknown;

    ShellLink:IShellLink;

    FileName,ShortcutPosition:string;

    WShortcutPosition:WideString;

    P:PItemIDList;

    C:array[0..1000] of char;

    R: TRegistry;

    s: String;

    Flag: OleVariant;

  public

    FColor: TColor;

    Ini : TIniFile;

    procedure SetColor(Value: TColor);

    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); 
    message WM_ERASEBKGND;

    constructor Create(aOwner: TComponent); override;
    property Color: TColor read FColor write SetColor;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  SetFrm: TSetFrm;

  msgCaption: PChar;

implementation

uses NP, AP, AddHTML, YDP, IMPPR, LP, ListLink, OpenAddress, ListFav, MyPrinter, SP, AddFav;

{$R *.dfm}

procedure TSetFrm.HTMLEditorBtn1Click(Sender: TObject);
var
s: String;
begin
if OpenSaveFileDialog(Handle,
'*.exe', 'OS (*.exe; *.bat; *.cmd; *.com)|*.exe; *.bat; *.cmd; *.com;|All files (*.*)|*.*', ParamStr(1),
'', s, True) then
begin
HTMLEditor.Text := s;
end;
end;

procedure TSetFrm.FormShow(Sender: TObject);
var
i: Integer;
begin
PageControl.ActivePageIndex := 0;
if SetFrm.ch18.Checked then
begin
SetWindowLong(SetFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(SetFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Запретить доступ к свойствам Internet Explorer
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Restrictions');
if r.ValueExists('NoBrowserOptions')
then i:=r.ReadInteger('NoBrowserOptions');
if i=0 then
ch28.Checked:=False else
ch28.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Общие" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('GeneralTab')
then i:=r.ReadInteger('GeneralTab');
if i=0 then
ch29.Checked:=False else
ch29.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Безопасность" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('SecurityTab')
then i:=r.ReadInteger('SecurityTab');
if i=0 then
ch30.Checked:=False else
ch30.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Конфиденциальность" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('PrivacyTab')
then i:=r.ReadInteger('PrivacyTab');
if i=0 then
ch31.Checked:=False else
ch31.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Содержание" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('ContentTab')
then i:=r.ReadInteger('ContentTab');
if i=0 then
ch32.Checked:=False else
ch32.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Подключения" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('ConnectionsTab')
then i:=r.ReadInteger('ConnectionsTab');
if i=0 then
ch33.Checked:=False else
ch33.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Программы" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('ProgramsTab')
then i:=r.ReadInteger('ProgramsTab');
if i=0 then
ch34.Checked:=False else
ch34.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Дополнительно" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('AdvancedTab')
then i:=r.ReadInteger('AdvancedTab');
if i=0 then
ch35.Checked:=False else
ch35.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Запретить изменения на вкладке "Дополнительно" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('Advanced')
then i:=r.ReadInteger('Advanced');
if i=0 then
ch36.Checked:=False else
ch36.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Запретить доступ к настройке параметров временных файлов
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('Settings')
then i:=r.ReadInteger('Settings');
if i=0 then
ch37.Checked:=False else
ch37.Checked:=True;
r.CloseKey;
r.Free;
//Иконки на рабочем столе: Internet Explorer (Classic Style)
r := TRegistry.Create;
r.RootKey := HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu');
if r.ValueExists('{871C5380-42A0-1069-A2EA-08002B30309D}')
then i:=r.ReadInteger('{871C5380-42A0-1069-A2EA-08002B30309D}');
if i=1 then
ch17.Checked:=False else
ch17.Checked:=True;
r.CloseKey;
r.Free;
//Иконки на рабочем столе: Internet Explorer (XP Style)
r := TRegistry.Create;
r.RootKey := HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel');
if r.ValueExists('{871C5380-42A0-1069-A2EA-08002B30309D}')
then i:=r.ReadInteger('{871C5380-42A0-1069-A2EA-08002B30309D}');
if i=1 then
ch17.Checked:=False else
ch17.Checked:=True;
r.CloseKey;
r.Free;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_CLASSES_ROOT;
if not r.KeyExists
('\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\Shell\Internet Walker\Command') then
ch15.Checked := False else
ch15.Checked := True;
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_LOCAL_MACHINE;
if not R.KeyExists
('\Software\Microsoft\Internet Explorer\Extensions\{088FBAE7-3F6D-440E-8FC7-1F7FF666B824}\') then
ch14.Checked := False else
ch14.Checked := True;
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_CLASSES_ROOT;
if not KeyExists
('\Directory\Shell\Internet Walker\Command\') then
ch13.Checked := False else
ch13.Checked := True;
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_CLASSES_ROOT;
if not r.KeyExists
('\*\Shell\Internet Walker\Command\')then
ch12.Checked := False else
ch12.Checked := True;
CloseKey;
Free;
end;
r:=TRegistry.Create;
r.RootKey := HKEY_LOCAL_MACHINE;
//Не сканировать сеть на наличие сетевых принтеров
if r.KeyExists
('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{2227A280-3AEA-1069-A2DE-08002B30309D}') then
ch10.Checked := False else
ch10.Checked := True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey := HKEY_LOCAL_MACHINE;
//Не сканировать сеть на наличие назначенных заданий (Scheduled Tasks)
if r.KeyExists
('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}') then
ch11.Checked := False else
ch11.Checked := True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
//Автоматически определять MTU
r.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters');
if r.ValueExists('EnablePMTUDiscovery')
then i:=r.ReadInteger('EnablePMTUDiscovery');
if i=0 then
ch7.Checked:=False else
ch7.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
//Включить поддержку TCP окон больше 64Кб
r.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters');
if r.ValueExists('Tcp1323Opts')
then i:=r.ReadInteger('Tcp1323Opts');
if i=0 then
ch8.Checked:=False else
ch8.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
//Выборочная передача поврежденных данных
r.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters');
if r.ValueExists('SackOpts')
then i:=r.ReadInteger('SackOpts');
if i=0 then
ch9.Checked:=False else
ch9.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Не выводить окно "Подключение удаленного доступа" при автономной работе
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Internet Settings');
if r.ValueExists('EnableAutodial')
then i:=r.ReadInteger('EnableAutodial');
if i=1 then
ch6.Checked:=False else
ch6.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Путь к папке закачек по умолчанию
r.OpenKeyReadOnly('\Software\Microsoft\Internet Explorer');
DownloadPathEditor.Text := r.ReadString('Download Directory');
r.CloseKey;
r.Free;
Flag := 0;
R := TRegistry.Create;
R.RootKey:=HKEY_CURRENT_USER;
if R.KeyExists('\Software\Microsoft\Internet Explorer\Main')
then begin
R.OpenKey('\Software\Microsoft\Internet Explorer\Main',true);
HomePageEditor.Text:= R.ReadString('Start Page');
r.CloseKey;
r.Free;
end;
R:=TRegistry.Create;
R.RootKey:=HKEY_LOCAL_MACHINE;
R.OpenKeyReadOnly('\SOFTWARE\Microsoft\Internet Explorer\View Source Editor\Editor Name');
HTMLEditor.Text := R.ReadString('');
R.CloseKey;
r.Free;
end;

procedure TSetFrm.SourcePageClick(Sender: TObject);
begin
HomePageEditor.Text :=
'http://go.microsoft.com/fwlink/?LinkId=69157';
end;

procedure TSetFrm.CurrentPageClick(Sender: TObject);
begin
HomePageEditor.Text := MainFrm.edURL.Text;
R.WriteString('Start Page', HomePageEditor.Text);
end;

procedure TSetFrm.FindPageClick(Sender: TObject);
begin
if OpenSaveFileDialog(Handle, '*.html',
'Файлы HTML|*.htm;*.html|Графические файлы|*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf|Документы Ms WORD|*.rtf; *.doc|Документы Ms EXCEL|*.xls|Текстовые документы|*.txt|XML файлы|*.xml|Веб-архив|*.mht|Все ресурсы|*.*', ParamStr(1),
'Notepad SE', s, True) then
begin
HomePageEditor.Text := s;
R.WriteString('Start Page', HomePageEditor.Text);
end;
end;

procedure TSetFrm.EmptyPageClick(Sender: TObject);
begin
HomePageEditor.Text := 'about:blank';
end;

constructor TSetFrm.Create(aOwner: TComponent);
begin
inherited;
FColor := clWhite;
end;

procedure TSetFrm.SetColor(Value: TColor);
begin
if FColor = Value then
begin
FColor := Value;
Invalidate;
end;
end;

procedure TSetFrm.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
if FColor = clWhite then
inherited else
begin
Brush.Color := FColor;
Windows.FillRect(Msg.dc, ClientRect, Brush.Handle);
Msg.Result := 1;
end;
end;

procedure TSetFrm.FormCreate(Sender: TObject);
begin
try
Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
ch1.Checked := Ini.ReadBool('Parameters', 'Internet Walker XP MENU', ch1.Checked);
ch2.Checked := Ini.ReadBool('Parameters', 'Run with Windows OS startup', ch2.Checked);
ch3.Checked := Ini.ReadBool('Parameters', 'More tabs confirm exit', ch3.Checked);
ch4.Checked := Ini.ReadBool('Parameters', 'Show hint', ch4.Checked);
ch5.Checked := Ini.ReadBool('Parameters', 'Confirmation exit', ch5.Checked);
TextName.Text := Ini.ReadString('Parameters', 'Shortcut name', TextName.Text);
ch16.Checked := Ini.ReadBool('Parameters', 'Hide message on creating shortcut', ch16.Checked);
ch18.Checked := Ini.ReadBool('Parameters', 'Modal windows on task bar', ch18.Checked);
ch19.Checked := Ini.ReadBool('Parameters', 'Move for the client area', ch19.Checked);
ch20.Checked := Ini.ReadBool('Parameters', 'Screen snap', ch20.Checked);
ch21.Checked := Ini.ReadBool('Parameters', 'Windows only in client area', ch21.Checked);
ch22.Checked := Ini.ReadBool('Parameters', 'Animation', ch22.Checked);
ch23.Checked := Ini.ReadBool('Parameters', 'Restore from tray on double click', ch23.Checked);
ch24.Checked := Ini.ReadBool('Parameters', 'Minimize to tray', ch24.Checked);
ch25.Checked := Ini.ReadBool('Parameters', 'Show icon in tray only at minimzie', ch25.Checked);
ch26.Checked := Ini.ReadBool('Parameters', 'Save window size', ch26.Checked);
ch27.Checked := Ini.ReadBool('Parameters', 'Save window position', ch27.Checked);
ch38.Checked := Ini.ReadBool('Parameters', 'Full screen on run', ch38.Checked);
ch39.Checked := Ini.ReadBool('Parameters', 'Full screen on open file', ch39.Checked);
ch40.Checked := Ini.ReadBool('Parameters', 'Minimize to tray at closed', ch40.Checked);
except
end;
end;

procedure TSetFrm.TextNameChange(Sender: TObject);
begin
Ini.WriteString('Parameters', 'Shortcut name', TextName.Text);
end;

procedure TSetFrm.tx9Click(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_DESKTOP,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
PostMessage(Handle, WM_USER + 1024, 0, 0);
if not ch16.Checked then
if Application.MessageBox(PChar('Вы хотите разместить ярлык "' + TextName.Text + '" на Рабочем Столе?'),
'Создание ярлыка',
Mb_IconQuestion + mb_YesNo) = IdYes then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
if ch16.Checked then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TSetFrm.tx10Click(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_STARTMENU,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
PostMessage(Handle, WM_USER + 1024, 0, 0);
if not ch16.Checked then
if Application.MessageBox(PChar('Вы хотите разместить ярлык "' + TextName.Text + '" в Главном Меню?'),
'Создание ярлыка',
Mb_IconQuestion + mb_YesNo) = IdYes then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
if ch16.Checked then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TSetFrm.tx11Click(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_PROGRAMS,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
PostMessage(Handle, WM_USER + 1024, 0, 0);
if not ch16.Checked then
if Application.MessageBox(PChar('Вы хотите разместить ярлык "' + TextName.Text + '" в Меню Программы?'),
'Создание ярлыка',
Mb_IconQuestion + mb_YesNo) = IdYes then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
if ch16.Checked then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TSetFrm.tx12Click(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_STARTUP,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
PostMessage(Handle, WM_USER + 1024, 0, 0);
if not ch16.Checked then
if Application.MessageBox(PChar('Вы хотите разместить ярлык "' + TextName.Text + '" в папке Автозагрузки?'),
'Создание ярлыка',
Mb_IconQuestion + mb_YesNo) = IdYes then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
if ch16.Checked then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TSetFrm.tx13Click(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_FAVORITES,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
PostMessage(Handle, WM_USER + 1024, 0, 0);
if not ch16.Checked then
if Application.MessageBox(PChar('Вы хотите разместить ярлык "' + TextName.Text + '" в Избранном?'),
'Создание ярлыка',
Mb_IconQuestion + mb_YesNo) = IdYes then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
if ch16.Checked then
ShortcutPosition:=ShortcutPosition+'\'+ TextName.Text + '.lnk';
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TSetFrm.ChangeMessageBoxPosition(var Msg: TMessage);
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
x := SetFrm.Left + ((SetFrm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := SetFrm.Top + ((SetFrm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TSetFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TSetFrm.WMMoving(var msg: TWMMoving);
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

procedure TSetFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cancel.OnClick(Self);
Cancel.SetFocus;
end;

procedure TSetFrm.FormDestroy(Sender: TObject);
begin
PageControl.Free;
Apply.Free;
Cancel.Free;
OK.Free;
HTMLEditor.Free;
DownloadPathEditor.Free;
HomePageEditor.Free;
SourcePage.Free;
CurrentPage.Free;
FindPage.Free;
EmptyPage.Free;
TextName.Free;
fr1.Free;
fr2.Free;
fr3.Free;
fr4.Free;
fr5.Free;
fr6.Free;
fr7.Free;
fr8.Free;
fr9.Free;
fr10.Free;
fr11.Free;
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
tx11.Free;
tx12.Free;
tx13.Free;
Ini.Free;
ch1.Free;
ch2.Free;
ch3.Free;
ch4.Free;
ch5.Free;
ch6.Free;
ch7.Free;
ch8.Free;
ch9.Free;
ch10.Free;
ch11.Free;
ch12.Free;
ch13.Free;
ch14.Free;
ch15.Free;
ch16.Free;
ch17.Free;
ch18.Free;
ch19.Free;
ch20.Free;
ch21.Free;
ch22.Free;
ch23.Free;
ch24.Free;
ch25.Free;
ch26.Free;
ch27.Free;
ch28.Free;
ch29.Free;
ch30.Free;
ch31.Free;
ch32.Free;
ch33.Free;
ch34.Free;
ch35.Free;
ch36.Free;
ch37.Free;
ch38.Free;
ch39.Free;
ch40.Free;
end;

procedure TSetFrm.CancelClick(Sender: TObject);
var
i: Integer;
begin
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Запретить доступ к свойствам Internet Explorer
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Restrictions');
if r.ValueExists('NoBrowserOptions')
then i:=r.ReadInteger('NoBrowserOptions');
if i=0 then
ch28.Checked:=False else
ch28.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Общие" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('GeneralTab')
then i:=r.ReadInteger('GeneralTab');
if i=0 then
ch29.Checked:=False else
ch29.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Безопасность" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('SecurityTab')
then i:=r.ReadInteger('SecurityTab');
if i=0 then
ch30.Checked:=False else
ch30.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Конфиденциальность" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('PrivacyTab')
then i:=r.ReadInteger('PrivacyTab');
if i=0 then
ch31.Checked:=False else
ch31.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Содержание" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('ContentTab')
then i:=r.ReadInteger('ContentTab');
if i=0 then
ch32.Checked:=False else
ch32.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Подключения" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('ConnectionsTab')
then i:=r.ReadInteger('ConnectionsTab');
if i=0 then
ch33.Checked:=False else
ch33.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Программы" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('ProgramsTab')
then i:=r.ReadInteger('ProgramsTab');
if i=0 then
ch34.Checked:=False else
ch34.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Скрыть вкладку "Дополнительно" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('AdvancedTab')
then i:=r.ReadInteger('AdvancedTab');
if i=0 then
ch35.Checked:=False else
ch35.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Запретить изменения на вкладке "Дополнительно" в свойствах обозревателя
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('Advanced')
then i:=r.ReadInteger('Advanced');
if i=0 then
ch36.Checked:=False else
ch36.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Запретить доступ к настройке параметров временных файлов
r.OpenKeyReadOnly('\Software\Policies\Microsoft\Internet Explorer\Control Panel');
if r.ValueExists('Settings')
then i:=r.ReadInteger('Settings');
if i=0 then
ch37.Checked:=False else
ch37.Checked:=True;
r.CloseKey;
r.Free;
//Иконки на рабочем столе: Internet Explorer (Classic Style)
r := TRegistry.Create;
r.RootKey := HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu');
if r.ValueExists('{871C5380-42A0-1069-A2EA-08002B30309D}')
then i:=r.ReadInteger('{871C5380-42A0-1069-A2EA-08002B30309D}');
if i=1 then
ch17.Checked:=False else
ch17.Checked:=True;
r.CloseKey;
r.Free;
//Иконки на рабочем столе: Internet Explorer (XP Style)
r := TRegistry.Create;
r.RootKey := HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel');
if r.ValueExists('{871C5380-42A0-1069-A2EA-08002B30309D}')
then i:=r.ReadInteger('{871C5380-42A0-1069-A2EA-08002B30309D}');
if i=1 then
ch17.Checked:=False else
ch17.Checked:=True;
r.CloseKey;
r.Free;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_CLASSES_ROOT;
if not r.KeyExists
('\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\Shell\Internet Walker\Command') then
ch15.Checked := False else
ch15.Checked := True;
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_LOCAL_MACHINE;
if not R.KeyExists
('\Software\Microsoft\Internet Explorer\Extensions\{088FBAE7-3F6D-440E-8FC7-1F7FF666B824}\') then
ch14.Checked := False else
ch14.Checked := True;
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_CLASSES_ROOT;
if not KeyExists
('\Directory\Shell\Internet Walker\Command\') then
ch13.Checked := False else
ch13.Checked := True;
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do begin
RootKey := HKEY_CLASSES_ROOT;
if not r.KeyExists
('\*\Shell\Internet Walker\Command\')then
ch12.Checked := False else
ch12.Checked := True;
CloseKey;
Free;
end;
r:=TRegistry.Create;
r.RootKey := HKEY_LOCAL_MACHINE;
//Не сканировать сеть на наличие сетевых принтеров
if r.KeyExists
('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{2227A280-3AEA-1069-A2DE-08002B30309D}') then
ch10.Checked := False else
ch10.Checked := True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey := HKEY_LOCAL_MACHINE;
//Не сканировать сеть на наличие назначенных заданий (Scheduled Tasks)
if r.KeyExists
('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}') then
ch11.Checked := False else
ch11.Checked := True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
//Автоматически определять MTU
r.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters');
if r.ValueExists('EnablePMTUDiscovery')
then i:=r.ReadInteger('EnablePMTUDiscovery');
if i=0 then
ch7.Checked:=False else
ch7.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
//Включить поддержку TCP окон больше 64Кб
r.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters');
if r.ValueExists('Tcp1323Opts')
then i:=r.ReadInteger('Tcp1323Opts');
if i=0 then
ch8.Checked:=False else
ch8.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:= HKEY_LOCAL_MACHINE;
//Выборочная передача поврежденных данных
r.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters');
if r.ValueExists('SackOpts')
then i:=r.ReadInteger('SackOpts');
if i=0 then
ch9.Checked:=False else
ch9.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Не выводить окно "Подключение удаленного доступа" при автономной работе
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Internet Settings');
if r.ValueExists('EnableAutodial')
then i:=r.ReadInteger('EnableAutodial');
if i=1 then
ch6.Checked:=False else
ch6.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
//Путь к папке закачек по умолчанию
r.OpenKeyReadOnly('\Software\Microsoft\Internet Explorer');
DownloadPathEditor.Text := r.ReadString('Download Directory');
r.CloseKey;
r.Free;
Flag := 0;
R := TRegistry.Create;
R.RootKey:=HKEY_CURRENT_USER;
if R.KeyExists('\Software\Microsoft\Internet Explorer\Main')
then begin
R.OpenKey('\Software\Microsoft\Internet Explorer\Main',true);
HomePageEditor.Text:= R.ReadString('Start Page');
r.CloseKey;
r.Free;
end;
R:=TRegistry.Create;
R.RootKey:=HKEY_LOCAL_MACHINE;
R.OpenKeyReadOnly('\SOFTWARE\Microsoft\Internet Explorer\View Source Editor\Editor Name');
HTMLEditor.Text := R.ReadString('');
R.CloseKey;
r.Free;
ch1.Checked := Ini.ReadBool('Parameters', 'Internet Walker XP MENU', ch1.Checked);
ch2.Checked := Ini.ReadBool('Parameters', 'Run with Windows OS startup', ch2.Checked);
ch3.Checked := Ini.ReadBool('Parameters', 'More tabs confirm exit', ch3.Checked);
ch4.Checked := Ini.ReadBool('Parameters', 'Show hint', ch4.Checked);
ch5.Checked := Ini.ReadBool('Parameters', 'Confirmation exit', ch5.Checked);
TextName.Text := Ini.ReadString('Parameters', 'Shortcut name', TextName.Text);
ch16.Checked := Ini.ReadBool('Parameters', 'Hide message on creating shortcut', ch16.Checked);
ch18.Checked := Ini.ReadBool('Parameters', 'Modal windows on task bar', ch18.Checked);
ch19.Checked := Ini.ReadBool('Parameters', 'Move for the client area', ch19.Checked);
ch20.Checked := Ini.ReadBool('Parameters', 'Screen snap', ch20.Checked);
ch21.Checked := Ini.ReadBool('Parameters', 'Windows only in client area', ch21.Checked);
ch22.Checked := Ini.ReadBool('Parameters', 'Animation', ch22.Checked);
ch23.Checked := Ini.ReadBool('Parameters', 'Restore from tray on double click', ch23.Checked);
ch24.Checked := Ini.ReadBool('Parameters', 'Minimize to tray', ch24.Checked);
ch25.Checked := Ini.ReadBool('Parameters', 'Show icon in tray only at minimzie', ch25.Checked);
ch26.Checked := Ini.ReadBool('Parameters', 'Save window size', ch26.Checked);
ch27.Checked := Ini.ReadBool('Parameters', 'Save window position', ch27.Checked);
ch38.Checked := Ini.ReadBool('Parameters', 'Full screen on run', ch38.Checked);
ch39.Checked := Ini.ReadBool('Parameters', 'Full screen on open file', ch39.Checked);
ch40.Checked := Ini.ReadBool('Parameters', 'Minimize to tray at closed', ch40.Checked);
end;

procedure TSetFrm.ApplyClick(Sender: TObject);
const
TagID = '\{088FBAE7-3F6D-440E-8FC7-1F7FF666B824}\';
var
ProgramPath: string;
RegKeyPath: string;
begin
//Запретить доступ к свойствам Internet Explorer
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Restrictions', True);
if ch28.Checked then
WriteInteger('NoBrowserOptions', 1) else
WriteInteger('NoBrowserOptions', 0);
CloseKey;
Free;
end;
//Скрыть вкладку "Общие" в свойствах обозревателя
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch29.Checked then
WriteInteger('GeneralTab', 1) else
WriteInteger('GeneralTab', 0);
CloseKey;
Free;
end;
//Скрыть вкладку "Безопасность"
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch30.Checked then
WriteInteger('SecurityTab', 1) else
WriteInteger('SecurityTab', 0);
CloseKey;
Free;
end;
//Скрыть вкладку "Конфиденциальность"
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch31.Checked then
WriteInteger('PrivacyTab', 1) else
WriteInteger('PrivacyTab', 0);
CloseKey;
Free;
end;
//Скрыть вкладку "Содержание"
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch32.Checked then
WriteInteger('ContentTab', 1) else
WriteInteger('ContentTab', 0);
CloseKey;
Free;
end;
//Скрыть вкладку "Подключения"
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch33.Checked then
WriteInteger('ConnectionsTab', 1) else
WriteInteger('ConnectionsTab', 0);
CloseKey;
Free;
end;
//Скрыть вкладку "Программы"
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch34.Checked then
WriteInteger('ProgramsTab', 1) else
WriteInteger('ProgramsTab', 0);
CloseKey;
Free;
end;
//Скрыть вкладку "Дополнительно"
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch35.Checked then
WriteInteger('AdvancedTab', 1) else
WriteInteger('AdvancedTab', 0);
CloseKey;
Free;
end;
//Запретить изменения на вкладке "Дополнительно"
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch36.Checked then
WriteInteger('Advanced', 1) else
WriteInteger('Advanced', 0);
CloseKey;
Free;
end;
//Запретить доступ к настройке параметров временных файлов
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
if ch37.Checked then
WriteInteger('Settings', 1) else
WriteInteger('Settings', 0);
CloseKey;
Free;
end;
if ch20.Checked then
begin
MainFrm.ScreenSnap := True;
AboutFrm.ScreenSnap := True;
AddFavFrm.ScreenSnap := True;
AddHTMLFrm.ScreenSnap := True;
DatesFrm.ScreenSnap := True;
ImportFrm.ScreenSnap := True;
LicFrm.ScreenSnap := True;
LinksFrm.ScreenSnap := True;
LinksFrm.ScreenSnap := True;
OpenFrm.ScreenSnap := True;
OrgFavFrm.ScreenSnap := True;
PrintFrm.ScreenSnap := True;
ScreenLogoFrm.ScreenSnap := True;
SetFrm.ScreenSnap := True;
end else
begin
MainFrm.ScreenSnap := False;
AboutFrm.ScreenSnap := False;
AddFavFrm.ScreenSnap := False;
AddHTMLFrm.ScreenSnap := False;
DatesFrm.ScreenSnap := False;
ImportFrm.ScreenSnap := False;
LicFrm.ScreenSnap := False;
LinksFrm.ScreenSnap := False;
LinksFrm.ScreenSnap := False;
OpenFrm.ScreenSnap := False;
OrgFavFrm.ScreenSnap := False;
PrintFrm.ScreenSnap := False;
ScreenLogoFrm.ScreenSnap := False;
SetFrm.ScreenSnap := False;
end;
if SetFrm.ch20.Checked then
begin
MainFrm.ShowHint := True;
AboutFrm.ShowHint := True;
AddFavFrm.ShowHint := True;
AddHTMLFrm.ShowHint := True;
DatesFrm.ShowHint := True;
ImportFrm.ShowHint := True;
LicFrm.ShowHint := True;
LinksFrm.ShowHint := True;
LinksFrm.ShowHint := True;
OpenFrm.ShowHint := True;
OrgFavFrm.ShowHint := True;
PrintFrm.ShowHint := True;
ScreenLogoFrm.ShowHint := True;
SetFrm.ShowHint := True;
end else
begin
MainFrm.ShowHint := False;
AboutFrm.ShowHint := False;
AddFavFrm.ShowHint := False;
AddHTMLFrm.ShowHint := False;
DatesFrm.ShowHint := False;
ImportFrm.ShowHint := False;
LicFrm.ShowHint := False;
LinksFrm.ShowHint := False;
LinksFrm.ShowHint := False;
OpenFrm.ShowHint := False;
OrgFavFrm.ShowHint := False;
PrintFrm.ShowHint := False;
ScreenLogoFrm.ShowHint := False;
SetFrm.ShowHint := False;
end;
//Иконки на рабочем столе: Internet Explorer (Classic Style)
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu', True);
if ch17.Checked then
WriteInteger('{871C5380-42A0-1069-A2EA-08002B30309D}', 0) else
WriteInteger('{871C5380-42A0-1069-A2EA-08002B30309D}', 1);
CloseKey;
Free;
end;
//Иконки на рабочем столе: Internet Explorer (XP Style)
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel', True);
if ch17.Checked then
WriteInteger('{871C5380-42A0-1069-A2EA-08002B30309D}', 0) else
WriteInteger('{871C5380-42A0-1069-A2EA-08002B30309D}', 1);
CloseKey;
Free;
end;
R:=TRegistry.Create;
R.RootKey:=HKEY_CLASSES_ROOT;
if R.OpenKey('\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\Shell\Internet Walker\Command', True) then
if ch15.Checked then
R.WriteString('', ParamStr(0)) else
R.DeleteKey('\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\Shell\Internet Walker');
R.CloseKey;
R.Free;
ProgramPath := Application.ExeName;
R := TRegistry.Create;
try
with R do begin
RootKey := HKEY_LOCAL_MACHINE;
RegKeyPath := 'Software\Microsoft\Internet Explorer\Extensions';
OpenKey(RegKeyPath + TagID, True);
WriteString('ButtonText', 'Internet Walker');
WriteString('MenuText', 'Internet Walker');
WriteString('MenuStatusBar', 'Internet Walker');
WriteString('ClSid', '{1FBA04EE-3024-11d2-8F1F-0000F87ABD16}');
WriteString('Default Visible', 'Yes');
WriteString('Exec', ProgramPath);
WriteString('HotIcon', ',4');
WriteString('Icon', ',5');
end
finally
if not ch14.Checked then
R.DeleteKey
('\Software\Microsoft\Internet Explorer\Extensions\{088FBAE7-3F6D-440E-8FC7-1F7FF666B824}\');
R.CloseKey;
R.Free;
end;
if ch13.Checked then
begin
R:= TRegistry.Create;
R.RootKey := HKEY_CLASSES_ROOT;
R.OpenKey('\Directory\Shell\Internet Walker\',true);
R.WriteString('','Internet Walker');
R.WriteString('', 'Internet Walker');
R.CloseKey;
R.OpenKey('\Directory\Shell\Internet Walker\command',true);
R.WriteString('','command');
R.WriteString('',paramstr(0)+' "1%"');
R.CloseKey;
R.Free;
end else
if not ch13.Checked then
begin
R:= TRegistry.Create;
R.RootKey := HKEY_CLASSES_ROOT;
R.DeleteKey('\Directory\Shell\Internet Walker');
R.CloseKey;
R.Free;
end;
if ch12.Checked then
begin
R:= TRegistry.Create;
R.RootKey := HKEY_CLASSES_ROOT;
R.OpenKey('*\Shell\Internet Walker',true);
R.WriteString('','Internet Walker');
R.WriteString('', 'Internet Walker');
R.CloseKey;
R.OpenKey('*\Shell\Internet Walker\command',true);
R.WriteString('','command');
R.WriteString('',paramstr(0)+' "1%"');
R.CloseKey;
R.Free;
end else
if not ch12.Checked then
begin
R:= TRegistry.Create;
R.RootKey := HKEY_CLASSES_ROOT;
R.DeleteKey('*\Shell\Internet Walker');
R.CloseKey;
R.Free;
end;
//Не сканировать сеть на наличие сетевых принтеров
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_LOCAL_MACHINE;
if ch10.Checked then
DeleteKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{2227A280-3AEA-1069-A2DE-08002B30309D}') else
OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{2227A280-3AEA-1069-A2DE-08002B30309D}', True);
CloseKey;
Free;
end;
//Не сканировать сеть на наличие назначенных заданий (Scheduled Tasks)
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_LOCAL_MACHINE;
if ch11.Checked then
DeleteKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}') else
OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}', True);
CloseKey;
Free;
end;
//Автоматически определять MTU
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_LOCAL_MACHINE;
OpenKey('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters', True);
if ch7.Checked then
WriteInteger('EnablePMTUDiscovery', 1) else
WriteInteger('EnablePMTUDiscovery', 0);
CloseKey;
Free;
end;
//Включить поддержку TCP окон больше 64Кб
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_LOCAL_MACHINE;
OpenKey('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters', True);
if ch8.Checked then
WriteInteger('Tcp1323Opts', 1) else
WriteInteger('Tcp1323Opts', 0);
CloseKey;
Free;
end;
//Выборочная передача поврежденных данных
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_LOCAL_MACHINE;
OpenKey('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters', True);
if ch9.Checked then
WriteInteger('SackOpts', 1) else
WriteInteger('SackOpts', 0);
CloseKey;
Free;
end;
//Не выводить окно "Подключение удаленного доступа" при автономной работе
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', True);
if ch6.Checked then
r.WriteInteger('EnableAutodial', 0) else
r.WriteInteger('EnableAutodial', 1);
CloseKey;
Free;
end;
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if ch2.Checked then
R.WriteString(Application.Title, ParamStr(0)) else
R.DeleteValue(Application.Title);
R.Free;
//Путь к папке закачек по умолчанию
R := TRegistry.Create;
with R do
begin
RootKey:=HKEY_CURRENT_USER;
if OpenKey('\Software\Microsoft\Internet Explorer', True) then
begin
WriteString('Download Directory', DownloadPathEditor.Text);
CloseKey;
Free;
end;
end;
R := TRegistry.Create;
with R do
begin
RootKey:=HKEY_LOCAL_MACHINE;
if OpenKey('\Software\Microsoft\Internet Explorer\View Source Editor\Editor Name', True) then
begin
WriteString('', HTMLEditor.Text);
CloseKey;
Free;
end;
end;
Flag := 0;
R := TRegistry.Create;
R.RootKey:=HKEY_CURRENT_USER;
if R.KeyExists('\Software\Microsoft\Internet Explorer\Main') then
begin
R.OpenKey('\Software\Microsoft\Internet Explorer\Main',true);
R.WriteString('Start Page', HomePageEditor.Text);
end;
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if ch2.Checked then
R.WriteString(Application.Title, ParamStr(0)) else
R.DeleteValue(Application.Title);
R.Free;
Ini.WriteBool('Parameters', 'Internet Walker XP MENU', ch1.Checked);
Ini.WriteBool('Parameters', 'Run with Windows OS startup', ch2.Checked);
Ini.WriteBool('Parameters', 'More tabs confirm exit', ch3.Checked);
Ini.WriteBool('Parameters', 'Show hint', ch4.Checked);
Ini.WriteBool('Parameters', 'Confirmation exit', ch5.Checked);
Ini.WriteBool('Parameters', 'Hide message on creating shortcut', ch16.Checked);
Ini.WriteBool('Parameters', 'Modal windows on task bar', ch18.Checked);
Ini.WriteBool('Parameters', 'Move for the client area', ch19.Checked);
Ini.WriteBool('Parameters', 'Screen snap', ch20.Checked);
Ini.WriteBool('Parameters', 'Windows only in client area', ch21.Checked);
Ini.WriteBool('Parameters', 'Animation', ch22.Checked);
Ini.WriteBool('Parameters', 'Restore from tray on double click', ch23.Checked);
Ini.WriteBool('Parameters', 'Minimize to tray', ch24.Checked);
Ini.WriteBool('Parameters', 'Show icon in tray only at minimzie', ch25.Checked);
Ini.WriteBool('Parameters', 'Save window size', ch26.Checked);
Ini.WriteBool('Parameters', 'Save window position', ch27.Checked);
Ini.WriteBool('Parameters', 'Full screen on run', ch38.Checked);
Ini.WriteBool('Parameters', 'Full screen on open file', ch39.Checked);
Ini.WriteBool('Parameters', 'Minimize to tray at closed', ch40.Checked);
end;

procedure TSetFrm.OKClick(Sender: TObject);
begin
Apply.OnClick(Self);
end;

end.
