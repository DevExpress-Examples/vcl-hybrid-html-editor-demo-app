unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView, cxBarEditItem,
  dxUIAClasses, dxSkinsCore, dxSkinWXI, dxCore, dxRibbonCustomizationForm,
  cxTextEdit, cxContainer, cxEdit, dxSkinsForm, dxStatusBar, dxRibbonStatusBar,
  cxLabel, dxGallery, dxGalleryControl, dxRibbonBackstageViewGalleryControl,
  System.ImageList, Vcl.ImgList, cxImageList, dxSkinOffice2019Colorful,
  dxSkinsDefaultPainters, dxSkinChooserGallery, System.Actions, Vcl.ActnList,
  dxHtmlEditor, dxLayoutContainer, dxLayoutControl, dxLayoutControlAdapters,
  Vcl.ExtCtrls, dxBarExtItems, cxFontNameComboBox, cxDropDownEdit,
  dxLayoutLookAndFeels, dxSkinBasic, dxSkinOffice2019Black,
  dxSkinOffice2019DarkGray, dxSkinOffice2019White, dxSkinTheBezier, Vcl.AppEvnts;

type
  TfmHtmlEditor = class(TdxRibbonForm)
    dxBarManager: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon: TdxRibbon;
    rtHome: TdxRibbonTab;
    dxSkinController: TdxSkinController;
    dxBarManager1Bar2: TdxBar;
    rtAppearance: TdxRibbonTab;
    rtSelection: TdxRibbonTab;
    cxLargeImages: TcxImageList;
    cxSmallImages: TcxImageList;
    dxSkinSelector: TdxRibbonSkinSelector;
    dxbAppearance: TdxBar;
    dxbEditing: TdxBar;
    bbUndo: TdxBarLargeButton;
    bbRedo: TdxBarLargeButton;
    alActions: TActionList;
    acNew: TAction;
    acExit: TAction;
    acOpen: TAction;
    acSave: TAction;
    acSaveAs: TAction;
    acCut: TAction;
    acCopy: TAction;
    acPaste: TAction;
    acClear: TAction;
    acSelectAll: TAction;
    acPrint: TAction;
    acFont: TAction;
    acBold: TAction;
    acItalic: TAction;
    acUnderline: TAction;
    acAlignLeft: TAction;
    acAlignRight: TAction;
    acAlignCenter: TAction;
    acBulletList: TAction;
    acFontColor: TAction;
    acFind: TAction;
    acReplace: TAction;
    acUndo: TAction;
    acRedo: TAction;
    dxbFont: TdxBar;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    Panel1: TPanel;
    liMain: TdxLayoutItem;
    bbItalic: TdxBarButton;
    bbUnderline: TdxBarButton;
    dxbParagraph: TdxBar;
    bbAlignLeft: TdxBarButton;
    bbAlignCenter: TdxBarButton;
    bbAlignRight: TdxBarButton;
    dxbTable: TdxBar;
    acInsertTable: TAction;
    dxbHyperlink: TdxBar;
    bbHyperlink: TdxBarLargeButton;
    acEditLink: TAction;
    bbInsertRowAbove: TdxBarLargeButton;
    acInsertRowAbove: TAction;
    acInsertRowBelow: TAction;
    bbInsertRowBelow: TdxBarLargeButton;
    bbInsertTable: TdxBarLargeButton;
    bbDeleteTable: TdxBarLargeButton;
    acDeleteTable: TAction;
    bbInsertRow: TdxBarSubItem;
    bbInsertColumn: TdxBarSubItem;
    acInsertColumnLeft: TAction;
    acInsertColumnRight: TAction;
    bbInsertColumnLeft: TdxBarButton;
    bbInsertColumnRight: TdxBarButton;
    bbDeleteColumn: TdxBarButton;
    acDeleteColumn: TAction;
    acDeleteRow: TAction;
    bbDeleteRow: TdxBarButton;
    bbDelete: TdxBarSubItem;
    acStrike: TAction;
    bbStrikeout: TdxBarButton;
    beFontName: TcxBarEditItem;
    beFontSize: TcxBarEditItem;
    acOrderedList: TAction;
    bbIncreaseIndent: TdxBarLargeButton;
    bbDecreaseIndent: TdxBarLargeButton;
    acIncreaseIndent: TAction;
    acDecreaseIndent: TAction;
    bbLineHeight: TdxBarSubItem;
    acLineHeight10: TAction;
    acLineHeight15: TAction;
    acLineHeight20: TAction;
    bbLineHeight10: TdxBarButton;
    bbLineHeight15: TdxBarButton;
    bbLineHeight20: TdxBarButton;
    bbLineHeightDefault: TdxBarButton;
    acLineHeightDefault: TAction;
    bbNormalText: TdxBarButton;
    dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList;
    dxLayoutSkinLookAndFeel: TdxLayoutSkinLookAndFeel;
    bbHeading: TcxBarEditItem;
    acEditImage: TAction;
    bbEditImage: TdxBarLargeButton;
    bbBold: TdxBarButton;
    bbBullets: TdxBarButton;
    bbOrdered: TdxBarButton;
    ApplicationEvents: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure acUndoExecute(Sender: TObject);
    procedure acRedoExecute(Sender: TObject);
    procedure acBoldExecute(Sender: TObject);
    procedure acItalicExecute(Sender: TObject);
    procedure acUnderlineExecute(Sender: TObject);
    procedure acStrikeExecute(Sender: TObject);
    procedure acAlignLeftExecute(Sender: TObject);
    procedure acAlignRightExecute(Sender: TObject);
    procedure acAlignCenterExecute(Sender: TObject);
    procedure acInsertTableExecute(Sender: TObject);
    procedure acEditImageExecute(Sender: TObject);
    procedure acEditLinkExecute(Sender: TObject);
    procedure acTableOperationExecute(Sender: TObject);
    procedure acHeadingExecute(Sender: TObject);
    procedure beFontNameChange(Sender: TObject);
    procedure beFontSizeChange(Sender: TObject);
    procedure acBulletListExecute(Sender: TObject);
    procedure acOrderedListExecute(Sender: TObject);
    procedure acIncreaseIndentExecute(Sender: TObject);
    procedure acDecreaseIndentExecute(Sender: TObject);
    procedure acLineHeightExecute(Sender: TObject);
    procedure dxSkinSelectorPaletteChanged(Sender: TObject;
      const AArgs: TdxRibbonSkinSelectorPaletteChangedArgs);
    procedure bbHeadingChange(Sender: TObject);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
  private
    FHtmlEditor: TdxHtmlEditor;
    FNeedUpdate: Boolean;
    FUpdatingControls: Integer;
    procedure UpdateControls;
    procedure DoEditorChange(Sender: TObject);
  protected
    property HtmlEditor: TdxHtmlEditor read FHtmlEditor;
  public
    { Public declarations }
  end;

var
  fmHtmlEditor: TfmHtmlEditor;

implementation

{$R *.dfm}

uses
  dxHyperlinkDialog, dxInsertTableDialog, dxImageDialog;

const
  cImageEmbedded =
    '<img src="data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8yIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsa' +
    'W5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgNjQgNjQiIHN0eW' +
    'xlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDY0IDY0OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+CjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+Cgkuc3Qwe2ZpbGw6I0ExQURCODt' +
    '9Cjwvc3R5bGU+CjxyZWN0IHg9IjEyIiB5PSIxMCIgY2xhc3M9InN0MCIgd2lkdGg9IjE4IiBoZWlnaHQ9IjQiLz4KPHJlY3QgeD0iMTIiIHk9IjE4IiBjbGFzcz0ic3QwIiB3aWR0' +
    'aD0iMjMiIGhlaWdodD0iNCIvPgo8cmVjdCB4PSIxMiIgeT0iMjYiIGNsYXNzPSJzdDAiIHdpZHRoPSIxOCIgaGVpZ2h0PSI0Ii8+CjxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik01Ni4yL' +
    'DE2TDUyLDIwLjJWNGMwLTEuMS0wLjktMi0yLTJINkM0LjksMiw0LDIuOSw0LDR2NTVjMCwxLjEsMC45LDIsMiwyaDQ0YzEuMSwwLDItMC45LDItMlYzNS44bDEyLTEyCglMNTYuMi' +
    'wxNnogTTQ5LDU3YzAsMC41LTAuNSwxLTEsMUg4Yy0wLjUsMC0xLTAuNS0xLTFWNmMwLTAuNSwwLjUtMSwxLTFoNDBjMC41LDAsMSwwLjUsMSwxdjE3LjJsLTIyLDIyVjUzaDcuOEw' +
    '0OSwzOC44VjU3eiBNMzQsNTAKCWwtNC00bDI2LTI2bDQsNEwzNCw1MHoiLz4KPC9zdmc+"/>';

  cEditorContent =
    '<h2>' +
    //cImageEmbedded +
    '    <img src="https://js.devexpress.com/React/Demos/WidgetsGallery/JSDemos/images/widgets/HtmlEditor.svg" width="64" height="64"/>' +
    '    Formatted Text Editor (HTML Editor)' +
    '</h2>' +
    '<br>' +
    '<p>DevExtreme JavaScript HTML Editor is a client-side WYSIWYG text editor that allows its users to format textual and visual content and store it as HTML or Markdown.</p>' +
    '<p>Supported features:</p>' +
    '<ul>' +
    '    <li>Inline formats:' +
    '        <ul>' +
    '            <li><strong>Bold</strong>, <em>italic</em>, <s>strikethrough</s> text formatting</li>' +
    '            <li>Font, size, color changes (HTML only)</li>' +
    '        </ul>' +
    '    </li>' +
    '    <li>Block formats:' +
    '        <ul>' +
    '            <li>Headers</li>' +
    '            <li>Text alignment</li>' +
    '            <li>Lists (ordered and unordered)</li>' +
    '            <li>Code blocks</li>' +
    '            <li>Quotes</li>' +
    '        </ul>' +
    '    </li>' +
    '    <li>Custom formats</li>' +
    '    <li>HTML and Markdown support</li>' +
    '    <li>Mail-merge placeholders (for example, %username%)</li>' +
    '    <li>Adaptive toolbar for working images, links, and color formats</li>' +
    '    <li>Image upload: drag-and-drop images onto the form, select files from the file system, or specify a URL.</li>' +
    '    <li>Copy-paste rich content (unsupported formats are removed)</li>' +
    '    <li>Tables support</li>' +
    '</ul>';

{ TfmHtmlEditor }

procedure TfmHtmlEditor.acAlignCenterExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Alignment := TAlignment.taCenter;
end;

procedure TfmHtmlEditor.acAlignLeftExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Alignment := TAlignment.taLeftJustify;
end;

procedure TfmHtmlEditor.acAlignRightExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Alignment := TAlignment.taRightJustify;
end;

procedure TfmHtmlEditor.acBoldExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Bold := acBold.Checked;
end;

procedure TfmHtmlEditor.acBulletListExecute(Sender: TObject);
begin
  if acBulletList.Checked then
    HtmlEditor.SelectedTextFormat.ListType := TdxHtmlEditorListType.Bullet
  else
    HtmlEditor.SelectedTextFormat.ListType := TdxHtmlEditorListType.None;
end;

procedure TfmHtmlEditor.acDecreaseIndentExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Indent := HtmlEditor.SelectedTextFormat.Indent - 1;
end;

procedure TfmHtmlEditor.acEditImageExecute(Sender: TObject);
var
  ADialog: TdxImageDialogForm;
  AImageInfo: TdxHtmlEditorImageInfo;
begin
  AImageInfo := nil;
  if HtmlEditor.SelectedTextFormat.IsImage then
    AImageInfo := HtmlEditor.GetImageInfo();

  if AImageInfo = nil then
    AImageInfo := TdxHtmlEditorImageInfo.Create;
  try
    ADialog := TdxImageDialogForm.Create(nil);
    try
      ADialog.Url := AImageInfo.Src;
      ADialog.Width := AImageInfo.Width;
      ADialog.Height := AImageInfo.Height;
      if ADialog.ShowModal = mrOk then
        HtmlEditor.InsertImageByUrl(ADialog.Url, ADialog.Width, ADialog.Height);
    finally
      ADialog.Free;
    end;
  finally
    AImageInfo.Free;
  end;
end;

procedure TfmHtmlEditor.acEditLinkExecute(Sender: TObject);
var
  ADialog: TdxHyperlinkDialogForm;
  AHyperLinkInfo: TdxHtmlEditorHyperlinkInfo;
  ARange: TdxHtmlEditorTextRange;
const
  cDefaultAddress = 'http://';
begin
  ADialog := TdxHyperlinkDialogForm.Create(nil);
  try
    AHyperLinkInfo := HtmlEditor.SelectedTextFormat.Hyperlink;
    if AHyperLinkInfo <> nil then
    begin
      ADialog.TextToDisplay := AHyperlinkInfo.Text;
      ADialog.Address := AHyperlinkInfo.Url;
      ARange := AHyperlinkInfo.Range;
    end
    else
    begin
      ADialog.TextToDisplay := HtmlEditor.SelectedText;
      ADialog.Address := cDefaultAddress;
      ARange.Reset;
    end;

    if ADialog.ShowModal = mrOk then
    begin
      AHyperLinkInfo := TdxHtmlEditorHyperlinkInfo.Create(ADialog.TextToDisplay, ADialog.Address);
      try
        HtmlEditor.InsertLink(AHyperLinkInfo, ARange);
      finally
        AHyperLinkInfo.Free;
      end;
    end;
  finally
    ADialog.Free;
  end;
end;

procedure TfmHtmlEditor.acHeadingExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.HeadingLevel := TdxHtmlEditorHeadingLevel(TAction(Sender).Tag);
end;

procedure TfmHtmlEditor.acTableOperationExecute(Sender: TObject);
begin
  HtmlEditor.ExecuteTableOperation(TdxHtmlTableOperation(TAction(Sender).Tag));
end;

procedure TfmHtmlEditor.acIncreaseIndentExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Indent := HtmlEditor.SelectedTextFormat.Indent + 1;
end;

procedure TfmHtmlEditor.acInsertTableExecute(Sender: TObject);
var
  ADialog: TdxInsertTableDialogForm;
begin
  ADialog := TdxInsertTableDialogForm.Create(nil);
  try
    ADialog.Columns := 3;
    ADialog.Rows := 2;
    if ADialog.ShowModal = mrOK then
      HtmlEditor.InsertTable(ADialog.Rows, ADialog.Columns);
  finally
    ADialog.Free;
  end;
end;

procedure TfmHtmlEditor.acItalicExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Italic := acItalic.Checked;
end;

procedure TfmHtmlEditor.acLineHeightExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.LineHeight := Integer(TAction(Sender).Tag) / 10;
end;

procedure TfmHtmlEditor.acOrderedListExecute(Sender: TObject);
begin
  if acOrderedList.Checked then
    HtmlEditor.SelectedTextFormat.ListType := TdxHtmlEditorListType.Ordered
  else
    HtmlEditor.SelectedTextFormat.ListType := TdxHtmlEditorListType.None;
end;

procedure TfmHtmlEditor.acRedoExecute(Sender: TObject);
begin
  HtmlEditor.Redo;
end;

procedure TfmHtmlEditor.acStrikeExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Strikeout := acStrike.Checked;
end;

procedure TfmHtmlEditor.acUnderlineExecute(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.Underline := acUnderline.Checked;
end;

procedure TfmHtmlEditor.acUndoExecute(Sender: TObject);
begin
  HtmlEditor.Undo;
end;

procedure TfmHtmlEditor.ApplicationEventsIdle(Sender: TObject;
  var Done: Boolean);
begin
  if FNeedUpdate then
  begin
    UpdateControls;
    FNeedUpdate := False;
  end;
end;

procedure TfmHtmlEditor.bbHeadingChange(Sender: TObject);
begin
  HtmlEditor.SelectedTextFormat.HeadingLevel := TdxHtmlEditorHeadingLevel(bbHeading.ItemIndex);
end;

procedure TfmHtmlEditor.beFontNameChange(Sender: TObject);
begin
  if FUpdatingControls = 0 then
    HtmlEditor.SelectedTextFormat.FontName := beFontName.EditValue;
end;

procedure TfmHtmlEditor.beFontSizeChange(Sender: TObject);
begin
  if FUpdatingControls = 0 then
    HtmlEditor.SelectedTextFormat.FontSize := Integer.Parse(beFontSize.EditValue);
end;

procedure TfmHtmlEditor.DoEditorChange(Sender: TObject);
begin
  FNeedUpdate := True;
end;

procedure TfmHtmlEditor.dxSkinSelectorPaletteChanged(Sender: TObject;
  const AArgs: TdxRibbonSkinSelectorPaletteChangedArgs);
begin
  if HtmlEditor = nil then
    Exit;

  HtmlEditor.DarkTheme := not Self.IsLightStyleColor(RootLookAndFeel.SkinPainter.DefaultContentColor);
end;

procedure TfmHtmlEditor.UpdateControls;
var
  ATextFormat: TdxHtmlEditorTextFormat;
  AIsTable: Boolean;
begin
  Inc(FUpdatingControls);
  try
    bbRedo.Enabled := HtmlEditor.CanRedo;
    bbUndo.Enabled := HtmlEditor.CanUndo;

    ATextFormat := HtmlEditor.SelectedTextFormat;

    acAlignLeft.Checked := ATextFormat.Alignment = TAlignment.taLeftJustify;
    acAlignRight.Checked := ATextFormat.Alignment = TAlignment.taRightJustify;
    acAlignCenter.Checked := ATextFormat.Alignment = TAlignment.taCenter;

    acBulletList.Checked := ATextFormat.ListType = TdxHtmlEditorListType.Bullet;
    acOrderedList.Checked := ATextFormat.ListType = TdxHtmlEditorListType.Ordered;

    acLineHeightDefault.Checked := ATextFormat.LineHeight = 0;
    acLineHeight10.Checked := ATextFormat.LineHeight = 1.0;
    acLineHeight15.Checked := ATextFormat.LineHeight = 1.5;
    acLineHeight20.Checked := ATextFormat.LineHeight = 2.0;

    bbHeading.ItemIndex := Integer(ATextFormat.HeadingLevel);

    acBold.Checked := ATextFormat.Bold;
    acItalic.Checked := ATextFormat.Italic;
    acUnderline.Checked := ATextFormat.Underline;

    AIsTable := ATextFormat.IsTable;
    acInsertTable.Enabled := not ATextFormat.IsTable;
    bbDelete.Enabled := AIsTable;
    bbInsertRow.Enabled := AIsTable;
    bbInsertColumn.Enabled := AIsTable;

    acInsertRowAbove.Enabled := AIsTable;
    acInsertRowBelow.Enabled := AIsTable;
    acInsertColumnLeft.Enabled := AIsTable;
    acInsertColumnRight.Enabled := AIsTable;
    acDeleteColumn.Enabled := AIsTable;
    acDeleteRow.Enabled := AIsTable;
    acDeleteTable.Enabled := AIsTable;

    beFontName.EditValue := ATextFormat.FontName;
    if ATextFormat.FontSize = 0 then
      beFontSize.EditValue := ''
    else
      beFontSize.EditValue := ATextFormat.FontSize;
  finally
    Dec(FUpdatingControls);
  end;
end;

procedure TfmHtmlEditor.FormCreate(Sender: TObject);
begin
  DisableAero := True;

  FHtmlEditor := TdxHtmlEditor.Create(Self);
  FHtmlEditor.Align := alClient;
  FHtmlEditor.Parent := Panel1;

  FHtmlEditor.OnChange := DoEditorChange;
  FHtmlEditor.Initialize;

  FHtmlEditor.HtmlText := cEditorContent;
end;

end.
