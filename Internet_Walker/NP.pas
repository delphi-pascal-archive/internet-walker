unit NP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, Menus, ImgList, OleCtrls, SHDocVw, ComCtrls, StdCtrls,
  ExtCtrls, ToolWin, XPLabel, Buttons, XPPanel,
 XpMan,
  WBFuncs,  HistoryMenu, ActiveX, ClipBrd, ShellAPI, MSHTML, UrlMon,
  CommCtrl, WinInet, ComObj, XPMenu, Registry, XPGroupBox,IniFiles,
  XPEdit, XPButton, FileCtrl, rmCCTabs;

  type
   TTabSheet = class(ComCtrls.TTabSheet);

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
   end;

  const
   AlignCenter = Wm_User + 1024;
   Tray        = Wm_User + 1;
   Cherta      = Wm_User + 2;
   About       = Wm_User + 3;
   Cherta2     = Wm_User + 4;
   OnTopFrm    = Wm_User + 5;
   FullScr     = Wm_User + 6;

  function OpenSaveFileDialog(ParentHandle: THandle; const DefExt, Filter, InitialDir,
  Title: string; var FileName: string; IsOpenDialog: Boolean): Boolean;


 type
  TWebbrowser = class(TMyBrowser)
  private
    FNavForward: Boolean;
    FNavBack: Boolean;
    FTitle: string;
    procedure WMClose(var Msg: TWMClose); message WM_CLOSE;
  end;

type
  TStatusBar = class(ComCtrls.TStatusBar)
  public
    constructor Create(AOwner: TComponent); override;
  end;

type
  TMainFrm = class(TForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    FileItem: TMenuItem;
    NewTabItem: TMenuItem;
    OpenFileItem: TMenuItem;
    SaveAsItem: TMenuItem;
    PrintItem: TMenuItem;
    PrintPreviewItem: TMenuItem;
    PageSetupItem: TMenuItem;
    spr4: TMenuItem;
    PropertiesItem: TMenuItem;
    OfflineModeItem: TMenuItem;
    ExitItem: TMenuItem;
    EditItem: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    spr9: TMenuItem;
    SelectAllItem: TMenuItem;
    spr11: TMenuItem;
    SearchItem: TMenuItem;
    ViewItem: TMenuItem;
    ViewSourceItem: TMenuItem;
    spr14: TMenuItem;
    CharacterSetItem: TMenuItem;
    CharSetAutomaticItem: TMenuItem;
    spr20: TMenuItem;
    CentralEuropeanISOItem: TMenuItem;
    WesternEuropeanISOItem: TMenuItem;
    UnicodeUTF8Item: TMenuItem;
    spr21: TMenuItem;
    ArabicWindowsItem: TMenuItem;
    BalticWindowsItem: TMenuItem;
    ChineseSimplifiedGB2312Item: TMenuItem;
    ChineseTraditionalBIG5Item: TMenuItem;
    GreekWindowsItem: TMenuItem;
    KoreanItem: TMenuItem;
    haiWindowsItem: TMenuItem;
    urkishWindowsItem: TMenuItem;
    ZoomFontsItem: TMenuItem;
    LargestItem: TMenuItem;
    LargeItem: TMenuItem;
    MediumItem: TMenuItem;
    SmallItem: TMenuItem;
    SmallestItem: TMenuItem;
    spr19: TMenuItem;
    DesignModeItem: TMenuItem;
    ToolsItem: TMenuItem;
    CookieItem: TMenuItem;
    spr30: TMenuItem;
    InternetOptionsItem: TMenuItem;
    NewCloneTabItem: TMenuItem;
    ImageListMainBar: TImageList;
    TabMenu: TPopupMenu;
    CloseTab2Item: TMenuItem;
    NewCloneTab2Item: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    SynItem: TMenuItem;
    CloseTabItem: TMenuItem;
    FullScreenItem: TMenuItem;
    NewWindowItem: TMenuItem;
    ToolBarItem: TMenuItem;
    MainBarItem: TMenuItem;
    StatusBarItem: TMenuItem;
    AddressBarItem: TMenuItem;
    GoToItem: TMenuItem;
    BackItem: TMenuItem;
    ForwardItem: TMenuItem;
    HomePageItem: TMenuItem;
    RefreshItem: TMenuItem;
    StopItem: TMenuItem;
    spr23: TMenuItem;
    spr22: TMenuItem;
    HelpItem: TMenuItem;
    AboutItem: TMenuItem;
    SourceCodeItem: TMenuItem;
    GNUProjectItem: TMenuItem;
    spr41: TMenuItem;
    SendReportItem: TMenuItem;
    spr40: TMenuItem;
    SendMailItem: TMenuItem;
    LicenseItem: TMenuItem;
    spr39: TMenuItem;
    spr38: TMenuItem;
    SysInfoItem: TMenuItem;
    OptionsItem: TMenuItem;
    FavoritesItem: TMenuItem;
    ChargeFavoritesItem: TMenuItem;
    AddFavoritesItem: TMenuItem;
    CleaningSystemItem: TMenuItem;
    DeleteCacheIEItem: TMenuItem;
    ClearBufferItem: TMenuItem;
    spr29: TMenuItem;
    PrivateDatesItem: TMenuItem;
    WNetConnectionDialogItem: TMenuItem;
    WNetDisConnectDialogItem: TMenuItem;
    spr31: TMenuItem;
    SystemUtilsItem: TMenuItem;
    DxDiagItem: TMenuItem;
    RegEditItem: TMenuItem;
    PaintItem: TMenuItem;
    AppWizItem: TMenuItem;
    SaveHTMLItem: TMenuItem;
    spr28: TMenuItem;
    CheckConnectItem: TMenuItem;
    spr32: TMenuItem;
    NetConnectsItem: TMenuItem;
    SrartPageItem: TMenuItem;
    TrayMenu: TPopupMenu;
    OrganizeFavoritesItem: TMenuItem;
    spr26: TMenuItem;
    OnTopItem: TMenuItem;
    spr24: TMenuItem;
    HomeItem: TMenuItem;
    EndItem: TMenuItem;
    spr15: TMenuItem;
    ScrollDownItem: TMenuItem;
    ScrollUpItem: TMenuItem;
    ScrollingItem: TMenuItem;
    spr16: TMenuItem;
    FindHightlightItem: TMenuItem;
    TelModItem: TMenuItem;
    spr13: TMenuItem;
    ClearSelectionItem: TMenuItem;
    ClearAllItem: TMenuItem;
    spr10: TMenuItem;
    ReplaceBufferItem: TMenuItem;
    AddHTMLItem: TMenuItem;
    HighlightPanel: TXPPanel;
    edSearchAndHighlight: TEdit;
    btnSearchAndHighlight: TSpeedButton;
    lbFind: TXPLabel;
    BorderStyleItem: TMenuItem;
    spr25: TMenuItem;
    spr17: TMenuItem;
    HideScrollBarsItem: TMenuItem;
    ContextMenuItem: TMenuItem;
    CloseItem: TMenuItem;
    HideToTrayItem: TMenuItem;
    spr7: TMenuItem;
    SaveAsMoreItem: TMenuItem;
    SaveAllItem: TMenuItem;
    ListLinksItem: TMenuItem;
    spr37: TMenuItem;
    HidePanel: TSpeedButton;
    GoogleSearchItem: TMenuItem;
    ImageListAdditionalBar: TImageList;
    ProgressBar: TProgressBar;
    IEVersionItem: TMenuItem;
    AutoFormItem: TMenuItem;
    WebAddressItem: TMenuItem;
    WebFormItem: TMenuItem;
    WebUserAndPasswrdItem: TMenuItem;
    ConfirmPasswrdItem: TMenuItem;
    OpenHTMLDefaultItem: TMenuItem;
    UndoItem: TMenuItem;
    spr8: TMenuItem;
    DialerItem: TMenuItem;
    DialUpDesktopItem: TMenuItem;
    ICQItem: TMenuItem;
    InternetExplorerItem: TMenuItem;
    MozillaFirefoxItem: TMenuItem;
    MozillaItem: TMenuItem;
    DiskCleanerItem: TMenuItem;
    AdditionalBarItem: TMenuItem;
    DeleteItem: TMenuItem;
    FixPanelsItem: TMenuItem;
    ShowCaptionsItem: TMenuItem;
    EditPageItem: TMenuItem;
    spr12: TMenuItem;
    SizeInItem: TMenuItem;
    SizeOutItem: TMenuItem;
    N12: TMenuItem;
    ScrollLeftItem: TMenuItem;
    ScrollRightItem: TMenuItem;
    spr18: TMenuItem;
    ScalePageItem: TMenuItem;
    Scale50Item: TMenuItem;
    Scale100Item: TMenuItem;
    Scale150Item: TMenuItem;
    Scale200Item: TMenuItem;
    PrintersItem: TMenuItem;
    N19: TMenuItem;
    BackTabItem: TMenuItem;
    NextTabItem: TMenuItem;
    N20: TMenuItem;
    FirstTabItem: TMenuItem;
    CreateHomeTabItem: TMenuItem;
    CreateItem: TMenuItem;
    Refresh2Item: TMenuItem;
    ListLinks2Item: TMenuItem;
    OpenHTMLDefault2Item: TMenuItem;
    spr44: TMenuItem;
    spr43: TMenuItem;
    NewTab2Item: TMenuItem;
    PluginsItem: TMenuItem;
    HideToTray2Item: TMenuItem;
    spr45: TMenuItem;
    N22: TMenuItem;
    InternetOptions2Item: TMenuItem;
    OfflineMode2Item: TMenuItem;
    spr47: TMenuItem;
    spr46: TMenuItem;
    QuickOpenFileItem: TMenuItem;
    QuickPrintItem: TMenuItem;
    spr6: TMenuItem;
    spr5: TMenuItem;
    spr1: TMenuItem;
    spr2: TMenuItem;
    spr3: TMenuItem;
    ExecuteItem: TMenuItem;
    WinExplorerItem: TMenuItem;
    ExplorerItem: TMenuItem;
    MaxWinItem: TMenuItem;
    MinWinItem: TMenuItem;
    MinAllWinItem: TMenuItem;
    MinCurItem: TMenuItem;
    KillNotMinWinItem: TMenuItem;
    spr36: TMenuItem;
    spr33: TMenuItem;
    spr34: TMenuItem;
    spr35: TMenuItem;
    TaskMngItem: TMenuItem;
    ExportItem: TMenuItem;
    OpenAddressItem: TMenuItem;
    PrintMenu: TPopupMenu;
    SaveMenu: TPopupMenu;
    SaveAs2Item: TMenuItem;
    SaveAsMore2Item: TMenuItem;
    SaveHTML2Item: TMenuItem;
    SaveAll2Item: TMenuItem;
    PrintPreview2Item: TMenuItem;
    Print2Item: TMenuItem;
    N79: TMenuItem;
    spr48: TMenuItem;
    QuickPrint2Item: TMenuItem;
    Printers2Item: TMenuItem;
    PageMenu: TPopupMenu;
    spr49: TMenuItem;
    CreateHomeTab3Item: TMenuItem;
    NewCloneTab3Item: TMenuItem;
    NewTab3Item: TMenuItem;
    NewWindow2Item: TMenuItem;
    OpenMenu: TPopupMenu;
    QuickOpenFile2Item: TMenuItem;
    OpenFile2Item: TMenuItem;
    OpenAddress2Item: TMenuItem;
    N95: TMenuItem;
    ToolManu: TPopupMenu;
    InternetWalker2: TMenuItem;
    N138: TMenuItem;
    d1: TMenuItem;
    CoolBar: TCoolBar;
    MainBar: TToolBar;
    BackBt: TToolButton;
    ForwardBt: TToolButton;
    spr42: TToolButton;
    RefreshBt: TToolButton;
    StopBt: TToolButton;
    HomeBt: TToolButton;
    spr50: TToolButton;
    SearchBt: TToolButton;
    spr51: TToolButton;
    SourceBt: TToolButton;
    FullScreenBt: TToolButton;
    spr52: TToolButton;
    FavoritesBt: TToolButton;
    sp5: TToolButton;
    PropertiesBt: TToolButton;
    ExitBt: TToolButton;
    AdditionalBar: TToolBar;
    NewWinBt: TToolButton;
    OpenBt: TToolButton;
    SaveBt: TToolButton;
    spr53: TToolButton;
    PrintBt: TToolButton;
    spr54: TToolButton;
    ToolBt: TToolButton;
    spr55: TToolButton;
    MailBt: TToolButton;
    spr56: TToolButton;
    AboutBt: TToolButton;
    AddressBar: TPanel;
    btnSearch: TSpeedButton;
    btnGo: TSpeedButton;
    lbURL: TLabel;
    lbSearch: TLabel;
    edURL: TEdit;
    edSearch: TEdit;
    TabBar: TImageList;
    PageControl: TPageControl;
    sheet1: TTabSheet;
    WebBrowser: TWebBrowser;
    spr27: TMenuItem;
    HomeWebPageItem: TMenuItem;

    procedure PrintItemClick(Sender: TObject);
    procedure PrintPreviewItemClick(Sender: TObject);
    procedure PageSetupItemClick(Sender: TObject);
    procedure PropertiesItemClick(Sender: TObject);
    procedure CopyItemClick(Sender: TObject);
    procedure PasteItemClick(Sender: TObject);
    procedure CutItemClick(Sender: TObject);
    procedure SelectAllItemClick(Sender: TObject);
    procedure SearchItemClick(Sender: TObject);
    procedure ViewSourceItemClick(Sender: TObject);
    procedure InternetOptionsItemClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure OfflineModeItemClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure NewTabItemClick(Sender: TObject);
    procedure SaveAsItemClick(Sender: TObject);
    procedure CookieItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WebBrowserProgressChange(Sender: TObject; Progress,
    ProgressMax: Integer);
    procedure WebBrowserTitleChange(Sender: TObject;
    const Text: WideString);
    procedure FileItemClick(Sender: TObject);
    procedure EditItemClick(Sender: TObject);
    procedure ToolsItemClick(Sender: TObject);
    procedure ViewItemClick(Sender: TObject);
    procedure StopBtClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure WebBrowserCommandStateChange(Sender: TObject;
    Command: Integer; Enable: WordBool);
    procedure FormResize(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
    Panel: TStatusPanel; const Rect: TRect);
    procedure WebBrowserStatusTextChange(Sender: TObject;
    const Text: WideString);
    procedure WebBrowserDocumentComplete(Sender: TObject;
    const pDisp: IDispatch; var URL: OleVariant);
    procedure Smallest1Click(Sender: TObject);
    procedure WebBrowserNewWindow2(Sender: TObject; var ppDisp: IDispatch;
    var Cancel: WordBool);
    procedure DesignModeItemClick(Sender: TObject);
    procedure WebBrowserNavigateComplete2(Sender: TObject;
    const pDisp: IDispatch; var URL: OleVariant);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
    var Handled: Boolean);
    procedure WebBrowserDownloadComplete(Sender: TObject);
    procedure NewCloneTabItemClick(Sender: TObject);
    procedure CloseTabItemClick(Sender: TObject);
    procedure ExitItemClick(Sender: TObject);
    procedure NewWindowItemClick(Sender: TObject);
    procedure LargestItemClick(Sender: TObject);
    procedure OpenFileItemClick(Sender: TObject);
    procedure SynItemClick(Sender: TObject);
    procedure RefreshItemClick(Sender: TObject);
    procedure ChargeFavoritesItemClick(Sender: TObject);
    procedure AddFavoritesItemClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure CharSetAutomaticItemClick(Sender: TObject);
    procedure AboutItemClick(Sender: TObject);
    procedure SysInfoItemClick(Sender: TObject);
    procedure SourceCodeItemClick(Sender: TObject);
    procedure ZoomFontsItemClick(Sender: TObject);
    procedure PrivateDatesItemClick(Sender: TObject);
    procedure WNetConnectionDialogItemClick(Sender: TObject);
    procedure WNetDisConnectDialogItemClick(Sender: TObject);
    procedure NetConnectsItemClick(Sender: TObject);
    procedure SrartPageItemClick(Sender: TObject);
    procedure HomePageItemClick(Sender: TObject);
    procedure GNUProjectItemClick(Sender: TObject);
    procedure OptionsItemClick(Sender: TObject);
    procedure SendReportItemClick(Sender: TObject);
    procedure FullScreenItemClick(Sender: TObject);
    procedure LicenseItemClick(Sender: TObject);
    procedure SendMailItemClick(Sender: TObject);
    procedure OrganizeFavoritesItemClick(Sender: TObject);
    procedure OnTopItemClick(Sender: TObject);
    procedure HomeItemClick(Sender: TObject);
    procedure EndItemClick(Sender: TObject);
    procedure ScrollUpItemClick(Sender: TObject);
    procedure ScrollDownItemClick(Sender: TObject);
    procedure btnSearchAndHighlightClick(Sender: TObject);
    procedure FindHightlightItemClick(Sender: TObject);
    procedure DeleteCacheIEItemClick(Sender: TObject);
    procedure TelModItemClick(Sender: TObject);
    procedure ClearSelectionItemClick(Sender: TObject);
    procedure ClearAllItemClick(Sender: TObject);
    procedure ReplaceBufferItemClick(Sender: TObject);
    procedure ClearBufferItemClick(Sender: TObject);
    procedure AddHTMLItemClick(Sender: TObject);
    procedure edSearchAndHighlightMouseMove(Sender: TObject;
    Shift: TShiftState; X, Y: Integer);
    procedure BorderStyleItemClick(Sender: TObject);
    procedure HideScrollBarsItemClick(Sender: TObject);
    procedure edURLDblClick(Sender: TObject);
    procedure HideToTrayItemClick(Sender: TObject);
    procedure SaveHTMLItemClick(Sender: TObject);
    procedure SaveAllItemClick(Sender: TObject);
    procedure ListLinksItemClick(Sender: TObject);
    procedure BackItemClick(Sender: TObject);
    procedure ForwardItemClick(Sender: TObject);
    procedure HidePanelClick(Sender: TObject);
    procedure edSearchMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure edSearchExit(Sender: TObject);
    procedure IEVersionItemClick(Sender: TObject);
    procedure WebAddressItemClick(Sender: TObject);
    procedure WebFormItemClick(Sender: TObject);
    procedure WebUserAndPasswrdItemClick(Sender: TObject);
    procedure ConfirmPasswrdItemClick(Sender: TObject);
    procedure StopItemClick(Sender: TObject);
    procedure OpenHTMLDefaultItemClick(Sender: TObject);
    procedure UndoItemClick(Sender: TObject);
    procedure MozillaItemClick(Sender: TObject);
    procedure MozillaFirefoxItemClick(Sender: TObject);
    procedure InternetExplorerItemClick(Sender: TObject);
    procedure ICQItemClick(Sender: TObject);
    procedure DialUpDesktopItemClick(Sender: TObject);
    procedure DialerItemClick(Sender: TObject);
    procedure PaintItemClick(Sender: TObject);
    procedure RegEditItemClick(Sender: TObject);
    procedure DxDiagItemClick(Sender: TObject);
    procedure AppWizItemClick(Sender: TObject);
    procedure DiskCleanerItemClick(Sender: TObject);
    procedure MainBarItemClick(Sender: TObject);
    procedure AdditionalBarItemClick(Sender: TObject);
    procedure StatusBarItemClick(Sender: TObject);
    procedure AddressBarItemClick(Sender: TObject);
    procedure GoogleSearchItemClick(Sender: TObject);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
    procedure DeleteItemClick(Sender: TObject);
    procedure ShowCaptionsItemClick(Sender: TObject);
    procedure ScrollLeftItemClick(Sender: TObject);
    procedure ScrollRightItemClick(Sender: TObject);
    procedure Scale50ItemClick(Sender: TObject);
    procedure Scale100ItemClick(Sender: TObject);
    procedure Scale150ItemClick(Sender: TObject);
    procedure Scale200ItemClick(Sender: TObject);
    procedure PrintersItemClick(Sender: TObject);
    procedure BackTabItemClick(Sender: TObject);
    procedure NextTabItemClick(Sender: TObject);
    procedure FirstTabItemClick(Sender: TObject);
    procedure CreateHomeTabItemClick(Sender: TObject);
    procedure CheckConnectItemClick(Sender: TObject);
    procedure HideToTray2ItemClick(Sender: TObject);
    procedure QuickOpenFileItemClick(Sender: TObject);
    procedure QuickPrintItemClick(Sender: TObject);
    procedure MaxWinItemClick(Sender: TObject);
    procedure MinAllWinItemClick(Sender: TObject);
    procedure MinWinItemClick(Sender: TObject);
    procedure MinCurItemClick(Sender: TObject);
    procedure KillNotMinWinItemClick(Sender: TObject);
    procedure ExplorerItemClick(Sender: TObject);
    procedure TaskMngItemClick(Sender: TObject);
    procedure ExportItemClick(Sender: TObject);
    procedure OpenAddressItemClick(Sender: TObject);
    procedure N95Click(Sender: TObject);
    procedure ExecuteItemClick(Sender: TObject);
    procedure d1Click(Sender: TObject);
    procedure HomeWebPageItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure edURLKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);

  private

  public

    TextString: String;

    SM: HWND;

    ForbidMultiple : THandle;

    Icon: TNotifyIconData;

    Ini : TIniFile;

    R : TRegistry;

    List: TList;

    FPrevBrowser: TWebbrowser;

    HistoryMenu: THistoryMenu;

    FColor: TColor;

    procedure SetColor(Value: TColor);

    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd);
    message WM_ERASEBKGND;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

    function DrawZoneIcon(WB: TWebbrowser): TIcon;

    function CreateTabBrowser(sURL, sCaption: string): TTabSheet;

    procedure SetWBMenuEnabled(WB: TWebbrowser; Sender: TMenuItem);

    procedure HistoryMenuURLSelected(Sender: TObject; Url: string);

    procedure FavoritesMenuURLSelected(Sender: TObject; Url: string);

    function GetCurrentWB: TWebbrowser;

    procedure WMGetMinMaxInfo(var msg: TWMGetMinMaxInfo);
    message WM_GETMINMAXINFO;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

    procedure Show_Hint(Sender: TObject);

    procedure MinimizeApplication(Sender: TObject);

    procedure SystemTrayMenu(var SysTray: TMessage);
    message Tray;

    constructor Create(aOwner: TComponent); override;
    property Color: TColor read FColor write SetColor;


  end;

  const
  APP_CAPTION = 'Internet Walker - ';
  
var
  MainFrm: TMainFrm;
  h: THandle = 0;
  CheckInet: procedure; stdcall;
  ShowRunDlg: procedure; stdcall;
  ShowShutDownDlg: procedure; stdcall;

implementation

uses
OpenAddress, ListFav, AddFav, AP, YDP, OP, LP, SP, AddHTML, ListLink,
MyPrinter, IMPPR;

{$R *.dfm}

var
p: procedure(Handle: THandle; Path: PChar); stdcall;

type
   POpenFilenameA = ^TOpenFilenameA;
   POpenFilename = POpenFilenameA;
   tagOFNA = packed record
   lStructSize: DWORD;
   hWndOwner: HWND;
   hInstance: HINST;
   lpstrFilter: PAnsiChar;
   lpstrCustomFilter: PAnsiChar;
   nMaxCustFilter: DWORD;
   nFilterIndex: DWORD;
   lpstrFile: PAnsiChar;
   nMaxFile: DWORD;
   lpstrFileTitle: PAnsiChar;
   nMaxFileTitle: DWORD;
   lpstrInitialDir: PAnsiChar;
   lpstrTitle: PAnsiChar;
   Flags: DWORD;
   nFileOffset: Word;
   nFileExtension: Word;
   lpstrDefExt: PAnsiChar;
   lCustData: LPARAM;
   lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
   lpTemplateName: PAnsiChar;
   end;
   TOpenFilenameA = tagOFNA;
   TOpenFilename = TOpenFilenameA;

   function GetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall; external 'comdlg32.dll'
   name 'GetOpenFileNameA';
   function GetSaveFileName(var OpenFile: TOpenFilename): Bool; stdcall; external 'comdlg32.dll'
   name 'GetSaveFileNameA';

  const
   OFN_DONTADDTORECENT = $02000000;
   OFN_FILEMUSTEXIST = $00001000;
   OFN_HIDEREADONLY = $00000004;
   OFN_PATHMUSTEXIST = $00000800;

 function CharReplace(const Source: string; oldChar, newChar: Char): string;
 var
 i: Integer;
 begin
 Result := Source;
 for i := 1 to Length(Result) do
 if Result[i] = oldChar then
 Result[i] := newChar;
 end;

function OpenSaveFileDialog(ParentHandle: THandle; const DefExt, Filter, InitialDir, Title: string; var FileName: string; IsOpenDialog: Boolean): Boolean;
var
ofn: TOpenFileName;
szFile: array[0..MAX_PATH] of Char;
begin
Result := False;
FillChar(ofn, SizeOf(TOpenFileName), 0);
with ofn do
begin
lStructSize := SizeOf(TOpenFileName);
hwndOwner := ParentHandle;
lpstrFile := szFile;
nMaxFile := SizeOf(szFile);
if (Title <> '') then
lpstrTitle := PChar(Title);
if (InitialDir <> '') then
lpstrInitialDir := PChar(InitialDir);
StrPCopy(lpstrFile, FileName);
lpstrFilter := PChar(CharReplace(Filter, '|', #0)+#0#0);
if DefExt <> '' then
lpstrDefExt := PChar(DefExt);
end;
if IsOpenDialog then
begin
if GetOpenFileName(ofn) then
begin
Result := True;
FileName := StrPas(szFile);
end;
end else
begin
if GetSaveFileName(ofn) then
begin
Result := True;
FileName := StrPas(szFile);
end;
end
end;

procedure TWebbrowser.WMClose(var Msg: TWMClose);
begin
Msg.Result := 0;
Navigate('Blank');
end;

constructor TStatusBar.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
ControlStyle := ControlStyle + [csAcceptsControls];
end;

function TMainFrm.CreateTabBrowser(sURL, sCaption: string): TTabSheet;
var
ts: TTabSheet;
WB: TWebbrowser;
begin
ts := TTabSheet.Create(PageControl);
try
if DesignModeItem.Checked then
DesignModeItem.Click;
if BorderStyleItem.Checked then
BorderStyleItem.Click;
ts.PageControl := PageControl;
ts.Parent := PageControl;
ts.Caption := sCaption;
ts.PageIndex := PageControl.ActivePageIndex + 1;
WB := TWebbrowser.Create(ts);
TControl(WB).Parent := ts;
WB.Align := alClient;
WB.Silent := True;
WB.Visible := True;
PageControl.ActivePage := ts;
WB.OnProgressChange := WebBrowserProgressChange;
WB.OnStatusTextChange := WebBrowserStatusTextChange;
WB.OnTitleChange := WebBrowserTitleChange;
WB.OnNewWindow2 := WebBrowserNewWindow2;
WB.OnCommandStateChange := WebBrowserCommandStateChange;
WB.OnDownloadComplete := WebBrowserDownloadComplete;
WB.OnDocumentComplete := WebBrowserDocumentComplete;
WB.FNavForward := False;
WB.FNavBack := False;
if Trim(sURL) <> '' then
begin
WB.Navigate(sURL);
WaitForBrowser(WB);
end;
except
ts.Free;
end;
end;

function TMainFrm.DrawZoneIcon(WB: TWebbrowser): TIcon;
var
ZoneAttr: TZoneAttributes;
ZoneIcon: TIcon;
begin
ZoneAttr := GetZoneAttributes(WB.LocationURL);
ZoneIcon := TIcon.Create;
try
if GetZoneIcon(ZoneAttr.szIconPath, ZoneIcon) then
Statusbar.Panels[4].Text := ZoneAttr.szDisplayName;
Result := ZoneIcon;
finally
end;
end;

procedure TMainFrm.FavoritesMenuURLSelected(Sender: TObject; Url: string);
var
WB: TWebbrowser;
begin
WB := GetCurrentWB;
if Assigned(WB) then
WB.Navigate(URL);
end;

function TMainFrm.GetCurrentWB: TWebbrowser;
begin
Result := nil;
with PageControl do
if ActivePage.ControlCount > 0 then
begin
if ActivePage.Controls[0] is TWebbrowser then
begin
Result := (TWebbrowser(ActivePage.Controls[0]));
end else
Result := FPrevBrowser;
end;
end;

procedure TMainFrm.HistoryMenuURLSelected(Sender: TObject; Url: string);
var
WB: TWebbrowser;
begin
WB := GetCurrentWB;
if Assigned(WB) then
WB.Navigate(URL);
end;

procedure TMainFrm.SetWBMenuEnabled(WB: TWebbrowser; Sender: TMenuItem);
begin
if Assigned(WB) then
Sender.Enabled := Assigned(WB.Document) else
Sender.Enabled := False;
end;

procedure TMainFrm.PrintItemClick(Sender: TObject);
begin
WB_ShowPrintDialog(GetCurrentWB);
end;

procedure TMainFrm.PrintPreviewItemClick(Sender: TObject);
begin
WB_ShowPrintPreview(GetCurrentWB);
end;

procedure TMainFrm.PageSetupItemClick(Sender: TObject);
begin
WB_ShowPageSetup(GetCurrentWB);
end;

procedure TMainFrm.PropertiesItemClick(Sender: TObject);
begin
WB_ShowPropertiesDialog(GetCurrentWB);
end;

procedure TMainFrm.CopyItemClick(Sender: TObject);
begin
WB_Copy(GetCurrentWB);
end;

procedure TMainFrm.PasteItemClick(Sender: TObject);
begin
WB_Paste(GetCurrentWB);
end;

procedure TMainFrm.CutItemClick(Sender: TObject);
begin
WB_Cut(GetCurrentWB);
end;

procedure TMainFrm.SelectAllItemClick(Sender: TObject);
begin
WB_SelectAll(GetCurrentWB);
end;

procedure TMainFrm.SearchItemClick(Sender: TObject);
begin
WB_ShowFindDialog(GetCurrentWB);
end;

procedure TMainFrm.ViewSourceItemClick(Sender: TObject);
begin
WB_ShowSourceCode(GetCurrentWB);
end;

procedure TMainFrm.InternetOptionsItemClick(Sender: TObject);
begin
InvokeCMD(GetCurrentWB, HTMLID_OPTIONS);
end;

procedure TMainFrm.ToolButton2Click(Sender: TObject);
begin
WB_ScrollToTop(GetCurrentWB);
end;

procedure TMainFrm.OfflineModeItemClick(Sender: TObject);
begin
OfflineModeItem.Checked := not OfflineModeItem.Checked;
SetGlobalOffline(OfflineModeItem.Checked);
end;

procedure TMainFrm.btnGoClick(Sender: TObject);
begin
if edURL.Text <> '' then
begin
WB_Navigate(GetCurrentWB, edURL.Text);
WB_SetFocus(GetCurrentWB);
end;
end;

procedure TMainFrm.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
begin
Key := #0;
btnSearchClick(self);
end;
end;

procedure TMainFrm.NewTabItemClick(Sender: TObject);
begin
CreateTabBrowser('about:blank', 'about:blank');
end;

procedure TMainFrm.SaveAsItemClick(Sender: TObject);
begin
WB_Save(GetCurrentWB);
end;

procedure TMainFrm.CookieItemClick(Sender: TObject);
var
sCookie: string;
begin
sCookie := WB_GetCookie(GetCurrentWB);
if Length(sCookie) = 0 then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(PChar('Эта страница не содержит cookies.'),
'Internet Walker',
mb_IconAsterisk + mb_OK) end else
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(PChar(sCookie),
'Internet Walker',
mb_IconAsterisk + mb_OK);
end;
end;

function GetElementAtPos(Doc: IHTMLDocument2; x, y: integer): IHTMLElement;
begin
Result := nil;
Result := Doc.elementFromPoint(x, y);
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
try
CoolBar.Bitmap.LoadFromFile('logo.bmp');
except
end;
INI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.Ini'));
try
Top := Ini.ReadInteger('Position', 'Top', 100);
Left := Ini.ReadInteger('Position', 'Left', 100);
ClientHeight := Ini.ReadInteger('Position', 'Client Height', 600);
ClientWidth := Ini.ReadInteger('Position', 'Client Width', 808);
ContextMenuItem.Checked := Ini.ReadBool('Parameters', 'Context menu IE', ContextMenuItem.Checked);
OnTopItem.Checked := Ini.ReadBool('Parameters', 'Always on top', OnTopItem.Checked);
except
end;
with Icon do
begin
Wnd := Handle;
SzTip := 'Internet Walker';
HIcon := Application.Icon.Handle;
UCallBackMessage := Tray;
UFlags := Nif_Tip + Nif_Message or Nif_Icon;
end;
FPrevBrowser := Webbrowser;
Webbrowser.FNavForward := False;
Webbrowser.FNavBack := False;
Webbrowser.FTitle := '';
Application.OnMinimize := MinimizeApplication;
Application.OnHint := Show_Hint;
end;

procedure TMainFrm.FormShow(Sender: TObject);
var
S: string;
CurrentWB: TWebbrowser;
begin
try
if SetFrm.ch38.Checked then
begin
if not FullScreenItem.Checked then
FullScreenItem.Click;
end;
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if SetFrm.ch2.Checked then
R.WriteString(Application.Title, ParamStr(0)) else
R.DeleteValue(Application.Title);
R.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete');
if r.ValueExists('AutoSuggest')
then s:=r.ReadString('AutoSuggest');
if s = 'yes' then
WebAddressItem.Checked:=True else
WebAddressItem.Checked:=False;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Internet Explorer\Main');
if r.ValueExists('Use FormSuggest')
then s:=r.ReadString('Use FormSuggest');
if s = 'yes' then
WebFormItem.Checked:=True else
WebFormItem.Checked:=False;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Internet Explorer\Main');
if r.ValueExists('FormSuggest Passwords')
then s:=r.ReadString('FormSuggest Passwords');
if s = 'yes' then
WebUserAndPasswrdItem.Checked:=True else
WebUserAndPasswrdItem.Checked:=False;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Internet Explorer\Main');
if r.ValueExists('FormSuggest PW Ask')
then s:=r.ReadString('FormSuggest PW Ask');
if s = 'yes' then
ConfirmPasswrdItem.Checked:=True else
ConfirmPasswrdItem.Checked:=False;
if SetFrm.ch1.Checked then
begin
RyMenu.Add(MainMenu, nil);
RyMenu.Add(TrayMenu, nil);
RyMenu.Add(TabMenu, nil);
RyMenu.Add(PrintMenu, nil);
RyMenu.Add(SaveMenu, nil);
RyMenu.Add(PageMenu, nil);
RyMenu.Add(OpenMenu, nil);
RyMenu.Add(ToolManu, nil);
RyMenu.Add(AddHTMLFrm.OptionsMenu, nil);
end;
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if SetFrm.ch2.Checked then
R.WriteString(Application.Title, ParamStr(0)) else
R.DeleteValue(Application.Title);
R.Free;
CurrentWB := GetCurrentWB;
SetWBMenuEnabled(CurrentWB, PrintItem);
SetWBMenuEnabled(CurrentWB, PrintPreviewItem);
SetWBMenuEnabled(CurrentWB, PageSetupItem);
SetWBMenuEnabled(CurrentWB, PropertiesItem);
SetWBMenuEnabled(CurrentWB, SaveAsItem);
OfflineModeItem.Checked := IsGlobalOffline;
OfflineMode2Item.Checked := IsGlobalOffline;
if OnTopItem.Checked = False then
begin
SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
end else
begin
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
OnTopItem.Checked := true;
end;
if SetFrm.ch20.Checked then
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
if SetFrm.ch22.Checked then
begin
AnimateWindow(MainFrm.Handle, 500, AW_CENTER or AW_SLIDE or AW_ACTIVATE);
end;
GetCurrentWB.GoHome;
FormResize(nil);
except
end;
end;

procedure TMainFrm.FormDestroy(Sender: TObject);
begin
try
Shell_NotifyIcon(Nim_Delete, @Icon);
HistoryMenu.Free;
except
end;
end;

procedure TMainFrm.WebBrowserProgressChange(Sender: TObject; Progress,
ProgressMax: Integer);
var
Position: Integer;
begin
try
Position := (Progress * 100) div ProgressMax;
ProgressBar.Position := Position;
StatusBar.Panels[0].Text := Format('%d "% loaded..."', [Position]);
except
end;
end;

procedure TMainFrm.WebBrowserTitleChange(Sender: TObject;
const Text: WideString);
begin
Caption := APP_CAPTION + Text;
TWebbrowser(Sender).FTitle := Text;
end;

procedure TMainFrm.FileItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
begin
CurrentWB := GetCurrentWB;
SetWBMenuEnabled(CurrentWB, PrintItem);
SetWBMenuEnabled(CurrentWB, PrintPreviewItem);
SetWBMenuEnabled(CurrentWB, PageSetupItem);
SetWBMenuEnabled(CurrentWB, PropertiesItem);
SetWBMenuEnabled(CurrentWB, SaveAsItem);
OfflineModeItem.Checked := IsGlobalOffline;
OfflineMode2Item.Checked := IsGlobalOffline;
end;

procedure TMainFrm.EditItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
begin
CurrentWB := GetCurrentWB;
SetWBMenuEnabled(CurrentWB, SelectAllItem);
SetWBMenuEnabled(CurrentWB, SearchItem);
end;

procedure TMainFrm.ToolsItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
begin
CurrentWB := GetCurrentWB;
SetWBMenuEnabled(CurrentWB, InternetOptionsItem);
SetWBMenuEnabled(CurrentWB, CookieItem);
end;

procedure TMainFrm.ViewItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
begin
CurrentWB := GetCurrentWB;
SetWBMenuEnabled(CurrentWB, DesignModeItem);
SetWBMenuEnabled(CurrentWB, CharacterSetItem);
SetWBMenuEnabled(CurrentWB, ViewSourceItem);
end;

procedure TMainFrm.StopBtClick(Sender: TObject);
begin
WB_Stop(GetCurrentWB);
end;

procedure TMainFrm.btnSearchClick(Sender: TObject);
const
GOOGLE_QUERY = 'http://www.google.com/search?ie=ISO-8859-1&hl=de&q=';
var
sQuery: string;
begin
sQuery := GOOGLE_QUERY + edSearch.Text;
WB_Navigate(GetCurrentWB, sQuery);
end;

procedure TMainFrm.WebBrowserCommandStateChange(Sender: TObject;
Command: Integer; Enable: WordBool);
begin
case Command of
CSC_NAVIGATEBACK: begin
TWebbrowser(Sender).FNavBack := Enable;
BackBt.Enabled := Enable;
if PageControl.ActivePageIndex <= 0 then
NextTabItem.Enabled := False else
NextTabItem.Enabled := True;
if PageControl.ActivePageIndex <= 0 then
BackTabItem.Enabled := False else
BackTabItem.Enabled := True;
end;
CSC_NAVIGATEFORWARD: begin
TWebbrowser(Sender).FNavForward := Enable;
ForwardBt.Enabled := Enable;
end;
end;
end;

procedure TMainFrm.FormResize(Sender: TObject);
var
r: TRect;
const
SB_GETRECT = WM_USER + 10;
begin
Statusbar.Perform(SB_GETRECT, 2, Integer(@R));
ProgressBar.Parent := Statusbar;
ProgressBar.SetBounds(r.Left, r.Top, r.Right - r.Left - 3, r.Bottom - r.Top);
with Statusbar do
begin
Panels[1].Width := Width div 2 - 10;
Panels[0].Width := 80;
Panels[2].Width := 90;
Panels[3].Width := 25;
Panels[4].Width := 150;
Panels[5].Width := 200;
Refresh;
end; 
end;

procedure TMainFrm.StatusBarDrawPanel(StatusBar: TStatusBar;
Panel: TStatusPanel; const Rect: TRect);
var
ZoneIcon: TIcon;
CurrentWB: TWebbrowser;
begin
if Panel = Statusbar.Panels[3] then
begin
CurrentWB := GetCurrentWB;
if Assigned(CurrentWB) then
begin
ZoneIcon := DrawZoneIcon(CurrentWB);
if ZoneIcon.Handle <> 0 then
begin
Statusbar.Canvas.Font.Color := clRed;
Statusbar.Canvas.FillRect(Rect);
Statusbar.Canvas.Draw(Rect.Left, Rect.Top, ZoneIcon);
end;
ZoneIcon.Free;
end else
Statusbar.Panels[3].Text := '';
end;
end;

procedure TMainFrm.WebBrowserStatusTextChange(Sender: TObject;
const Text: WideString);
var
CurrentWB: TWebbrowser;
begin
CurrentWB := GetCurrentWB;
if Assigned(CurrentWB) then
begin
if TControl(CurrentWB).Hint = TControl(Sender).Hint then
StatusBar.Panels[1].Text := Text;
end;
end;

procedure TMainFrm.WebBrowserDocumentComplete(Sender: TObject;
const pDisp: IDispatch; var URL: OleVariant);
var
CurWebBrowser: IWebBrowser;
TopWebBrowser: IWebBrowser;
Document: OleVariant;
WindowName: string;
begin
CurWebBrowser := pDisp as IWebBrowser;
TopWebBrowser := TWebBrowser(Sender).DefaultInterface;
if CurWebBrowser = TopWebBrowser then
begin
ProgressBar.Position := 0;
StatusBar.Panels[0].Text := '';
end else
begin
Document := CurWebBrowser.Document;
WindowName := Document.ParentWindow.Name;
end;
end;

procedure TMainFrm.Smallest1Click(Sender: TObject);
var
CurrentWB: TWebbrowser;
k: Integer;
begin
CurrentWB := GetCurrentWB;
if WB_DocumentLoaded(CurrentWB) then
begin
WB_SetZoom(CurrentWB, TMenuItem(Sender).Tag);
for k := 0 to ZoomFontsItem.Count - 1 do
ZoomFontsItem.Items[k].Checked := False;
TMenuItem(Sender).Checked := True;
end;
end;

procedure WB_GetFrames(WB: TWebbrowser; sl: TStrings);
function EnumProc(AHtmlDocument: IHtmlDocument2; Data: Integer): Boolean;
begin
Result := True;
end;
begin
EnumFrames(WB.ControlInterface.Document as IHtmlDocument2, @EnumProc, Integer(MainFrm));
end;

procedure TMainFrm.WebBrowserNewWindow2(Sender: TObject;
var ppDisp: IDispatch; var Cancel: WordBool);
var
ts: TTabSheet;
begin
try
if TWebbrowser(Sender).ReadyState <> READYSTATE_COMPLETE then
begin
ppDisp := nil;
Cancel := True;
end else
begin
ts := CreateTabBrowser('', 'New Browser');
WaitForBrowser(TWebbrowser(ts.Controls[0]));
ppdisp := (TWebbrowser(ts.Controls[0])).Application;
WaitForBrowser(TWebbrowser(ts.Controls[0]));
end;
except
end;
end;

procedure TMainFrm.DesignModeItemClick(Sender: TObject);
var
HTMLDocument2: IHTMLDocument2;
DesignMode: string;
CurrentWB: TWebbrowser;
begin
CurrentWB := GetCurrentWB;
if Assigned(CurrentWB) then
begin
DesignModeItem.Checked := not DesignModeItem.Checked;
HTMLDocument2 := (CurrentWB.Document as IHTMLDocument2);
if HTMLDocument2 <> nil then begin
DesignMode := HTMLDocument2.get_designMode;
if DesignMode = 'On' then
begin
HTMLDocument2.designMode := 'Off';
DesignModeItem.Checked := False;
end else
begin
HTMLDocument2.designMode := 'On';
DesignModeItem.Checked := True;
end;
end;
end;
end;

procedure TMainFrm.WebBrowserNavigateComplete2(Sender: TObject;
const pDisp: IDispatch; var URL: OleVariant);
begin
edURL.Text := TWebbrowser(Sender).LocationURL;
end;
     
procedure TMainFrm.ApplicationEventsMessage(var Msg: tagMSG;
var Handled: Boolean);
var
CurrentWB: TWebbrowser;
begin
CurrentWB := GetCurrentWB;
try
if (CurrentWB = nil) or (CurrentWB.Document = nil) then
begin
Handled := False;
Exit;
end;
except
end;
if not ContextMenuItem.Checked then
if (Msg.Message = WM_RBUTTONDOWN) or (Msg.Message = WM_RBUTTONDBLCLK) then
begin
if IsChild(CurrentWB.Handle, Msg.hwnd) then
begin
Handled := True;
Exit;
end;
end;
end;

procedure TMainFrm.WebBrowserDownloadComplete(Sender: TObject);
begin
StatusBar.Repaint;
end;

procedure TMainFrm.NewCloneTabItemClick(Sender: TObject);
var
iCurrTabIndex: Integer;
ts: TTabSheet;
CurrentWB, NewWB: TWebbrowser;
sCurrURL: string;
begin
try
CurrentWB := GetCurrentWB;
if CurrentWB <> nil then
begin
iCurrTabIndex := PageControl.ActivePage.TabIndex;
sCurrURL := TWebbrowser(CurrentWB).LocationURL;
ts := CreateTabBrowser(sCurrURL, ExtractFileName(Text));
NewWB := TWebbrowser(ts.Controls[0]);
WaitForBrowser(NewWB);
if NewWB.Document <> nil then
(NewWB.Document as IHTMLDocument2).body.innerHTML := (CurrentWB.Document as IHTMLDocument2).body.innerHTML;
ts.PageIndex := iCurrTabIndex + 1;
PageControl.ActivePageIndex := ts.PageIndex;
end;
except
end;
end;

procedure TMainFrm.CloseTabItemClick(Sender: TObject);
begin
try
if PageControl.ActivePageIndex > 0 then
begin
if PageControl.ActivePage.Controls[0] is TWebbrowser then
begin
(TWebbrowser(PageControl.ActivePage.Controls[0])).Free;
FPrevBrowser := nil;
PageControl.ActivePage.Free;
end;
end;
except
end;
end;

procedure TMainFrm.ExitItemClick(Sender: TObject);
begin
Halt;
end;

procedure TMainFrm.NewWindowItemClick(Sender: TObject);
var
PC: array[0..255] of char;
S: String;
begin
{$ifdef Windows}
WinExec(StrPCopy(PC, ParamStr(0)+' '+S), Sw_Show);
{$else}
WinExec(StrPCopy(PC, ParamStr(0)+' "'+S+'"'), Sw_Show);
{$endif}
end;

procedure TMainFrm.LargestItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
k: Integer;
begin
CurrentWB := GetCurrentWB;
if WB_DocumentLoaded(CurrentWB) then
begin
WB_SetZoom(CurrentWB, TMenuItem(Sender).Tag);
for k := 0 to ZoomFontsItem.Count - 1 do
ZoomFontsItem.Items[k].Checked := False;
TMenuItem(Sender).Checked := True;
end;
end;

procedure TMainFrm.OpenFileItemClick(Sender: TObject);
begin
OpenFrm.Position := poMainFormCenter;
OpenFrm.ShowModal;
end;

procedure TMainFrm.SynItemClick(Sender: TObject);
begin
ShellExecute(handle, nil, 'mobsync', nil, nil, Sw_ShowNormal);
end;

procedure TMainFrm.RefreshItemClick(Sender: TObject);
begin
WB_Refresh(GetCurrentWB);
end;

procedure TMainFrm.ChargeFavoritesItemClick(Sender: TObject);
begin
OrgFavFrm.Position := poMainFormCenter;
OrgFavFrm.ShowModal;
end;

procedure TMainFrm.AddFavoritesItemClick(Sender: TObject);
begin
AddFavFrm.AddAddress.Text := edURL.Text;
AddFavFrm.Position := poMainFormCenter;
AddFavFrm.ShowModal;
end;

procedure TMainFrm.PageControlChange(Sender: TObject);
var
CurrentWB: TWebbrowser;
begin
try
WB_Set3DBorderStyle(GetCurrentWB, not BorderStyleItem.Checked);
BackBt.Enabled := False;
ForwardBt.Enabled := False;
with PageControl do
if ActivePage.ControlCount > 0 then
if ActivePage.Controls[0] is TWebbrowser then
begin
CurrentWB := TWebbrowser(ActivePage.Controls[0]);
WB_SetFocus(CurrentWB);
BackBt.Enabled := CurrentWB.FNavBack;
ForwardBt.Enabled := CurrentWB.FNavForward;
edURL.Text := CurrentWB.LocationURL;
Self.Caption := APP_CAPTION + TWebbrowser(CurrentWB).FTitle;
end;
TWebbrowser(Sender).FTitle := Text;
except
end;
end;

procedure TMainFrm.CharSetAutomaticItemClick(Sender: TObject);
begin
if WB_SetCharSet(GetCurrentWB, TMenuItem(Sender).Hint) then
TMenuItem(Sender).Checked := True;
end;

procedure TMainFrm.AboutItemClick(Sender: TObject);
var
NameUser: array[0..255] of char;
NameComp: array[0..255] of char;
Size: DWord;
begin
try
if GetKeyState(VK_Control) < 0 then
begin
Size:= 55;
getcomputername(NameComp, Size);
getusername(NameUser, Size);
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(PChar('Имя пользователя: ' + NameUser +#13 +
'Имя компьютера: ' + NameComp),
'Internet Walker',
mb_IconAsterisk + mb_OK);
end else
begin
AboutFrm.Position := poMainFormCenter;
AboutFrm.ShowModal;
end;
except
end;
end;

procedure TMainFrm.SysInfoItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'msInfo32', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.SourceCodeItemClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Application.MessageBox(
'Copyright @2009 Домани Олег (aka ?КТО_Я?)' + #13 +
'======================================' + #13 + #13 + '' +
'Если Вы хотите получить исходный код проекта (архив' + #13
+ 'с компонентами по желанию пользователя), а также'
+ #13 + 'все последующие новые версии программы, то' + #13 +
'отправьте электронное письмо автору.' + #13 +
'' +  #13 + '======================================' +  #13 +
'' +  #13 +
'Отправить письмо сейчас?',
'Internet Walker',
mb_IconAsterisk + mb_YesNo) = idYes then
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Internet Walker Project' +
'&Body=Hello, please send me the source code program. Thanks!',
'', '', SW_SHOW);
end;
end;

procedure TMainFrm.ZoomFontsItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
ZoomIndex: TWBFontSize;
begin
CurrentWB := GetCurrentWB;
if WB_DocumentLoaded(CurrentWB) then
begin
ZoomIndex := WB_GetZoom(CurrentWB);
case ZoomIndex of
0: SmallestItem.Checked := True;
1: SmallItem.Checked := True;
2: MediumItem.Checked := True;
3: LargeItem.Checked := True;
4: LargestItem.Checked := True;
end;
end;
end;

procedure TMainFrm.PrivateDatesItemClick(Sender: TObject);
begin
DatesFrm.Position := poMainFormCenter;
DatesFrm.ShowModal;
end;

procedure TMainFrm.WNetConnectionDialogItemClick(Sender: TObject);
begin
WNetConnectionDialog(Handle, ResourceType_Disk);
end;

procedure TMainFrm.WNetDisConnectDialogItemClick(Sender: TObject);
begin
WNetDisConnectDialog(Handle, ResourceType_Disk);
end;

procedure TMainFrm.NetConnectsItemClick(Sender: TObject);
begin
WinExec('CONTROL.EXE ncpa.cpl',sw_ShowNormal);
end;

procedure TMainFrm.SrartPageItemClick(Sender: TObject);
begin
R := TRegistry.Create;
R.RootKey:=HKEY_CURRENT_USER;
if R.KeyExists('\Software\Microsoft\Internet Explorer\Main')
then begin
R.OpenKey('\Software\Microsoft\Internet Explorer\Main',true);
R.WriteString('Start Page', edURL.Text);
R.CloseKey;
R.Free;
end;
end;

procedure TMainFrm.HomePageItemClick(Sender: TObject);
begin
GetCurrentWB.GoHome;   
end;

procedure TMainFrm.GNUProjectItemClick(Sender: TObject);
begin
edURL.Text := 'http://www.gnu.org/philosophy/';
WB_Navigate(GetCurrentWB, edURL.Text);
end;

procedure TMainFrm.OptionsItemClick(Sender: TObject);
begin
SetFrm.Position := poMainFormCenter;
SetFrm.ShowModal;
end;

procedure TMainFrm.SendReportItemClick(Sender: TObject);
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Internet Walker Project - [Error]' +
'&Body=Error',
'', '', SW_SHOW);
end;

procedure TMainFrm.FullScreenItemClick(Sender: TObject);
const
Rect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
FullScreen: Boolean = False;
begin
MainFrm.ScreenSnap := False;
FullScreen := not FullScreen;
if FullScreen then begin
Rect := BoundsRect;
SetBounds( Left - ClientOrigin.X,
Top - ClientOrigin.Y, GetDeviceCaps( Canvas.handle,
HORZRES )
+ (Width - ClientWidth), GetDeviceCaps( Canvas.handle,
VERTRES )
+ (Height - ClientHeight ));
end else
begin
BoundsRect := Rect;
if SetFrm.ch20.Checked then
MainFrm.ScreenSnap := True else
MainFrm.ScreenSnap := False;
end;
end;

procedure TMainFrm.WMGetMinMaxInfo(var msg: TWMGetMinMaxInfo);
begin
inherited;
with msg.MinMaxInfo^.ptMaxTrackSize do begin
X := GetDeviceCaps( Canvas.handle, HORZRES ) +
(Width - ClientWidth);
Y := GetDeviceCaps( Canvas.handle, VERTRES ) +
(Height - ClientHeight );
end;
end;

procedure TMainFrm.LicenseItemClick(Sender: TObject);
begin
LicFrm.Position := poMainFormCenter;
LicFrm.ShowModal;
end;

procedure TMainFrm.SendMailItemClick(Sender: TObject);
begin
ShellExecute(Handle, 'open',
'mailto:viacoding@mail.ru?Subject=Internet Walker Project'+
'', '', '',SW_SHOW);
end;

procedure OrganizeFavorite;
var
SpecialPath: array[0..MAX_PATH] of Char;
H: HWnd;
begin
H := LoadLibrary(PChar('shdocvw.dll'));
if H <> 0 then begin
p := GetProcAddress(H, PChar('DoOrganizeFavDlg'));
if Assigned(p) then
begin
p(Application.Handle, SpecialPath);
end;
end;
end;

procedure TMainFrm.OrganizeFavoritesItemClick(Sender: TObject);
begin
OrganizeFavorite;
end;

procedure TMainFrm.OnTopItemClick(Sender: TObject);
begin
OnTopItem.Checked := not OnTopItem.Checked;
if OnTopItem.Checked = False then
begin
SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
end else
begin
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
OnTopItem.Checked := true;
end;
end;

procedure TMainFrm.HomeItemClick(Sender: TObject);
begin
WB_ScrollToTop(GetCurrentWB);
end;

procedure TMainFrm.EndItemClick(Sender: TObject);
begin
WB_ScrollToBottom(GetCurrentWB);
end;

procedure TMainFrm.ScrollUpItemClick(Sender: TObject);
begin
WB_ScrollUp(GetCurrentWB);
end;

procedure TMainFrm.ScrollDownItemClick(Sender: TObject);
begin
WB_ScrollDown(GetCurrentWB);
end;

procedure TMainFrm.ScrollLeftItemClick(Sender: TObject);
begin
WB_ScrollLeft(GetCurrentWB);
end;

procedure TMainFrm.ScrollRightItemClick(Sender: TObject);
begin
WB_ScrollRight(GetCurrentWB);
end;

procedure TMainFrm.btnSearchAndHighlightClick(Sender: TObject);
begin
WB_SearchAndHighlightText(GetCurrentWB, edSearchAndHighlight.Text);
end;

procedure TMainFrm.FindHightlightItemClick(Sender: TObject);
begin
if FindHightlightItem.Checked then
begin
HighlightPanel.Visible := True;
edSearchAndHighlight.SetFocus;
end else
HighlightPanel.Visible := False;
end;

procedure DeleteIeTempFiles;
var
lpEntryInfo: PInternetCacheEntryInfo;
hCacheDir: LongWord;
dwEntrySize: LongWord;
begin
dwEntrySize := 0;
FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
GetMem(lpEntryInfo, dwEntrySize);
if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
if hCacheDir <> 0 then
begin
repeat
DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
FreeMem(lpEntryInfo, dwEntrySize);
dwEntrySize := 0;
FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
GetMem(lpEntryInfo, dwEntrySize);
if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);
end;
FreeMem(lpEntryInfo, dwEntrySize);
FindCloseUrlCache(hCacheDir);
end;

procedure TMainFrm.DeleteCacheIEItemClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Messagebox(Handle,
'Удалить временные файлы Microsoft Internet Explorer?',
'Удаление файлов',
mb_IconExclamation + mb_OkCancel) = idOk then
DeleteIeTempFiles;
end;

procedure TMainFrm.TelModItemClick(Sender: TObject);
begin
WinExec('CONTROL.EXE telephon.cpl', Sw_ShowNormal);
end;

procedure TMainFrm.ClearSelectionItemClick(Sender: TObject);
begin
WB_ClearSelection(GetCurrentWB);
end;

procedure TMainFrm.ClearAllItemClick(Sender: TObject);
begin
WB_ClearAll(GetCurrentWB);
end;

procedure TMainFrm.ReplaceBufferItemClick(Sender: TObject);
begin
WB_ClearAndPasteFromBuffer(GetCurrentWB);
end;

procedure TMainFrm.ClearBufferItemClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Messagebox(handle,
'Очистить содержимое буфера обмена?',
'Очистка буфера обмена',
mb_IconExclamation + mb_OkCancel) = idOk then
ClipBoard.Clear;
end;

procedure TMainFrm.AddHTMLItemClick(Sender: TObject);
begin
AddHTMLFrm.PageControl.ActivePageIndex := 0;
AddHTMLFrm.ClientHeight := 400;
AddHTMLFrm.ClientWidth := 500;
AddHTMLFrm.Position := poMainFormCenter;
AddHTMLFrm.ShowModal;
end;

procedure TMainFrm.edSearchAndHighlightMouseMove(Sender: TObject;
Shift: TShiftState; X, Y: Integer);
begin
edSearchAndHighlight.SetFocus;
end;

procedure TMainFrm.BorderStyleItemClick(Sender: TObject);
begin
WB_Set3DBorderStyle(GetCurrentWB, not BorderStyleItem.Checked);
end;

procedure TMainFrm.HideScrollBarsItemClick(Sender: TObject);
begin
WB_ShowScrollBar(GetCurrentWB, HideScrollBarsItem.Checked);
end;

procedure TMainFrm.ChangeMessageBoxPosition(var Msg: TMessage);
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
x := MainFrm.Left + ((MainFrm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := MainFrm.Top + ((MainFrm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TMainFrm.MinimizeApplication(Sender: TObject);
begin
if SetFrm.ch24.Checked then
begin
HideToTrayItem.Checked := True;
HideToTray2Item.Checked := True;
ShowWindow(Application.Handle, Sw_Hide);
Shell_NotifyIcon(Nim_Add, @Icon);
end;
end;

procedure TMainFrm.Show_Hint(Sender: TObject);
begin
if AddHTMLFrm.Visible = true then
begin
if SetFrm.ch4.Checked then
begin
if Length(Application.Hint) > 0 then
begin
AddHTMLFrm.StatusBar.SimplePanel := True;
AddHTMLFrm.StatusBar.SimpleText := Application.Hint;
end else
begin
AddHTMLFrm.StatusBar.SimplePanel := False;
end;
end;
end;
if AddHTMLFrm.Visible = False then
begin
if SetFrm.ch4.Checked then
begin
if Length(Application.Hint) > 0 then
begin
StatusBar.SimplePanel := True;
StatusBar.SimpleText := Application.Hint;
end else
begin
StatusBar.SimplePanel := False;
end;
end;
end;
end;

procedure TMainFrm.SystemTrayMenu(var SysTray: TMessage);
var
Ico: TPoint;
begin
case SysTray.LParam of
WM_LBUTTONDBLCLK:
begin
if SetFrm.ch23.Checked then
begin
HideToTrayItem.Checked := False;
HideToTray2Item.Checked := False;
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
if SetFrm.ch25.Checked then
Shell_NotifyIcon(Nim_Delete, @Icon) else
Shell_NotifyIcon(Nim_Add, @Icon);
end;
end;
WM_LBUTTONDOWN:
begin
if not SetFrm.ch23.Checked then
begin
HideToTrayItem.Checked := False;
HideToTray2Item.Checked := False;
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
if SetFrm.ch25.Checked then
Shell_NotifyIcon(Nim_Delete, @Icon) else
Shell_NotifyIcon(Nim_Add, @Icon);
end;
end;
WM_RBUTTONDOWN:
begin
SetForegroundWindow(0);
GetCursorPos(Ico);
TrayMenu.Popup(Ico.X, Ico.Y);
end;
end;
end;

procedure TMainFrm.WMMoving(var msg: TWMMoving);
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

procedure TMainFrm.edURLDblClick(Sender: TObject);
begin
edURl.SelectAll;
end;

procedure TMainFrm.HideToTrayItemClick(Sender: TObject);
begin
if HideToTrayItem.Checked then
begin
HideToTray2Item.Checked := True;
ShowWindow(Application.Handle, SW_HIDE);
ShowWindow(Handle, SW_HIDE);
end else
begin
HideToTray2Item.Checked := False;
ShowWindow(Application.Handle, SW_SHOW);
Application.Restore;
ShowWindow(Handle, SW_SHOW);
end;
end;

procedure TMainFrm.SaveHTMLItemClick(Sender: TObject);
begin
if OpenSaveFileDialog(Handle, '*.txt',
'Текстовые документы (*.txt)|*.txt', ParamStr(1),
'Сохранить HTML код', TextString, False) then
begin
WB_SaveHTMLSourceToFile(TextString, GetCurrentWB);
end;
end;

procedure TMainFrm.SaveAllItemClick(Sender: TObject);
begin
WB_SaveAllPage(GetCurrentWB, 4);
end;

procedure TMainFrm.ListLinksItemClick(Sender: TObject);
begin
LinksFrm.FavoriteList.Clear;
WB_ShowAllLinksPage(GetCurrentWB);
LinksFrm.Position := poMainFormCenter;
LinksFrm.ShowModal;
end;

procedure TMainFrm.BackItemClick(Sender: TObject);
begin
WB_GoBack(GetCurrentWB);
end;

procedure TMainFrm.ForwardItemClick(Sender: TObject);
begin
WB_GoForward(GetCurrentWB);
end;

procedure TMainFrm.HidePanelClick(Sender: TObject);
begin
FindHightlightItem.Checked := False;
HighlightPanel.Visible := False;
end;

procedure TMainFrm.edSearchMouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
if edSearch.Text = 'Google Search' then
edSearch.Text := '';
edSearch.SetFocus;
end;

procedure TMainFrm.edSearchExit(Sender: TObject);
begin
edSearch.Text := 'Google Search';
end;

procedure TMainFrm.SetColor(Value: TColor);
begin
if FColor = Value then
begin
FColor := Value;
Invalidate;
end;
end;

procedure TMainFrm.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
if FColor = clBtnFace then
inherited else
begin
Brush.Color := FColor;
Windows.FillRect(Msg.dc, ClientRect, Brush.Handle);
Msg.Result := 1;
end;
end;

constructor TMainFrm.Create(aOwner: TComponent);
begin
inherited;
FColor := clBtnFace;
end;

function GetIEVersion(Key: string): string;
var
R: TRegistry;
begin
R := TRegistry.Create;
try
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('Software\Microsoft\Internet Explorer', False);
try
Result := R.ReadString(Key);
except
Result := '';
end;
R.CloseKey;
finally
R.Free;
end;
end;

procedure TMainFrm.IEVersionItemClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(PChar('Microsoft Internet Explorer Version:' + #13 + GetIEVersion('Version')),
'Internet Walker',
mb_IconAsterisk + mb_OK);
end;

procedure TMainFrm.WebAddressItemClick(Sender: TObject);
begin
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete', True);
if WebAddressItem.Checked then
r.WriteString('AutoSuggest', 'yes') else
r.WriteString('AutoSuggest', 'no');
CloseKey;
Free;
end;
end;

procedure TMainFrm.WebFormItemClick(Sender: TObject);
begin
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Internet Explorer\Main', True);
if WebFormItem.Checked then
r.WriteString('Use FormSuggest', 'yes') else
r.WriteString('Use FormSuggest', 'no');
CloseKey;
Free;
end;
end;

procedure TMainFrm.WebUserAndPasswrdItemClick(Sender: TObject);
begin
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Internet Explorer\Main', True);
if WebUserAndPasswrdItem.Checked then
r.WriteString('FormSuggest Passwords', 'yes') else
r.WriteString('FormSuggest Passwords', 'no');
CloseKey;
Free;
end;
end;

procedure TMainFrm.ConfirmPasswrdItemClick(Sender: TObject);
begin
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Internet Explorer\Main', True);
if ConfirmPasswrdItem.Checked then
r.WriteString('FormSuggest PW Ask', 'yes') else
r.WriteString('FormSuggest PW Ask', 'no');
CloseKey;
Free;
end;
end;

procedure TMainFrm.StopItemClick(Sender: TObject);
begin
WB_Stop(GetCurrentWB);
end;

procedure OpenURL(Url: string);
var
ts: string;
begin
with TRegistry.Create do
try
rootkey := HKEY_CLASSES_ROOT;
OpenKey('\htmlfile\shell\open\command', False);
try
ts := ReadString('');
except
ts := '';
end;
CloseKey;
finally
Free;
end;
if ts = '' then Exit;
ts := Copy(ts, Pos('"', ts) + 1, Length(ts));
ts := Copy(ts, 1, Pos('"', ts) - 1);
ShellExecute(0, 'open', PChar(ts), PChar(url), nil, SW_SHOW);
end;

procedure TMainFrm.OpenHTMLDefaultItemClick(Sender: TObject);
begin
if edURL.Text = '' then
Exit else
OpenURL(edURL.Text);
end;

procedure TMainFrm.UndoItemClick(Sender: TObject);
begin
WB_UndoLastChange(GetCurrentWB);
end;

procedure TMainFrm.MozillaItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'mozilla.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.MozillaFirefoxItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'firefox.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.InternetExplorerItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'iexplore.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.ICQItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'ICQ.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.DialUpDesktopItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'mstsc.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.DialerItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'dialer.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.PaintItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'MsPaint.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.RegEditItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'RegEdit.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.DxDiagItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'DxDiag.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.AppWizItemClick(Sender: TObject);
begin
WinExec('CONTROL.EXE appwiz.cpl',sw_ShowNormal);
end;

procedure TMainFrm.DiskCleanerItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'cleanmgr.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.MainBarItemClick(Sender: TObject);
begin
if MainBarItem.Checked then
begin
MainBar.Visible := True;
end else
begin
MainBar.Visible := False;
end;
end;

procedure TMainFrm.AdditionalBarItemClick(Sender: TObject);
begin
if AdditionalBarItem.Checked then
begin
AdditionalBar.Visible := True;
end else
begin
AdditionalBar.Visible := False;
end;
end;

procedure TMainFrm.StatusBarItemClick(Sender: TObject);
begin
if StatusBarItem.Checked then
begin
StatusBar.Visible := True;
end else
begin
StatusBar.Visible := False;
end;
end;

procedure TMainFrm.AddressBarItemClick(Sender: TObject);
begin
if AddressBarItem.Checked then
begin
AddressBar.Visible := True;
end else
begin
AddressBar.Visible := False;
end;
end;

procedure TMainFrm.GoogleSearchItemClick(Sender: TObject);
begin
if GoogleSearchItem.Checked then
begin
lbSearch.Visible := True;
edSearch.Visible := True;
btnSearch.Visible := True;
end else
begin
lbSearch.Visible := False;
edSearch.Visible := False;
btnSearch.Visible := False;
end;
end;

procedure TMainFrm.ApplicationEventsIdle(Sender: TObject;
var Done: Boolean);
begin
if MainFrm.Active = False then
begin
Exit;
end else
begin
if SetFrm.ch27.Checked then
begin
Ini.WriteInteger('Position', 'Top', Top);
Ini.WriteInteger('Position', 'Left', Left);
end;
if SetFrm.ch26.Checked then
begin
Ini.WriteInteger('Position', 'Client Height', ClientHeight);
Ini.WriteInteger('Position', 'Client Width', ClientWidth);
end;
Ini.WriteBool('Parameters', 'Context menu IE', ContextMenuItem.Checked);
Ini.WriteBool('Parameters', 'Always on top', OnTopItem.Checked);
end;
end;

procedure TMainFrm.DeleteItemClick(Sender: TObject);
begin
WB_Delete(GetCurrentWB);
end;

procedure TMainFrm.ShowCaptionsItemClick(Sender: TObject);
begin
if ShowCaptionsItem.Checked then
begin
MainBar.ShowCaptions := True;
AdditionalBar.ShowCaptions := True;
end else
begin
MainBar.ShowCaptions := False;
AdditionalBar.ShowCaptions := False;
end;
end;

procedure TMainFrm.Scale50ItemClick(Sender: TObject);
begin
WB_ScalePage_50(GetCurrentWB);
end;

procedure TMainFrm.Scale100ItemClick(Sender: TObject);
begin
WB_ScalePage_100(GetCurrentWB);
end;

procedure TMainFrm.Scale150ItemClick(Sender: TObject);
begin
WB_ScalePage_150(GetCurrentWB);
end;

procedure TMainFrm.Scale200ItemClick(Sender: TObject);
begin
WB_ScalePage_200(GetCurrentWB);
end;

procedure TMainFrm.PrintersItemClick(Sender: TObject);
begin
PrintFrm.Position := poMainFormCenter;
PrintFrm.ShowModal;
end;

procedure TMainFrm.BackTabItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
begin
try
if PageControl.ActivePageIndex <= 0 then
begin
Exit end else
begin
PageControl.ActivePageIndex := PageControl.ActivePageIndex - 1;
end;
except
end;
try
WB_Set3DBorderStyle(GetCurrentWB, not BorderStyleItem.Checked);
BackBt.Enabled := False;
ForwardBt.Enabled := False;
with PageControl do
if ActivePage.ControlCount > 0 then
if ActivePage.Controls[0] is TWebbrowser then
begin
CurrentWB := TWebbrowser(ActivePage.Controls[0]);
WB_SetFocus(CurrentWB);
BackBt.Enabled := CurrentWB.FNavBack;
ForwardBt.Enabled := CurrentWB.FNavForward;
edURL.Text := CurrentWB.LocationURL;
Self.Caption := APP_CAPTION + TWebbrowser(CurrentWB).FTitle;
end;
TWebbrowser(Sender).FTitle := Text;
except
end;
end;

procedure TMainFrm.NextTabItemClick(Sender: TObject);
var
CurrentWB: TWebbrowser;
begin
try
if PageControl.ActivePageIndex = 1 then
begin
Exit end else
begin
PageControl.ActivePageIndex := PageControl.ActivePageIndex + 1;
end;
except
end;
try
WB_Set3DBorderStyle(GetCurrentWB, not BorderStyleItem.Checked);
BackBt.Enabled := False;
ForwardBt.Enabled := False;
with PageControl do
if ActivePage.ControlCount > 0 then
if ActivePage.Controls[0] is TWebbrowser then
begin
CurrentWB := TWebbrowser(ActivePage.Controls[0]);
WB_SetFocus(CurrentWB);
BackBt.Enabled := CurrentWB.FNavBack;
ForwardBt.Enabled := CurrentWB.FNavForward;
edURL.Text := CurrentWB.LocationURL;
Self.Caption := APP_CAPTION + TWebbrowser(CurrentWB).FTitle;
end;
TWebbrowser(Sender).FTitle := Text;
except
end;
end;

procedure TMainFrm.FirstTabItemClick(Sender: TObject);
begin
try
PageControl.ActivePageIndex := 0;
PageControlChange(Self);
except
end;
end;

procedure TMainFrm.CreateHomeTabItemClick(Sender: TObject);
begin
CreateTabBrowser(Text, ExtractFileName(Text));
GetCurrentWB.GoHome;
end;

procedure TMainFrm.CheckConnectItemClick(Sender: TObject);
begin
try
h := LoadLibrary('CheckIC.dll');
if h <> 0 then
begin
CheckInet := GetProcAddress(h, 'CheckInetConnect');
CheckInet;
end else
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(
'Не найдена библиотека "CheckIC.dll".',
'Internet Walker',
mb_OK);
end;
except
end;
end;

procedure TMainFrm.HideToTray2ItemClick(Sender: TObject);
begin
if HideToTray2Item.Checked then
begin
HideToTrayItem.Checked := True;
ShowWindow(Application.Handle, SW_HIDE);
ShowWindow(Handle, SW_HIDE);
end else
begin
HideToTrayItem.Checked := False;
ShowWindow(Application.Handle, SW_SHOW);
Application.Restore;
ShowWindow(Handle, SW_SHOW);
end;
if SetFrm.ch25.Checked then
Shell_NotifyIcon(Nim_Delete, @Icon) else
Shell_NotifyIcon(Nim_Add, @Icon);
end;

procedure TMainFrm.QuickOpenFileItemClick(Sender: TObject);
begin
if OpenSaveFileDialog(Handle, '*.html',
'Файлы HTML|*.htm;*.html|Графические файлы|*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf|Документы Ms WORD|*.rtf; *.doc|Документы Ms EXCEL|*.xls|Текстовые документы|*.txt|XML файлы|*.xml|Веб-архив|*.mht|Все ресурсы|*.*', ParamStr(1),
'Открыть', TextString, True) then
begin
CreateTabBrowser(TextString, ExtractFileName(TextString));
if SetFrm.ch39.Checked then
begin
if not FullScreenItem.Checked then
FullScreenItem.Click;
end;
end;
end;

procedure TMainFrm.QuickPrintItemClick(Sender: TObject);
begin
WB_QuickPrint(GetCurrentWB);
end;

procedure TMainFrm.MaxWinItemClick(Sender: TObject);
begin
SendMessage(Handle, Wm_SysCommand, SC_MAXIMIZE, 0);
end;

function minimize(winhandle: hwnd; param: longINt):
boolean; stdcall;
begin
if (getparent(winhandle) = 0)
and (not IsIconic(winhandle))
and (iswindowvisible(winhandle))
then
postmessage(winhandle, wm_syscommand, sc_minimize, 0);
Result := true;
end;

procedure TMainFrm.MinAllWinItemClick(Sender: TObject);
begin
EnumWindows(@minimize, 0);
end;

procedure TMainFrm.MinWinItemClick(Sender: TObject);
begin
sendmessage(handle, wm_syscommand, sc_minimize, 0);
end;

procedure TMainFrm.MinCurItemClick(Sender: TObject);
var
Min: hwnd;
begin
min := application.handle;
repeat
min := getnextwindow(min, gw_hwndnext);
if (getparent(min) = 0)
and ( not IsIconic(min))
and (isWindowVisible(min))
then
sendmessage(min, wm_syscommand, sc_minimize, 0);
until (min = 0);
end;

procedure TMainFrm.KillNotMinWinItemClick(Sender: TObject);
var
Min: hwnd;
begin
min := MainFrm.handle;
repeat
min := getnextwindow(min, gw_hwndnext);
if (getparent(min) = 0)
and ( not IsIconic(min))
and (isWindowVisible(min))
then
sendmessage(min, wm_syscommand, sc_close, 0);
until (min = 0);
end;

procedure TMainFrm.ExplorerItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'explorer.exe', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.TaskMngItemClick(Sender: TObject);
begin
shellExecute(handle, nil, 'taskmgr', nil,nil, sw_shownormal);
end;

procedure TMainFrm.ExportItemClick(Sender: TObject);
begin
ImportFrm.Position := poMainFormCenter;
ImportFrm.ShowModal;
end;

procedure TMainFrm.OpenAddressItemClick(Sender: TObject);
begin
if AddressBar.Visible = True then
begin
edURL.SetFocus;
end else
begin
OpenFrm.Position := poMainFormCenter;
OpenFrm.ShowModal;
end;
end;

procedure TMainFrm.N95Click(Sender: TObject);
var
dir: String;
begin
try
PostMessage(Handle, WM_USER + 1024, 0, 0);
if SelectDirectory('Internet Walker' + #13 + 'Укажите папку для перехода.', '', dir) then
begin
edURL.Text := dir;
WB_Navigate(GetCurrentWB, edURL.Text);
WB_SetFocus(GetCurrentWB);
end;
except
end;
end;

procedure TMainFrm.ExecuteItemClick(Sender: TObject);
begin
try
h := LoadLibrary('RunDlg.dll');
if h <> 0 then
begin
ShowRunDlg := GetProcAddress(h, 'RunProgramDialog');
ShowRunDlg;
end else
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(
'Не найдена библиотека "RunDlg.dll".',
'Internet Walker',
mb_OK);
end;
except
end;
end;

procedure TMainFrm.d1Click(Sender: TObject);
begin
try
h := LoadLibrary('ShutDownDlg.dll');
if h <> 0 then
begin
ShowShutDownDlg := GetProcAddress(h, 'ShowShutDownDialog');
ShowShutDownDlg;
end else
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(
'Не найдена библиотека "ShutDownDlg.dll".',
'Internet Walker',
mb_OK);
end;
except
end;
end;

procedure TMainFrm.HomeWebPageItemClick(Sender: TObject);
begin
edURL.Text := 'http://viacoding.ucoz.ru/';
WB_Navigate(GetCurrentWB, edURL.Text);
end;

procedure TMainFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if SetFrm.ch5.Checked then
CanClose :=
Application.MessageBox('Вы уверены, что хотите выйти?',
'Internet Walker',
mb_IconQuestion + mb_YesNo) = mrYes
else
if SetFrm.ch3.Checked then
if PageControl.ActivePageIndex <= 0 then
Exit else
CanClose :=
Application.MessageBox('Вы уверены, что хотите закрыть все вкладки и выйти?',
'Internet Walker',
mb_IconQuestion + mb_YesNo) = mrYes;
end;

procedure TMainFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if SetFrm.ch40.Checked then
begin
Action := caNone;
Application.Minimize;
ShowWindow(Application.Handle, SW_HIDE);
ShowWindow(Handle, SW_HIDE);
Shell_NotifyIcon(Nim_Add, @Icon);
HideToTrayItem.Checked := True;
HideToTray2Item.Checked := True;
end;
if SetFrm.ch22.Checked then
begin
AnimateWindow(MainFrm.Handle, 400, AW_SLIDE or AW_BLEND or AW_HIDE);
end;
if WindowState = wsMaximized then
WindowState := wsNormal;
end;

procedure TMainFrm.FormActivate(Sender: TObject);
begin
if SetFrm.ch25.Checked then
Shell_NotifyIcon(Nim_Delete, @Icon) else
Shell_NotifyIcon(Nim_Add, @Icon);
end;

procedure TMainFrm.edURLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = vk_RETURN then
btnGoClick(Self);
end;

initialization
OleInitialize(nil);
Set8087CW($133F);

ScreenLogoFrm := TScreenLogoFrm.Create(nil);
ShowCursor(False);
ScreenLogoFrm.Show;
Application.ProcessMessages;
Sleep(500);
ScreenLogoFrm.Hide;
ShowCursor(True);
ShowWindow(Application.Handle, Sw_Show);

finalization
OleUninitialize

end.
