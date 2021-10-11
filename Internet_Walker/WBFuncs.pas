unit WBFuncs;

interface

uses
  Windows, Messages, SysUtils, Dialogs, {$IFDEF DELPHI6UP}Variants, {$ENDIF}Forms, Classes,
  MSHTML, UrlMon, SHDocVw, ShellAPI, Variants, WinInet, Controls, ActiveX, ComObj, ComCtrls,
  Graphics, ListLink, Registry;

 type
  TMyBrowser = SHDocVw.TWebbrowser;
  TWebbrowser = TMyBrowser;

 const
  CGID_WebBrowser: TGUID = '{ED016940-BD5B-11cf-BA4E-00C04FD70816}';
  HTMLID_FIND = 1;
  HTMLID_VIEWSOURCE = 2;
  HTMLID_OPTIONS = 3;

 type
  TWBFontSize = 0..4;

 type
  TEnumFramesProc = function(AHtmlDocument: IHtmlDocument2; Data: Integer): Boolean;


function WB_DocumentLoaded(WB: TWebbrowser): Boolean;
function WB_QueryCommandEnabled(WB: TWebbrowser; const Command: string): Boolean;
function VariantIsObject(const value: OleVariant): boolean;
function InvokeCMD(WB: TWebbrowser; nCmdID: DWORD): Boolean; overload;
function InvokeCMD(WB: TWebbrowser; InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant): Boolean; overload;

procedure WaitForBrowser(WB: TWebbrowser);
procedure WB_Navigate(WB: TWebbrowser; const URL: string);
procedure WB_SetFocus(WB: TWebbrowser);
procedure WB_GoBack(WB: TWebbrowser);
procedure WB_GoForward(WB: TWebbrowser);
procedure WB_Stop(WB: TWebbrowser);
procedure WB_Refresh(WB: TWebbrowser);

procedure WB_Copy(WB: TWebbrowser);
procedure WB_Paste(WB: TWebbrowser);
procedure WB_Cut(WB: TWebbrowser);
procedure WB_SelectAll(WB: TWebbrowser);
procedure WB_Save(WB: TWebbrowser);

procedure WB_ScrollToTop(WB: TWebbrowser);
procedure WB_ScrollToBottom(WB: TWebbrowser);

procedure SetGlobalOffline(Value: Boolean);
function IsGlobalOffline: Boolean;

procedure WB_ShowPrintDialog(WB: TWebbrowser);
procedure WB_ShowPrintPreview(WB: TWebbrowser);
procedure WB_ShowPageSetup(WB: TWebbrowser);
procedure WB_ShowFindDialog(WB: TWebbrowser);
procedure WB_ShowPropertiesDialog(WB: TWebbrowser);

function WB_SetCharSet(WB: TWebbrowser; const ACharSet: string): Boolean;
procedure WB_Set3DBorderStyle(WB: TWebBrowser; bValue: Boolean);
procedure WB_SearchAndHighlightText(WB: TWebbrowser; aText: string);
procedure WB_ShowScrollBar(WB: TWebbrowser; Value: boolean);
procedure WB_SetZoom(WB: TWebBrowser; Size: TWBFontSize);
function WB_GetZoom(WB: TWebBrowser): TWBFontSize;
function WB_GetCookie(WB: TWebBrowser): string;

procedure WB_ShowSourceCode(WB: TWebbrowser);

function GetElementAtPos(Doc: IHTMLDocument2; x, y: integer): IHTMLElement;
function GetZoneIcon(IconPath: string; var Icon: TIcon): boolean;

function GetZoneAttributes(const URL: string): TZoneAttributes;
function GetCachedFileFromURL(strUL: string; var strLocalFile: string): boolean;

function EnumFrames(AHtmlDocument: IHtmlDocument2;
EnumFramesProc: TEnumFramesProc; Data: Integer): Boolean;
procedure WB_GetObjectView(TV: TTreeView; WB: TWebBrowser);
function WB_GetPlainText(WB: TWebbrowser; s: TStrings): string;
function WB_GetFields(WebBrowser: TWebBrowser; SL: TStrings): Boolean;
procedure WB_GetImages(AWebbrowser: TWebbrowser; sl: TStrings);
procedure WB_GetLinks(WB: TWebbrowser; sl: TStrings);
function WB_GetDocumentSourceToString(Document: IDispatch): string;

procedure WB_ScrollUp(WB: TWebbrowser);
procedure WB_ScrollDown(WB: TWebbrowser);
procedure WB_ScrollLeft(WB: TWebbrowser);
procedure WB_ScrollRight(WB: TWebbrowser);
procedure WB_ClearSelection(WB: TWebbrowser);
procedure WB_ClearAll(WB: TWebbrowser);
procedure WB_Delete(WB: TWebbrowser);
procedure WB_ClearAndPasteFromBuffer(WB: TWebbrowser);
procedure WB_SaveHTMLSourceToFile(const FileName: string; WB: TWebbrowser);
procedure WB_SaveAllPage(WB: TWebbrowser; i: Integer );
procedure WB_ShowAllLinksPage(WB: TWebbrowser);
procedure WB_UndoLastChange(WB: TWebbrowser);

procedure WB_ScalePage_50(WB: TWebbrowser);
procedure WB_ScalePage_100(WB: TWebbrowser);
procedure WB_ScalePage_150(WB: TWebbrowser);
procedure WB_ScalePage_200(WB: TWebbrowser);
procedure WB_AddtoFavorites(WB: TWebbrowser);
procedure WB_QuickPrint(WB: TWebbrowser);

implementation

// Check if Webbrowser Document is loaded
function WB_DocumentLoaded(WB: TWebbrowser): Boolean;
var
iDoc: IHtmlDocument2;
begin
Result := False;
if Assigned(WB) then
begin
if WB.Document <> nil then
begin
WB.ControlInterface.Document.QueryInterface(IHtmlDocument2, iDoc);
Result := Assigned(iDoc);
end;
end;
end;

(*Returns a Boolean value that indicates whether a specified command
can be successfully executed using execCommand.*)
function WB_QueryCommandEnabled(WB: TWebbrowser; const Command: string): Boolean;
var
Doc: IHTMLDocument2;
begin
Result := False;
Doc := WB.Document as IHTMLDocument2;
if Assigned(doc) then
Result := Doc.QueryCommandEnabled(Command);
end;

function VariantIsObject(const value: OleVariant): boolean;
begin
result := ((value) = varDispatch);
end;

(*Execute a specified command or displays help for a command.
The IOleCommandTarget interface enables objects and their
containers to dispatch commands to each other. For example,
an object's toolbars may contain buttons for commands such as
 Print, Print Preview, Save, New, and Zoom.*)
function InvokeCMD(WB: TWebbrowser; nCmdID: DWORD): Boolean;
var
vaIn, vaOut: OleVariant;
begin
Result := InvokeCMD(WB, True, nCmdID, 0, vaIn, vaOut);
end;

function InvokeCMD(WB: TWebbrowser; InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant): Boolean;
var
CmdTarget: IOleCommandTarget;
PtrGUID: PGUID;
begin
New(PtrGUID);
if InvokeIE then
PtrGUID^ := CGID_WebBrowser else
PtrGuid := PGUID(nil);
if WB.Document <> nil then
try
WB.Document.QueryInterface(IOleCommandTarget, CmdTarget);
if CmdTarget <> nil then
try
CmdTarget.Exec(PtrGuid, Value1, Value2, vaIn, vaOut);
finally
CmdTarget._Release;
end;
except
end;
Dispose(PtrGUID);
end;

(*wait until document loaded
READYSTATE_COMPLETE: The current document is fully downloaded*)
procedure WaitForBrowser(WB: TWebbrowser);
begin
while (WB.ReadyState <> READYSTATE_COMPLETE) and not (Application.Terminated) do
begin
Application.ProcessMessages;
Sleep(0);
end;
end;

// Navigate to a page
procedure WB_Navigate(WB: TWebbrowser; const URL: string);
var
BrowserFlags: OleVariant;
MyTargetFrameName: OleVariant;
MyPostaData: OleVariant;
MyHeaders: OleVariant;
begin
if Assigned(WB) then
begin
BrowserFlags := $02;
MyTargetFrameName := 0;
MyPostaData := 0;
MyHeaders := 0;
WB.Navigate(URL, BrowserFlags, MyTargetFrameName, MyPostaData, MyHeaders);
WaitforBrowser(WB);
end;
end;

// Set Focus on Webbrowser Document
procedure WB_SetFocus(WB: TWebbrowser);
begin
if WB_DocumentLoaded(WB) then (WB.Document as IHTMLDocument2).ParentWindow.Focus;
end;

// Navigate Back in History
procedure WB_GoBack(WB: TWebbrowser);
begin
try
if WB_DocumentLoaded(WB) then
WB.GoBack;
except
end;
end;

// Navigate Forward in History
procedure WB_GoForward(WB: TWebbrowser);
begin
try
if WB_DocumentLoaded(WB) then
WB.GoForward;
except
end;
end;

// Stop loading Webbrowser Document
procedure WB_Stop(WB: TWebbrowser);
begin
try
if WB_DocumentLoaded(WB) then
WB.Stop;
except
end;
end;

// Refresh Webbrowser
procedure WB_Refresh(WB: TWebbrowser);
const
REFRESH_COMPLETELY = 3;
var
KeyState: TKeyBoardState;
RefreshLevel: OleVariant;
begin
if WB_DocumentLoaded(WB) then
begin
GetKeyboardState(KeyState);
try
if not ((KeyState[vk_Control] and 128) <> 0) then
WB.Refresh else
RefreshLevel := REFRESH_COMPLETELY;
WB.DefaultInterface.Refresh2(RefreshLevel);
except
end;
end;
end;

// Copy selected Text
procedure WB_Copy(WB: TWebbrowser);
var
vaIn, vaOut: Olevariant;
begin
InvokeCmd(WB, FALSE, OLECMDID_COPY, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

// Paste from Clipboard
procedure WB_Paste(WB: TWebbrowser);
var
vaIn, vaOut: Olevariant;
begin
InvokeCmd(WB, FALSE, OLECMDID_PASTE, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

// Select All Webbrowser Document
procedure WB_SelectAll(WB: TWebbrowser);
var
vaIn, vaOut: Olevariant;
begin
InvokeCmd(WB, FALSE, OLECMDID_SELECTALL, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

// Cut selected Text
procedure WB_Cut(WB: TWebbrowser);
var
vaIn, vaOut: Olevariant;
begin
InvokeCmd(WB, FALSE, OLECMDID_CUT, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

// Save Webbrowser Document
procedure WB_Save(WB: TWebbrowser);
var
Dispatch: IDispatch;
CommandTarget: IOleCommandTarget;
vaIn: OleVariant;
vaOut: OleVariant;
begin
if WB_DocumentLoaded(WB) then
if not (WB.Busy) then
begin
Dispatch := WB.Document;
Dispatch.QueryInterface(IOleCommandTarget, CommandTarget);
vaIn := '';
vaOut := '';
try
CommandTarget.Exec(PGUID(nil),
OLECMDID_SAVEAS, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
except
on E: Exception do
MessageDlg('ERROR: Unable to show Save As dialog. ' + #13 + E.ClassName
+ ': ' + E.Message + '.', mtError, [mbOk], 0);
end;
end;
end;

// Scroll To Top of Webbrowser Document
procedure WB_ScrollToTop(WB: TWebbrowser);
begin
if WB_DocumentLoaded(WB) then
begin
try
WB.OleObject.Document.ParentWindow.ScrollTo(0, 0);
except
end;
end;
end;

// Scroll To Bottom of Webbrowser Document
procedure WB_ScrollToBottom(WB: TWebbrowser);
begin
if WB_DocumentLoaded(WB) then
begin
try
WB.OleObject.Document.ParentWindow.ScrollTo(0, MaxInt);
except
end;
end;
end;

// Set Global Offline
procedure SetGlobalOffline(Value: Boolean);
const
INTERNET_STATE_DISCONNECTED_BY_USER = $10;
ISO_FORCE_DISCONNECTED = $1;
INTERNET_STATE_CONNECTED = $1;
var
ci: TInternetConnectedInfo;
dwSize: DWORD;
begin
dwSize := SizeOf(ci);
if (Value) then
begin
ci.dwConnectedState := INTERNET_STATE_DISCONNECTED_BY_USER;
ci.dwFlags := ISO_FORCE_DISCONNECTED;
end else
begin
ci.dwFlags := 0;
ci.dwConnectedState := INTERNET_STATE_CONNECTED;
end;
InternetSetOption(nil, INTERNET_OPTION_CONNECTED_STATE, @ci, dwSize);
end;

// Query Global Offline
function IsGlobalOffline: Boolean;
var
dwState: DWORD;
dwSize: DWORD;
begin
dwState := 0;
dwSize := SizeOf(dwState);
Result := False;
if (InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE, @dwState, dwSize)) then
if ((dwState and INTERNET_STATE_DISCONNECTED_BY_USER) <> 0) then
Result := True;
end;

// Show Printer Dialog
procedure WB_ShowPrintDialog(WB: TWebbrowser);
begin
if WB_DocumentLoaded(WB) then
begin
WB.ExecWB(OLECMDID_PRINT,1);
end;
end;

// Show Printer Preview Dialog
procedure WB_ShowPrintPreview(WB: TWebbrowser);
var
vaIn, vaOut: OleVariant;
begin
if WB_DocumentLoaded(WB) then
try
WB.ControlInterface.ExecWB(OLECMDID_PRINTPREVIEW,
OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
except
end;
end;

// Show Page Setup Dialog
procedure WB_ShowPageSetup(WB: TWebbrowser);
var
vaIn, vaOut: OleVariant;
begin
if WB_DocumentLoaded(WB) then
try
WB.ControlInterface.ExecWB(OLECMDID_PAGESETUP, OLECMDEXECOPT_PROMPTUSER, vaIn, vaOut);
except
end;
end;

// Show Find Dialog
procedure WB_ShowFindDialog(WB: TWebbrowser);
begin
InvokeCMD(WB, HTMLID_FIND);
end;

// Show Properties Dialog (for local Files)
procedure ShowFileProperties(const FileName: string);
var
sei: TShellExecuteInfo;
begin
FillChar(sei, SizeOf(sei), 0);
sei.cbSize := SizeOf(sei);
sei.lpFile := PChar(FileName);
sei.lpVerb := 'properties';
sei.fMask := SEE_MASK_INVOKEIDLIST;
ShellExecuteEx(@sei);
end;

// Show Properties Dialog
procedure WB_ShowPropertiesDialog(WB: TWebbrowser);
var
eQuery: OLECMDF;
vaIn, vaOut: OleVariant;
begin
if WB_DocumentLoaded(WB) then
begin
if FileExists(WB.Locationname) then
ShowFileProperties(WB.Locationname) else
begin
try
eQuery := WB.QueryStatusWB(OLECMDID_PROPERTIES);
if (eQuery and OLECMDF_ENABLED) = OLECMDF_ENABLED then
WB.ExecWB(OLECMDID_PROPERTIES, OLECMDEXECOPT_PROMPTUSER, vaIn, vaOut);
except
end;
end;
end;
end;

// Show Webbrowser Source Code (in standard editor)
procedure WB_ShowSourceCode(WB: TWebbrowser);
begin
InvokeCMD(WB, HTMLID_VIEWSOURCE);
end;

// Get Element under mouse cursor
function GetElementAtPos(Doc: IHTMLDocument2; x, y: integer): IHTMLElement;
begin
Result := nil;
Result := Doc.elementFromPoint(x, y);
end;

// Retrieve the Zone Icon
function GetZoneIcon(IconPath: string; var Icon: TIcon): boolean;
var
FName, ImageName: string;
h: hInst;
begin
Result := False;
FName := Copy(IconPath, 1, Pos('#', IconPath) - 1);
ImageName := Copy(IconPath, Pos('#', IconPath), Length(IconPath));
h := LoadLibrary(Pchar(FName));
try
if h <> 0 then
begin
Icon.Handle := LoadImage(h, Pchar(ImageName), IMAGE_ICON, 16, 16, 0);
Result := True;
end;
finally
FreeLibrary(h);
end;
end;

// GetZoneAttributes
function GetZoneAttributes(const URL: string): TZoneAttributes;
var
dwZone: Cardinal;
ZoneAttr: TZoneAttributes;
var
ZoneManager: IInternetZoneManager;
SecManager: IInternetSecurityManager;
begin
ZeroMemory(@ZoneAttr, SizeOf(TZoneAttributes));
if CoInternetCreateSecuritymanager(nil, SecManager, 0) = S_OK then
if CoInternetCreateZoneManager(nil, ZoneManager, 0) = S_OK then
begin
SecManager.MapUrlToZone(PWideChar(WideString(URL)), dwZone, 0);
ZoneManager.GetZoneAttributes(dwZone, Result);
end;
end;

// Set Zoom
procedure WB_SetZoom(WB: TWebBrowser; Size: TWBFontSize);
var
V: OleVariant;
begin
if WB_DocumentLoaded(WB) then
begin
V := Size;
WB.ExecWB(OLECMDID_ZOOM, OLECMDEXECOPT_DODEFAULT, V);
end;
end;

// Get Zoom
function WB_GetZoom(WB: TWebBrowser): TWBFontSize;
var
vaIn, vaOut: Olevariant;
begin
result := 0;
if WB_DocumentLoaded(WB) then
begin
vaIn := 0;
InvokeCmd(WB, FALSE, OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
result := vaOut;
end;
end;

// Display the Source Code
procedure WB_GetDocumentSourceToStream(Document: IDispatch; Stream: TStream);
var
PersistStreamInit: IPersistStreamInit;
StreamAdapter: IStream;
begin
Assert(Assigned(Document));
Stream.Size := 0;
Stream.Position := 0;
if Document.QueryInterface(IPersistStreamInit,
PersistStreamInit) = S_OK then
begin
StreamAdapter := TStreamAdapter.Create(Stream, soReference);
PersistStreamInit.Save(StreamAdapter, False);
StreamAdapter := nil;
end;
end;

function WB_GetDocumentSourceToString(Document: IDispatch): string;
var
Stream: TStringStream;
begin
Result := '';
Stream := TStringStream.Create('');
try
WB_GetDocumentSourceToStream(Document, Stream);
Result := StringReplace(Stream.Datastring, #$A#9, #$D#$A, [rfReplaceAll]);
Result := StringReplace(Result, #$A, #$D#$A, [rfReplaceAll]);
if Copy(Result, 1, 3) = 'ÿþ<' then
Result := '';
finally
Stream.Free;
end;
end;

// Enumerate Webbrowser Link Names
procedure WB_getLinks(WB: TWebbrowser; sl: TStrings);
var
u: variant;
v: IDispatch;
s: string;
procedure RecurseLinks(htmlDoc: variant);
var
BodyElement: Olevariant;
ElementCo: Olevariant;
HTMLFrames: Olevariant;
HTMLWnd: Olevariant;
doc: Olevariant;
j, i: integer;
begin
if not(htmlDoc) then
exit;
BodyElement := htmlDoc.body;
if BodyElement.tagName = 'BODY' then
begin
ElementCo := htmlDoc.links;
j := ElementCo.Length - 1;
for i := 0 to j do
begin
u := ElementCo.item(i);
s := u.href;
sl.Add(s);
end;
end;
HTMLFrames := htmlDoc.Frames;
j := HTMLFrames.length - 1;
for i := 0 to j do
begin
HTMLWnd := HTMLFrames.Item(i);
try
doc := HTMLWnd.Document;
RecurseLinks(doc);
except
continue;
end;
end;
end;
begin
v := WB.document;
sl.Clear;
RecurseLinks(v);
end;

{ ************************************************************************* }
// Enumerate Webbrowser Image Frame Names

{
// basic code:

procedure WB_GetFrames(AWebbrowser: TWebbrowser; sl: TStrings);
var
  i: Integer;
begin
  sl.Clear;
  if AWebbrowser.OleObject.Document.Frames.Length <> 0 then
  begin
    for i := 0 to AWebbrowser.OleObject.Document.Frames.Length - 1 do
    begin
      sl.Add(AWebbrowser.OleObject.Document.Frames.item(i).Document.URL);
    end;
  end;
end;
}

// enumerate nested frames (recursive)
function EnumFrames(AHtmlDocument: IHtmlDocument2;
EnumFramesProc: TEnumFramesProc; Data: Integer): Boolean;

function Enum(AHtmlDocument: IHtmlDocument2): Boolean;
var
OleContainer: IOleContainer;
EnumUnknown: IEnumUnknown;
Unknown: IUnknown;
Fetched: LongInt;
WebBrowser: IWebBrowser;
begin
Result := True;
if not Assigned(AHtmlDocument) then
Exit;
Result := EnumFramesProc(AHtmlDocument, Data);
if not Result then
Exit;
if not Supports(AHtmlDocument, IOleContainer, OleContainer) then
Exit;
if Failed(OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, EnumUnknown)) then
Exit;
while (EnumUnknown.Next(1, Unknown, @Fetched) = S_OK) do
if Supports(Unknown, IWebBrowser, WebBrowser) then
begin
Result := Enum(WebBrowser.Document as IHtmlDocument2);
if not Result then
Exit;
end;
end;
begin
Result := Enum(AHtmlDocument);
end;

// Enumerate Webbrowser Elements // Object View
procedure WB_GetObjectView(TV: TTreeView; WB: TWebBrowser);
var
i, j, k: Integer;
FormItem, Element, SubElement: OleVariant;
root: TTreeNodes;
child, child2, child3: TTreeNode;
s_type: string;
begin
root := TV.Items;
root.Clear;
TV.Items.BeginUpdate;
try
for I := 0 to WB.OleObject.Document.forms.Length - 1 do
begin
FormItem := WB.OleObject.Document.forms.Item(I);
if VariantIsObject(FormItem.Name) then
child := root.AddChild(nil, 'Form' + IntToStr(i) + ': ' + FormItem.Name.Name) else
child := root.AddChild(nil, 'Form' + IntToStr(i) + ': ' + FormItem.Name);
child.ImageIndex := 3;
child.SelectedIndex := 3;
for j := 0 to FormItem.Length - 1 do
begin
try
Element := FormItem.Item(j);
child2 := root.AddChild(child, Element.Name + ' = ' + Element.Value);
s_type := Element.Type;
if s_type = 'submit' then
child2.ImageIndex := 1
else if s_type = 'text' then
child2.ImageIndex := 0
else if s_type = 'file' then
child2.ImageIndex := 2
else if s_type = 'hidden' then
child2.ImageIndex := 4
else if s_type = 'checkbox' then
child2.ImageIndex := 5
else if s_type = 'radio' then
child2.ImageIndex := 6
else if s_type = 'select-one' then
child2.ImageIndex := 7
else
child2.ImageIndex := -1;
child2.SelectedIndex := child2.ImageIndex;
Child3 := root.AddChild(child2, s_type);
child3.ImageIndex := -1;
child3.SelectedIndex := -1;
if s_type = 'text' then
begin
child3 := root.AddChild(child2, 'MaxLen=' + IntToStr(Element.maxLength));
child3.ImageIndex := -1;
child3.SelectedIndex := -1;
end else if s_type = 'select-one' then
begin
for k := 0 to Element.Options.Length - 1 do
begin
SubElement := Element.Options.Item(k);
child3 := root.AddChild(child2, SubElement.Text + ' = <' + SubElement.Value + '>');
child3.ImageIndex := -1;
child3.SelectedIndex := -1;
end;
end;
except
on E: Exception do
root.AddChild(child, E.Message);
end;
end;
end;
if root.Count > 0 then
root.GetFirstNode.Expand(True);
finally
TV.Items.EndUpdate;
end;
end;

// Get Cached File Path From URL
function GetCachedFileFromURL(strUL: string; var strLocalFile: string): boolean;
var
lpEntryInfo: PInternetCacheEntryInfo;
hCacheDir: LongWord;
dwEntrySize: LongWord;
dwLastError: LongWord;
begin
Result := False;
dwEntrySize := 0;
FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
GetMem(lpEntryInfo, dwEntrySize);
hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
if (hCacheDir <> 0) and (strUL = lpEntryInfo^.lpszSourceUrlName) then
begin
strLocalFile := lpEntryInfo^.lpszLocalFileName;
Result := True;
end;
FreeMem(lpEntryInfo);
if Result = False then
repeat
dwEntrySize := 0;
FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
dwLastError := GetLastError();
if (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
begin
GetMem(lpEntryInfo, dwEntrySize);
if (FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize)) then
begin
if strUL = lpEntryInfo^.lpszSourceUrlName then
begin
strLocalFile := lpEntryInfo^.lpszLocalFileName;
Result := True;
Break;
end;
end;
FreeMem(lpEntryInfo);
end;
until (dwLastError = ERROR_NO_MORE_ITEMS);
end;

// Enumerate Webbrowser Image Link Names
procedure WB_GetImages(AWebbrowser: TWebbrowser; sl: TStrings);
var
k: Integer;
sImageURL: string;
strLocalFile: string;
begin
sl.Clear;
for k := 0 to AWebbrowser.OleObject.Document.Images.Length - 1 do
begin
sImageURL := AWebbrowser.OleObject.Document.Images.Item(k).Src;
sl.Add('--url  :' + sImageURL);
GetCachedFileFromURL(sImageURL, strLocalFile);
sl.Add('--local:' + strLocalFile);
end;
end;

// Get the plain Text
function WB_GetPlainText(WB: TWebbrowser; s: TStrings): string;
var
IDoc: IHTMLDocument2;
Strl: TStringList;
sHTMLFile: string;
v: Variant;
begin
sHTMLFile := WB_GetDocumentSourceToString(WB.Document);
Strl := TStringList.Create;
try
Strl.Add(sHTMLFile);
Idoc := CreateComObject(Class_HTMLDOcument) as IHTMLDocument2;
try
IDoc.designMode := 'on';
while IDoc.readyState <> 'complete' do
Application.ProcessMessages;
v[0] := Strl.Text;
IDoc.write(PSafeArray(System.TVarData(v).VArray));
IDoc.designMode := 'off';
while IDoc.readyState <> 'complete' do
Application.ProcessMessages;
s.Text := IDoc.body.innerText;
finally
IDoc := nil;
end;
finally
Strl.Free;
end;
end;

// Enumerate Webbrowser Field Names
function Wb_GetFields(WebBrowser: TWebBrowser; SL: TStrings): Boolean;
var
i, j: Integer;
FormItem: Variant;
begin
sl.Clear;
Result := True;
if WebBrowser.OleObject.Document.all.tags('FORM').Length = 0 then
begin
Result := False;
Exit;
end;
for I := 0 to WebBrowser.OleObject.Document.forms.Length - 1 do
begin
FormItem := WebBrowser.OleObject.Document.forms.Item(I);
for j := 0 to FormItem.Length - 1 do
begin
try
SL.Add('Name :' + FormItem.Item(j).Name + ' ; ' +
'ID :' + FormItem.Item(j).ID + ' ; ' +
'TagName :' + FormItem.Item(j).TagName + ' ; ' +
'toString :' + FormItem.Item(j).toString + ' ; ' +
'innerText :' + FormItem.Item(j).innerText + ' ; ' +
'innerHTML :' + FormItem.Item(j).innerHTML);
except
Result := False;
Exit;
end;
end;
end;
end;

// search and highlight text in TWebBrowser?
procedure WB_SearchAndHighlightText(WB: TWebbrowser; aText: string);
var
tr: IHTMLTxtRange;
begin
if not (WB.Busy) and (WB.Document <> nil) then
begin
if Length(aText) > 0 then
begin
tr := ((WB.Document as IHTMLDocument2).body as IHTMLBodyElement).createTextRange;
while tr.findText(aText, 1, 0) do
begin
tr.pasteHTML('<span style="background-color: Red; font-weight: bolder;">' +
tr.htmlText + '</span>');
tr.scrollIntoView(True);
end;
end;
end;
end;

// Show/Hide 3D border style
procedure WB_Set3DBorderStyle(WB: TWebBrowser; bValue: Boolean);
var
Document: IHTMLDocument2;
Element: IHTMLElement;
StrBorderStyle: string;
begin
if Assigned(WB) then
begin
Document := TWebBrowser(WB).Document as IHTMLDocument2;
if Assigned(Document) then
begin
Element := Document.Body;
if Element <> nil then
begin
case bValue of
False: StrBorderStyle := 'none';
True: StrBorderStyle := '';
end;
Element.Style.BorderStyle := StrBorderStyle;
end;
end;
end;
end;

// Show / Hide scrollbars
// http://msdn.microsoft.com/library/default.asp?url=/workshop/author/dhtml/reference/properties/overflow.asp
procedure WB_ShowScrollBar(WB: TWebbrowser; Value: boolean);
begin
if WB_DocumentLoaded(WB) then
if Assigned((WB.Document as IHTMLDocument2).body) then
if Value then
(WB.Document as IHTMLDocument2).body.style.overflow := 'hidden' else
(WB.Document as IHTMLDocument2).body.style.overflow := '';
end;


// Set Webbrowser Characterset
// http://msdn.microsoft.com/library/default.asp?url=/workshop/author/dhtml/reference/charsets/charset4.asp
function WB_SetCharSet(WB: TWebbrowser; const ACharSet: string): Boolean;
var
RefreshLevel: OleVariant;
begin
Result := False;
if WB_DocumentLoaded(WB) then
try
IHTMLDocument2(WB.Document).Set_CharSet(ACharSet);
Result := True;
RefreshLevel := 7;
WB.Refresh2(RefreshLevel);
except
end;
end;

// Get Cookie
// http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/ifaces/document2/cookie.asp
function WB_GetCookie(WB: TWebBrowser): string;
var
document: IHTMLDocument2;
begin
Result := '';
if WB_DocumentLoaded(WB) then
begin
document := WB.Document as IHTMLDocument2;
if Assigned(document) then
Result := document.cookie;
end;
end;

// Scroll Up
procedure WB_ScrollUp(WB: TWebbrowser);
begin
WB.OleObject.Document.ParentWindow.ScrollBy(0, -100);
end;

// Scroll Down
procedure WB_ScrollDown(WB: TWebbrowser);
begin
WB.OleObject.Document.ParentWindow.ScrollBy(0, +100);
end;

// Scroll Left
procedure WB_ScrollLeft(WB: TWebbrowser);
begin
WB.OleObject.Document.ParentWindow.ScrollBy(-100, 0);
end;

// Scroll Right
procedure WB_ScrollRight(WB: TWebbrowser);
begin
WB.OleObject.Document.ParentWindow.ScrollBy(+100, 0);
end;

// Clear Selection
procedure WB_ClearSelection(WB: TWebbrowser);
begin
WB.ExecWB(OLECMDID_CLEARSELECTION, 1);
end;

// Clear All
procedure WB_ClearAll(WB: TWebbrowser);
begin
WB.ExecWB(OLECMDID_SELECTALL, 1);
WB.ExecWB(OLECMDID_DELETE, 1);
end;

// Delete
procedure WB_Delete(WB: TWebbrowser);
begin
WB.ExecWB(OLECMDID_DELETE, 1);
end;

// Clear and paste from buffer
procedure WB_ClearAndPasteFromBuffer(WB: TWebbrowser);
begin
WB.ExecWB(OLECMDID_SELECTALL, 1);
WB.ExecWB(OLECMDID_delete, 1);
WB.ExecWB(OLECMDID_SELECTALL, 1);
WB.ExecWB(OLECMDID_PASTE, 1);
end;

// Save HTML code
procedure WB_SaveHTMLSourceToFile(const FileName: string; WB: TWebbrowser);
var
PersistStream: IPersistStreamInit;
FileStream: TFileStream;
Stream: IStream;
SaveResult: HRESULT;
begin
PersistStream := WB.Document as IPersistStreamInit;
FileStream := TFileStream.Create(FileName, fmCreate);
try
Stream := TStreamAdapter.Create(FileStream, soReference) as IStream;
SaveResult := PersistStream.Save(Stream, True);
finally
FileStream.Free;
end;
end;

// Save All Page
procedure WB_SaveAllPage(WB: TWebbrowser; i: integer);
begin
WB.ExecWB(4,0);
end;

// Show All Links Page
procedure WB_ShowAllLinksPage(WB: TWebbrowser);
var
i: Integer;
begin 
for i := 0 to wb.OleObject.Document.links.Length - 1 do
LinksFrm.FavoriteList.Items.Add(wb.OleObject.Document.Links.Item(i));
end;

// Undo last change
procedure WB_UndoLastChange(WB: TWebbrowser);
begin
WB.ExecWB(OLECMDID_UNDO, 1);
end;

// Scale page 50%
procedure WB_ScalePage_50(WB: TWebbrowser);
begin
WB.OleObject.Document.Body.Style.Zoom := 0.5;
end;

// Scale page 100%
procedure WB_ScalePage_100(WB: TWebbrowser);
begin
WB.OleObject.Document.Body.Style.Zoom := 1.0;
end;

// Scale page 150%
procedure WB_ScalePage_150(WB: TWebbrowser);
begin
WB.OleObject.Document.Body.Style.Zoom := 1.8;
end;

// Scale page 200%
procedure WB_ScalePage_200(WB: TWebbrowser);
begin
WB.OleObject.Document.Body.Style.Zoom := 2.0;
end;

// Add to Favorites
procedure WB_AddtoFavorites(WB: TWebbrowser);
const 
NotAllowed: set of Char = ['"'] + ['/'] + ['\'] + ['?'] + [':'] + ['*'] +
['<'] + ['>'] + ['|'];
function Load(Path, Key: string): string; 
var
Reg: TRegistry;
begin 
Reg := TRegistry.Create;
try
Reg.RootKey := HKEY_CURRENT_USER;
Reg.OpenKey(Path, False);
try
Result := Reg.ReadString(Key);
except
Result := '';
end;
Reg.CloseKey;
finally
Reg.Free;
end;
end; 

function WinDir: string; 
var 
WinDir: PChar;
begin 
WinDir := StrAlloc(MAX_PATH);
GetWindowsDirectory(WinDir, MAX_PATH);
Result := string(WinDir);
if Result[Length(Result)] <> '\' then
Result := Result + '\';
StrDispose(WinDir);
end; 

function GetSysDir: string; 
var 
dir: array [0..MAX_PATH] of Char;
begin 
GetSystemDirectory(dir, MAX_PATH);
Result := StrPas(dir);
end;
var 
url: TStringList;
fav: string;
title, b: string;
i: Integer;
c: Char;
begin 
fav := Load('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders','Favorites');
url := TStringList.Create;
try
url.Add('[InternetShortcut]');
url.Add('URL=' + WB.LocationURL);
url.Add('WorkingDirectory=' + WinDir());
url.Add('IconIndex=0');
url.Add('ShowCommand=7');
url.Add('IconFile=' + GetSysDir() + '\url.dll');
title := WB.LocationName;
b := '';
for i := 1 to Length(title) do
begin
c := title[i];
if not (c in NotAllowed) then
begin
b := b + WB.LocationName[i];
end;
end;
url.SaveToFile(fav + '\' + b + '.url');
finally
url.Free;
end;
end;

// Quick Print
procedure WB_QuickPrint(WB: TWebbrowser);
var
vaIn, vaOut: OleVariant;
begin
WB.ControlInterface.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER,
vaIn, vaOut);
end;

end.

