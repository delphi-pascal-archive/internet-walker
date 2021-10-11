unit AddHTML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPButton, StdCtrls, ComCtrls, XPCheckBox, AppEvnts, ToolWin,
  FreeButton, XPPanel, Menus, StdActns, ActnList;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

 type
   TAddHTMLFrm = class(TForm)
    OptionsMenu: TPopupMenu;
    CleanItem: TMenuItem;
    FullScreenItem: TMenuItem;
    OpenItem: TMenuItem;
    SaveItem: TMenuItem;
    CloseItem: TMenuItem;
    CopyItem: TMenuItem;
    CutItem: TMenuItem;
    DelItem: TMenuItem;
    PasteItem: TMenuItem;
    UndoItem: TMenuItem;
    sp1: TMenuItem;
    SelectAllItem: TMenuItem;
    EditItem: TMenuItem;
    ActionList: TActionList;
    EditCut: TEditCut;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    EditSelectAll: TEditSelectAll;
    EditUndo: TEditUndo;
    EditDelete: TEditDelete;
    sp2: TMenuItem;
    sp3: TMenuItem;
    sp5: TMenuItem;
    sp4: TMenuItem;
    PageControl: TPageControl;
    HTMLEditorTab: TTabSheet;
    HTMLPageTab: TTabSheet;
    HTMLEditor: TRichEdit;
    fr1: TXPPanel;
    Replace: TFreeButton;
    Add: TFreeButton;
    Options: TFreeButton;
    HTMLPage: TRichEdit;
    fr2: TXPPanel;
    AddToPage: TFreeButton;
    StatusBar: TStatusBar;

    procedure ReplaceClick(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure CleanItemClick(Sender: TObject);
    procedure FullScreenItemClick(Sender: TObject);
    procedure OpenItemClick(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
    procedure CloseItemClick(Sender: TObject);
    procedure HTMLEditorKeyPress(Sender: TObject; var Key: Char);
    procedure AddToPageClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);

  private

  public

    procedure HTMLSyntax(RichEdit: TRichEdit; TextCol,
    TagCol, DopCol: TColor);

    procedure WMGetMinMaxInfo(var msg: TWMGetMinMaxInfo);
    message WM_GETMINMAXINFO;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  end;

var
  AddHTMLFrm: TAddHTMLFrm;

implementation

{$R *.dfm}  uses  MSHTML, ActiveX, SHDocVw, NP, OP;

const
Rect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
FullScreen: Boolean = False;

procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
sl: TStringList;
ms: TMemoryStream;
begin
WebBrowser.Navigate('about:blank');
while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
Application.ProcessMessages;
if Assigned(WebBrowser.Document) then
begin
sl := TStringList.Create;
try
ms := TMemoryStream.Create;
try
sl.Text := HTMLCode;
sl.SaveToStream(ms);
ms.Seek(0, 0);
(WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
finally
ms.Free;
end;
finally
sl.Free;
end;
end;
end;

procedure TAddHTMLFrm.ReplaceClick(Sender: TObject);
begin
try
WB_LoadHTML(MainFrm.GetCurrentWB, HTMLEditor.Text);
except
end;
end;

procedure TAddHTMLFrm.AddClick(Sender: TObject);
var
WebDoc: HTMLDocument;
WebBody: HTMLBody;
begin
try
WebDoc := MainFrm.WebBrowser.Document as HTMLDocument;
WebBody := WebDoc.body as HTMLBody;
WebBody.insertAdjacentHTML('BeforeEnd', HTMLEditor.Text);
except
end;
end;

procedure TAddHTMLFrm.OptionsClick(Sender: TObject);
var
Pt:TPoint;
begin
Pt.x := Options.Width;
Pt.y := 0;
Pt := Options.ClientToScreen(Pt);
OptionsMenu.Popup(Pt.x, Pt.y)
end;

procedure TAddHTMLFrm.FormShow(Sender: TObject);
begin
PageControl.ActivePageIndex := 0;
if SetFrm.ch18.Checked then
begin
SetWindowLong(AddHTMLFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(AddHTMLFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;
HTMLEditor.Lines.BeginUpdate;
HTMLSyntax(HTMLEditor, clRed, clBlack, clBlue);
HTMLEditor.Lines.EndUpdate;
end;

procedure TAddHTMLFrm.WMGetMinMaxInfo(var msg: TWMGetMinMaxInfo);
begin
inherited;
with msg.MinMaxInfo^.ptMaxTrackSize do begin
X := GetDeviceCaps( Canvas.handle, HORZRES ) +
(Width - ClientWidth);
Y := GetDeviceCaps( Canvas.handle, VERTRES ) +
(Height - ClientHeight );
end;
end;

procedure TAddHTMLFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if not FullScreenItem.Checked then
begin
if Key = vk_Escape then
Close;
end;
if FullScreenItem.Checked then
begin
if Key = vk_Escape then
FullScreenItem.Click;
end;
end;

procedure TAddHTMLFrm.CleanItemClick(Sender: TObject);
begin
HTMLEditor.Lines.Clear;
end;

procedure TAddHTMLFrm.FullScreenItemClick(Sender: TObject);
begin
FullScreen := not FullScreen;
if FullScreen then begin
FullScreenItem.Checked := True;
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
end;
end;

procedure TAddHTMLFrm.OpenItemClick(Sender: TObject);
var
TextString: String;
begin
try
if OpenSaveFileDialog(Handle, '*.html',
'Веб-страницы (*.htm;*.html)|*.htm;*.html|Текстовые документы (*.txt)|*.txt|Все файлы (*.*)|*.*', ParamStr(1),
'Открыть', TextString, True) then
begin
HTMLEditor.Clear;
HTMLEditor.Lines.LoadFromFile(TextString);
end;
except
end;
end;

procedure TAddHTMLFrm.SaveItemClick(Sender: TObject);
var
TextString: String;
begin
try
if OpenSaveFileDialog(AddHTMLFrm.Handle, '*.html',
'Веб-страницы (*.htm;*.html)|*.htm;*.html|Текстовые документы (*.txt)|*.txt|',
ParamStr(1), 'Сохранить', TextString, False) then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if FileExists(TextString) then
if Application.MessageBox(PChar('Файл "' + TextString +
'" существует.' + #13 + 'Заменить его?'), 'Подтвердите замену',
MB_ICONQUESTION + mb_YesNo) <> idYes then
else
HTMLEditor.Lines.SaveToFile(TextString);
if not FileExists(TextString) then
HTMLEditor.Lines.SaveToFile(TextString);
end;
except
end;
end;

procedure TAddHTMLFrm.CloseItemClick(Sender: TObject);
begin
AddHTMLFrm.Close;
end;

procedure TAddHTMLFrm.HTMLEditorKeyPress(Sender: TObject; var Key: Char);
begin
try
HTMLSyntax(HTMLEditor, clRed, clBlack, clBlue);
except
end;
end;

procedure TAddHTMLFrm.AddToPageClick(Sender: TObject);
var
TextString: String;
begin
try
if OpenSaveFileDialog(AddHTMLFrm.Handle, '*.html',
'Веб-страницы (*.htm;*.html)|*.htm;*.html|Текстовые документы (*.txt)|*.txt|',
ParamStr(1), 'Сохранить', TextString, False) then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if FileExists(TextString) then
if Application.MessageBox(PChar('Файл "' + TextString +
'" существует.' + #13 + 'Заменить его?'), 'Подтвердите замену',
MB_ICONQUESTION + mb_YesNo) <> idYes then
else
HTMLPage.Lines.SaveToFile(TextString);
if not FileExists(TextString) then
HTMLPage.Lines.SaveToFile(TextString);
end;
except
end;
end;

procedure TAddHTMLFrm.HTMLSyntax(RichEdit: TRichEdit; TextCol, TagCol,
DopCol: TColor);
var
i, iDop: Integer;
s: string;
Col: TColor;
isTag, isDop: Boolean;
begin
iDop := 0;
isDop := False;
isTag := False;
Col := TextCol;
RichEdit.SetFocus;
for i := 0 to Length(RichEdit.Text) do
begin
RichEdit.SelStart := i;
RichEdit.SelLength := 1;
s := RichEdit.SelText;
if (s = '<') or (s = '{') then isTag := True;
if isTag then
if (s = '"') then
if not isDop then
begin
iDop  := 1;
isDop := True;
end else
isDop := False;
if isTag then
if isDop then
begin
if iDop <> 1 then Col := DopCol;
end else
Col := TagCol
else
Col := TextCol;
RichEdit.SelAttributes.Color := Col;
iDop := 0;
if (s = '>') or (s = '}') then isTag := False;
end;
RichEdit.SelLength := 0;
end;

procedure TAddHTMLFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if SetFrm.ch19.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TAddHTMLFrm.WMMoving(var msg: TWMMoving);
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

procedure TAddHTMLFrm.FormDestroy(Sender: TObject);
begin
PageControl.Free;
OptionsMenu.Free;
HTMLEditor.Free;
ActionList.Free;
StatusBar.Free;
AddToPage.Free;
StatusBar.Free;
HTMLPage.Free;
Options.Free;
Replace.Free;
Add.Free;
fr1.Free;
fr2.Free;
end;

end.
