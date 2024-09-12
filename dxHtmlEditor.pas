unit dxHtmlEditor;

interface

uses
  System.Classes,
  Vcl.Controls, Vcl.Edge,
  cxControls, cxContainer, dxEdgeBrowserAdapter;

type
  {$SCOPEDENUMS ON}
  TdxHtmlEditorListType = (
    None,
    Ordered,
    Bullet
  );

  TdxHtmlEditorHeadingLevel = (
    NormalText = 0,
    Heading1,
    Heading2,
    Heading3,
    Heading4,
    Heading5,
    Heading6
  );

  TdxHtmlTableOperation = (
    InsertRowAbove = 0,
    InsertRowBelow,
    InsertColumnLeft,
    InsertColumnRight,
    DeleteColumn,
    DeleteRow,
    DeleteTable
  );
  {$SCOPEDENUMS OFF}

  TdxHtmlEditorHistory = record
    CanRedo: Boolean;
    CanUndo: Boolean;
  end;

  TdxHtmlEditorTextRange = record
    Index: Integer;
    Length: Integer;
    function IsEmpty: Boolean;
    procedure Reset;
  end;

  TdxHtmlEditorHyperlinkInfo = class(TPersistent)
  private
    FText: string;
    FUrl: string;
    FRange: TdxHtmlEditorTextRange;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(const AText: string = ''; const AUrl: string = '');

    property Text: string read FText;
    property Url: string read FUrl;
    property Range: TdxHtmlEditorTextRange read FRange;
  end;

  TdxHtmlEditorImageInfo = class(TPersistent)
  private
    FSrc: string;
    FWidth: Integer;
    FHeight: Integer;
  public
    property Src: string read FSrc;
    property Width: Integer read FWidth;
    property Height: Integer read FHeight;
  end;

  TdxHtmlEditorTextFormat = class(TPersistent)
  private
  type
    {$SCOPEDENUMS ON}
    TFormatChange = (
      Alignment,
      HeadingLevel,
      Bold,
      Italic,
      Underline,
      Strikeout,
      FontName,
      FontSize,
      Indent,
      LineHeight,
      ListType
    );
    {$SCOPEDENUMS OFF}
  private
    FChanges: set of TFormatChange;
    FOnFormatChanged: TNotifyEvent;

    FAlignment: TAlignment;
    FHeadingLevel: TdxHtmlEditorHeadingLevel;
    FBold: Boolean;
    FItalic: Boolean;
    FUnderline: Boolean;
    FStrikeout: Boolean;
    FFontName: string;
    FFontSize: Integer;
    FIndent: Integer;
    FLineHeight: Single;
    FListType: TdxHtmlEditorListType;
    FIsImage: Boolean;
    FIsTable: Boolean;
    FHyperlink: TdxHtmlEditorHyperlinkInfo;
    procedure SetAlignment(AValue: TAlignment);
    procedure SetBold(AValue: Boolean);
    procedure SetFontName(AValue: string);
    procedure SetFontSize(AValue: Integer);
    procedure SetIndent(AValue: Integer);
    procedure SetItalic(AValue: Boolean);
    procedure SetHeadingLevel(AValue: TdxHtmlEditorHeadingLevel);
    procedure SetLineHeight(AValue: Single);
    procedure SetListType(AValue: TdxHtmlEditorListType);
    procedure SetStrikeout(AValue: Boolean);
    procedure SetUnderline(AValue: Boolean);
    procedure DoFormatChanged(AChange :TFormatChange);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure ClearChanges;
  public
    constructor Create;
    destructor Destroy; override;

    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Indent: Integer read FIndent write SetIndent;
    property LineHeight: Single read FLineHeight write SetLineHeight;

    property HeadingLevel: TdxHtmlEditorHeadingLevel read FHeadingLevel write SetHeadingLevel;

    property Bold: Boolean read FBold write SetBold;
    property Italic: Boolean read FItalic write SetItalic;
    property Underline: Boolean read FUnderline write SetUnderline;
    property Strikeout: Boolean read FStrikeout write SetStrikeout;

    property FontName: string read FFontName write SetFontName;
    property FontSize: Integer read FFontSize write SetFontSize;

    property ListType: TdxHtmlEditorListType read FListType write SetListType;

    property IsTable: Boolean read FIsTable;
    property IsImage: Boolean read FIsImage;

    property Hyperlink: TdxHtmlEditorHyperlinkInfo read FHyperlink;

    property OnFormatChanged: TNotifyEvent read FOnFormatChanged write FOnFormatChanged;
  end;

  TdxHtmlEditor = class(TWinControl)
  private
    FEdgeBrowser: TEdgeBrowser;
    FBrowserAdapter: TdxEdgeBrowserAdapter;
    FLoaded: Boolean;

    FHistory: TdxHtmlEditorHistory;
    FReadOnly: Boolean;
    FSelection: TdxHtmlEditorTextRange;
    FSelectedText: string;
    FTextFormat: TdxHtmlEditorTextFormat;

    FOnChange: TNotifyEvent;
    FOnLoaded: TNotifyEvent;

    function GetCanRedo: Boolean;
    function GetCanUndo: Boolean;
    function GetDarkTheme: Boolean;
    function GetHtmlText: string;
    procedure SetDarkTheme(AValue: Boolean);
    procedure SetHtmlText(const AValue: string);
    procedure SetReadOnly(const AValue: Boolean);
    procedure OnTextFormatChanged(Sender: TObject);
  protected
    procedure DoLoaded(Sender: TObject);
    procedure DoSelectionChanged(const ASelection: TdxHtmlEditorTextRange; ATextFormat: TdxHtmlEditorTextFormat;
      const AHistory: TdxHtmlEditorHistory; const ASelectedText: string);
    procedure DoTextChanged(const AHistory: TdxHtmlEditorHistory; const ASelection: TdxHtmlEditorTextRange);
    procedure DoChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Initialize;
    procedure Finalize;

    procedure Undo;
    procedure Redo;

    procedure InsertTable(ARowCount: Integer; AColumnCount: Integer);
    procedure ExecuteTableOperation(AOperation: TdxHtmlTableOperation);

    procedure InsertLink(ALinkInfo: TdxHtmlEditorHyperlinkInfo); overload;
    procedure InsertLink(ALinkInfo: TdxHtmlEditorHyperlinkInfo; ARange: TdxHtmlEditorTextRange); overload;

    procedure InsertImageByUrl(const AUrl: string; AWidth: Integer; AHeight: Integer); overload;
    procedure InsertImageByUrl(const AUrl: string; AWidth: Integer; AHeight: Integer; ARange: TdxHtmlEditorTextRange); overload;
    function GetImageInfo: TdxHtmlEditorImageInfo;

    property CanUndo: Boolean read GetCanUndo;
    property CanRedo: Boolean read GetCanRedo;
    property HtmlText: string read GetHtmlText write SetHtmlText;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property Selection: TdxHtmlEditorTextRange read FSelection;
    property SelectedText: string read FSelectedText;
    property SelectedTextFormat: TdxHtmlEditorTextFormat read FTextFormat;
    property DarkTheme: Boolean read GetDarkTheme write SetDarkTheme;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnLoaded: TNotifyEvent read FOnLoaded write FOnLoaded;
  end;

implementation

{$R HtmlEditorAsset.res}

uses
  System.SysUtils, System.TypInfo, System.JSON, System.Generics.Collections,
  System.NetEncoding, System.Zip,
  Winapi.Windows, Winapi.WebView2;

type
  TJSBooleanHelper = record helper for Boolean
    procedure Parse(AValue: TJSONValue; ADefault: Boolean = False);
    function ToJsString: string;
  end;

  TJSIntegerHelper = record helper for Integer
    procedure Parse(AValue: TJSONValue; ADefault: Integer = 0);
    function ToString: string;
  end;

  TJSSingleHelper = record helper for Single
    procedure Parse(AValue: TJSONValue; ADefault: Single = 0);
    function ToString: string;
  end;

  THtmlEditorAlignmentHelper = record helper for TAlignment
  strict private
  const
    cEnumValues : array  [0..2] of string = ('left', 'right', 'center');
  public
    procedure Parse(AValue: TJSONValue; ADefault: TAlignment = taLeftJustify);
    function ToJsString: string;
  end;

  TdxHtmlEditorListTypeHelper = record helper for TdxHtmlEditorListType
  strict private
  const
    cEnumValues : array  [0..2] of string = ('none', 'ordered', 'bullet');
  public
    procedure Parse(AValue: TJSONValue; ADefault: TdxHtmlEditorListType = TdxHtmlEditorListType.None);
    function ToJsString: string;
  end;

  TdxHtmlEditorHeadingHelper = record helper for TdxHtmlEditorHeadingLevel
    procedure Parse(AValue: TJSONValue; ADefault: TdxHtmlEditorHeadingLevel = TdxHtmlEditorHeadingLevel.NormalText);
    function ToJsString: string;
  end;

  TdxHtmlEditorHistoryHelper = record helper for TdxHtmlEditorHistory
  strict private const
    cCanRedo = 'canRedo';
    cCanUndo = 'canUndo';
  public
    procedure Parse(AValue: TJSONValue);
  end;

  TdxHtmlEditorTextRangeHelper = record helper for TdxHtmlEditorTextRange
  strict private const
    cIndex = 'index';
    cLength = 'length';
  public
    procedure Parse(AValue: TJSONValue);
    function ToJson: string;
  end;

  TdxHtmlEditorTextFormatHelper = class helper for TdxHtmlEditorTextFormat
  strict private const
    cAlign = 'align';
    cBold = 'bold';
    cFont = 'font';
    cHeader = 'header';
    cImage = 'image';
    cImageSrc = 'imageSrc';
    cIndent = 'indent';
    cIsTable = 'isTable';
    cItalic = 'italic';
    cLineHeight = 'lineheight';
    cLink = 'link';
    cLinkRange = 'linkRange';
    cLinkText = 'linkText';
    cList = 'list';
    cPt = 'pt';
    cSize = 'size';
    cStrike = 'strike';
    cUnderline = 'underline';
  public
    procedure Parse(AValue: TJSONValue);
    function ToJson: string;
  end;

  TdxHtmlEditorHyperlinkHelper = class helper for TdxHtmlEditorHyperlinkInfo
  strict private const
    cText = 'text';
    cUrl = 'url';
  public
    function ToJson: string;
  end;

  TdxHtmlEditorImageHelper = class helper for TdxHtmlEditorImageInfo
  strict private const
    cSrc = 'src';
    cWidth = 'width';
    cHeight = 'height';
  public
    procedure Parse(AValue: TJSONValue);
  end;

  TSelectionChangedEvent = procedure(const ASelection: TdxHtmlEditorTextRange; ATextFormat: TdxHtmlEditorTextFormat;
    const AHistory: TdxHtmlEditorHistory; const ASelectedText: string) of object;
  TTextChangedEvent = procedure(const AHistory: TdxHtmlEditorHistory; const ASelection: TdxHtmlEditorTextRange) of object;

  TdxHtmlEditorBrowserAdapter = class(TdxEdgeBrowserAdapter)
  private const
    RootURI = 'https://htmleditor/index.html';
    RootURIFilter = 'https://htmleditor/*';
    ThemeNameReplace = '$ThemeName$';
    // Events
    cOnLoaded = 'OnLoaded';
    cOnSelectionChanged = 'OnSelectionChanged';
    cOnTextChanged = 'OnTextChanged';
    // Methods
    cInsertTable = 'insertTable';
    cInsertImage = 'insertImage';
    cInsertImageByUrl = 'insertImageByUrl';
    cGetHtml = 'getHtml';
    cGetImageInfo = 'getImageInfo';
    cRedo = 'redo';
    cReloadCSS = 'reloadCss';
    cSetFormat = 'setFormat';
    cSetHtml = 'setHtml';
    cSetHyperlink = 'setHyperlink';
    cSetReadOnly = 'setReadOnly';
    cUndo = 'undo';
  private
    FOnLoaded: TNotifyEvent;
    FOnSelectionChanged: TSelectionChangedEvent;
    FOnTextChanged: TTextChangedEvent;

    FHistory: TdxHtmlEditorHistory;
    FSelection: TdxHtmlEditorTextRange;
    FTextFormat: TdxHtmlEditorTextFormat;

    FLoaded: Boolean;
    FSavedHtml: string;
    FDarkTheme: Boolean;

    procedure SetDarkTheme(const AValue: Boolean);

    class function GetHeaders(const AAsset: string; out AAllowSetTheme: Boolean): string; static;
    class function GetJSStyleIdent(const AIdent: string): string;
    class function GetStringArg(const AValue: string): string;

    function GetBrowserScript(const jsMethod: string; const AArgs: array of string): string;
    function Execute(const jsMethod: string): string; overload;
    function Execute(const jsMethod: string; const AArgs: array of string): string; overload;
    procedure ExecuteAsync(const jsMethod: string); overload;
    procedure ExecuteAsync(const jsMethod: string; const AArgs: array of string); overload;
  protected
    procedure SetupBrowser; override;

    function GetMessage(AJson: TJSONValue; out AMessageName: string): Boolean; override;
    function GetMessageParams(AJson: TJSONValue; out AParams: TJSInteropArgs): Boolean; override;

    procedure Refresh; override;
    function GetWebResource(const AUri: string; out AHeaders: string; out AContent: TStream): Boolean; override;

    procedure DoLoaded(AArgs: TJSInteropArgs);
    procedure DoSelectionChanged(AArgs: TJSInteropArgs);
    procedure DoTextChanged(AArgs: TJSInteropArgs);
  public
    constructor Create(AOwner: TComponent; ABrowser: TEdgeBrowser);
    destructor Destroy; override;

    property DarkTheme: Boolean read FDarkTheme write SetDarkTheme;
    // API
    procedure Undo;
    procedure Redo;
    function GetHtmlText: string;
    procedure SetHtmlText(const AHtmlString: string);
    procedure SetFormat(AFormat: TdxHtmlEditorTextFormat);
    procedure SetReadOnly(AValue: Boolean);
    procedure InsertLink(ALinkInfo: TdxHtmlEditorHyperlinkInfo; const ARange: TdxHtmlEditorTextRange);
    procedure InsertTable(ARowCount, AColumnCount: Integer);
    procedure ExecuteTableOperation(AOperation: TdxHtmlTableOperation);
    procedure InsertImage(const AImageString: string; const AImageType: string; AWidth: Integer; AHeight: Integer; const ARange: TdxHtmlEditorTextRange);
    procedure InsertImageByUrl(const AUrl: string; AWidth: Integer; AHeight: Integer; const ARange: TdxHtmlEditorTextRange);
    function GetImageInfo: TdxHtmlEditorImageInfo;

    property OnLoaded: TNotifyEvent read FOnLoaded write FOnLoaded;
    property OnSelectionChanged: TSelectionChangedEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnTextChanged: TTextChangedEvent read FOnTextChanged write FOnTextChanged;
  end;

{ TJSBooleanHelper }

procedure TJSBooleanHelper.Parse(AValue: TJSONValue; ADefault: Boolean = False);
var
  ABoolean: TJSONBool;
begin
  Self := ADefault;
  if (AValue <> nil) and AValue.TryGetValue<TJSONBool>(ABoolean) then
    Self := ABoolean.AsBoolean;
end;

function TJSBooleanHelper.ToJsString: string;
begin
  Result := BoolToStr(Self, true).ToLower;
end;

{ TJSIntegerHelper }

procedure TJSIntegerHelper.Parse(AValue: TJSONValue; ADefault: Integer);
var
  AInteger: string;
begin
  Self := ADefault;
  if (AValue <> nil) and AValue.TryGetValue<string>(AInteger) and (AInteger <> '') then
    Self := StrToInt(AInteger);
end;

function TJSIntegerHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

{ TJSSingleHelper }

procedure TJSSingleHelper.Parse(AValue: TJSONValue; ADefault: Single);
var
  ASingle: string;
begin
  Self := ADefault;
  if (AValue <> nil) and AValue.TryGetValue<string>(ASingle) and (ASingle <> '') then
    Self := JsonToFloat(ASingle);
end;

function TJSSingleHelper.ToString: string;
begin
  Result := FloatToJson(Self);
end;

{ THtmlEditorAlignmentHelper }

procedure THtmlEditorAlignmentHelper.Parse(AValue: TJSONValue; ADefault: TAlignment = taLeftJustify);
var
  AAlignment: string;
  I: Integer;
begin
  Self := ADefault;
  if (AValue <> nil) and AValue.TryGetValue<string>(AAlignment) then
    for I := Integer(TAlignment.taLeftJustify) to Integer(TAlignment.taCenter) do
      if AAlignment = cEnumValues[I] then
      begin
        Self := TAlignment(I);
        Break;
      end;
end;

function THtmlEditorAlignmentHelper.ToJsString: string;
begin
  Result := cEnumValues[Integer(Self)];
end;

{ TdxHtmlEditorListTypeHelper }

procedure TdxHtmlEditorListTypeHelper.Parse(AValue: TJSONValue;
  ADefault: TdxHtmlEditorListType);
var
  AListType: string;
  I: Integer;
begin
  Self := ADefault;
  if (AValue <> nil) and AValue.TryGetValue<string>(AListType) then
    for I := Integer(TdxHtmlEditorListType.None) to Integer(TdxHtmlEditorListType.Bullet) do
      if AListType = cEnumValues[I] then
      begin
        Self := TdxHtmlEditorListType(I);
        Break;
      end;
end;

function TdxHtmlEditorListTypeHelper.ToJsString: string;
begin
  Result := cEnumValues[Integer(Self)];
end;

{ TdxHtmlEditorHeadingHelper }

procedure TdxHtmlEditorHeadingHelper.Parse(AValue: TJSONValue;
  ADefault: TdxHtmlEditorHeadingLevel);
var
  AHeading: string;
begin
  Self := ADefault;
  if (AValue <> nil) and AValue.TryGetValue<string>(AHeading) then
    Self := TdxHtmlEditorHeadingLevel(StrToInt(AHeading));
end;

function TdxHtmlEditorHeadingHelper.ToJsString: string;
begin
  Result := Integer(Self).ToString;
end;

{ TdxHtmlEditorHistoryHelper }

procedure TdxHtmlEditorHistoryHelper.Parse(AValue: TJSONValue);
begin
  AValue.TryGetValue<Boolean>(cCanUndo, Self.CanUndo);
  AValue.TryGetValue<Boolean>(cCanRedo, Self.CanRedo);
end;

{ TdxHtmlEditorTextRangeHelper }

procedure TdxHtmlEditorTextRangeHelper.Parse(AValue: TJSONValue);
begin
  AValue.TryGetValue<Integer>(cIndex, Self.Index);
  AValue.TryGetValue<Integer>(cLength, Self.Length);
end;

function TdxHtmlEditorTextRangeHelper.ToJson: string;
begin
  with TJSONObject.Create do
  try
    AddPair(cIndex, Index);
    AddPair(cLength, Length);
    Result := ToString;
  finally
    Free;
  end;
end;

{ TdxHtmlEditorTextFormatHelper }

procedure TdxHtmlEditorTextFormatHelper.Parse(AValue: TJSONValue);

  procedure ParseFormatLink();
  var
    ALink: string;
    ARangeValue: TJSONValue;
  begin
    FreeAndNil(FHyperlink);
    if AValue.TryGetValue<string>(cLink, ALink) and (ALink <> '') then
    begin
      FHyperlink := TdxHtmlEditorHyperlinkInfo.Create('', ALink);

      AValue.TryGetValue<string>(cLinkText, FHyperlink.FText);

      ARangeValue := AValue.FindValue(cLinkRange);
      if ARangeValue <> nil then
        FHyperlink.Range.Parse(ARangeValue);
    end;
  end;

  function ParseFontSize(ASizeValue: TJSONValue): Integer;
  var
    ASize: string;
  begin
    Result := 0;
    if ASizeValue <> nil then
    begin
      ASize := ASizeValue.GetValue<string>;
      if ASize.EndsWith(cPt, True) then
        Result := ASize.Substring(0, ASize.Length - cPt.Length).ToInteger;
    end;
  end;

var
  AIsImage: string;
begin
  FBold.Parse(AValue.FindValue(cBold));
  FItalic.Parse(AValue.FindValue(cItalic));
  FUnderline.Parse(AValue.FindValue(cUnderline));
  FStrikeout.Parse(AValue.FindValue(cStrike));

  FAlignment.Parse(AValue.FindValue(cAlign));
  FHeadingLevel.Parse(AValue.FindValue(cHeader));

  FFontName := '';
  AValue.TryGetValue<string>(cFont, FFontName);
  FFontSize := ParseFontSize(AValue.FindValue(cSize));

  FIndent.Parse(AValue.FindValue(cIndent));
  FLineHeight.Parse(AValue.FindValue(cLineHeight));

  FListType.Parse(AValue.FindValue(cList));

  FIsTable.Parse(AValue.FindValue(cIsTable));

  AValue.TryGetValue<string>(cImageSrc, AIsImage);
  FIsImage := AIsImage = cImage;

  ParseFormatLink();
end;

function TdxHtmlEditorTextFormatHelper.ToJson: string;
begin
  with TJSONObject.Create do
  try
    if (TFormatChange.Bold in FChanges) then
      AddPair(cBold, FBold);
    if (TFormatChange.Italic in FChanges) then
      AddPair(cItalic, FItalic);
    if (TFormatChange.Underline in FChanges) then
      AddPair(cUnderline, FUnderline);
    if (TFormatChange.Strikeout in FChanges) then
      AddPair(cStrike, FStrikeout);

    if (TFormatChange.Alignment in FChanges) then
      AddPair(cAlign, FAlignment.ToJSString);

    if (TFormatChange.HeadingLevel in FChanges) then
      AddPair(cHeader, FHeadingLevel.ToJSString);

    if (TFormatChange.ListType in FChanges) then
      AddPair(cList, FListType.ToJsString);

    if (TFormatChange.FontName in FChanges) then
      AddPair(cFont, FFontName);
    if (TFormatChange.FontSize in FChanges) then
      AddPair(cSize, String.Format('%d' + cPt, [FFontSize]));

    if (TFormatChange.Indent in FChanges) then
      AddPair(cIndent, FIndent);
    if (TFormatChange.LineHeight in FChanges) then
      AddPair(cLineHeight, FLineHeight);

    Result := ToString;
  finally
    Free;
  end;
end;

{ TdxHtmlEditorHyperlinkHelper }

function TdxHtmlEditorHyperlinkHelper.ToJson: string;
begin
  if Self = nil then
  begin
    Result := '';
    Exit;
  end;

  with TJSONObject.Create do
  try
    AddPair(cText, FText);
    AddPair(cUrl, FUrl);
    Result := ToString;
  finally
    Free;
  end;
end;

{ TdxHtmlEditorImageHelper }

procedure TdxHtmlEditorImageHelper.Parse(AValue: TJSONValue);
begin
  AValue.TryGetValue<string>(cSrc, FSrc);
  FWidth.Parse(AValue.FindValue(cWidth));
  FHeight.Parse(AValue.FindValue(cHeight));
end;

{ TdxHtmlEditorBrowserAdapter }

constructor TdxHtmlEditorBrowserAdapter.Create(AOwner: TComponent;
  ABrowser: TEdgeBrowser);
begin
  inherited Create(AOwner, ABrowser);
  FTextFormat := TdxHtmlEditorTextFormat.Create;
end;

destructor TdxHtmlEditorBrowserAdapter.Destroy;
begin
  FTextFormat.Free;
  inherited;
end;

// public void OnLoaded()
procedure TdxHtmlEditorBrowserAdapter.DoLoaded(AArgs: TJSInteropArgs);
begin
  ExecuteScript('Runtime.init("html-container", false, true, "12px")');
  FLoaded := True;
  if Assigned(FOnLoaded) then
    FOnLoaded(Self);
  if FSavedHtml <> '' then
  begin
    SetHtmlText(FSavedHtml);
    FSavedHtml := '';
  end;
end;

// public void OnSelectionChanged(RangeInfo selectionRange, TextFormatInfo textFormat, HistoryStateInfo historyStateInfo, string selectedText)
procedure TdxHtmlEditorBrowserAdapter.DoSelectionChanged(AArgs: TJSInteropArgs);
var
  ASelectedText: string;
begin
  if Assigned(FOnSelectionChanged) then
  begin
    FSelection.Parse(AArgs.Items[0]);
    FTextFormat.Parse(AArgs.Items[1]);
    FHistory.Parse(AArgs.Items[2]);
    AArgs.Items[3].TryGetValue<string>(ASelectedText);
    FOnSelectionChanged(FSelection, FTextFormat, FHistory, ASelectedText);
  end;
end;

// OnTextChanged(HistoryStateInfo historyStateInfo, RangeInfo selectionRange)
procedure TdxHtmlEditorBrowserAdapter.DoTextChanged(AArgs: TJSInteropArgs);
begin
  if Assigned(FOnTextChanged) then
  begin
    FHistory.Parse(AArgs.Items[0]);
    FSelection.Parse(AArgs.Items[1]);
    FOnTextChanged(FHistory, FSelection);
  end;
end;

function TdxHtmlEditorBrowserAdapter.Execute(const jsMethod: string): string;
begin
  Result := Execute(jsMethod, []);
end;

function TdxHtmlEditorBrowserAdapter.Execute(const jsMethod: string; const AArgs: array of string): string;
begin
  Result := ExecuteScript(GetBrowserScript(jsMethod, AArgs));
end;

procedure TdxHtmlEditorBrowserAdapter.ExecuteAsync(const jsMethod: string);
begin
  ExecuteAsync(jsMethod, []);
end;

procedure TdxHtmlEditorBrowserAdapter.ExecuteAsync(const jsMethod: string;
  const AArgs: array of string);
begin
  ExecuteScriptAsync(GetBrowserScript(jsMethod, AArgs));
end;

procedure TdxHtmlEditorBrowserAdapter.ExecuteTableOperation(
  AOperation: TdxHtmlTableOperation);
var
  AOp: string;
begin
  AOp := GetEnumName(TypeInfo(TdxHtmlTableOperation), Integer(AOperation));
  ExecuteAsync('executeTableOperation', [GetStringArg(GetJSStyleIdent(AOp))]);
end;

function TdxHtmlEditorBrowserAdapter.GetBrowserScript(const jsMethod: string;
  const AArgs: array of string): string;
var
  jsArgs: string;
  I: Integer;
const
  ObjectId = 'Runtime.client';
begin
  with TStringBuilder.Create do
  try
    for I := 0 to High(AArgs) do
    begin
      if I > 0 then
        Append(',');
      Append(AArgs[I]);
    end;
    jsArgs := ToString();
  finally
    Free;
  end;

  Result := Format('Runtime.invoke("%s", "%s", [%s])', [ObjectId, jsMethod, jsArgs]);
end;

class function TdxHtmlEditorBrowserAdapter.GetHeaders(const AAsset: string;
  out AAllowSetTheme: Boolean): string;
begin
  AAllowSetTheme := False;
  if AAsset.EndsWith('_html', True) then
  begin
    AAllowSetTheme := True;
    Exit('Content-Type: text/html');
  end
  else
    if AAsset.EndsWith('_css', True) then
      Exit('Content-type: text/css')
    else
      if AAsset.EndsWith('_js', True) then
        Exit('Content-Type: application/javascript');
  Result := '';
end;

class function TdxHtmlEditorBrowserAdapter.GetJSStyleIdent(const AIdent: string): string;
begin
  Result := AIdent;
  Result[1] := CharLower(AIdent[1]);
end;

function TdxHtmlEditorBrowserAdapter.GetMessage(AJson: TJSONValue; out AMessageName: string): Boolean;
var
  AMsg: string;
const
  JS_METHOD_CALL = 'dtnr|';
begin
  AMsg := AJson.GetValue<string>('message');
  Result := AMsg.StartsWith(JS_METHOD_CALL);
  AMessageName := AMsg.Substring(Length(JS_METHOD_CALL));
end;

function TdxHtmlEditorBrowserAdapter.GetMessageParams(AJson: TJSONValue; out AParams: TJSInteropArgs): Boolean;
var
  AArgs:TJSONValue;
begin
  AArgs := AJson.FindValue('args');
  Result := AArgs <> nil;
  if Result then
    AParams := AArgs as TJSInteropArgs;
end;

class function TdxHtmlEditorBrowserAdapter.GetStringArg(const AValue: string): string;
begin
  Result := Format('"%s"', [AValue]);
end;

function TdxHtmlEditorBrowserAdapter.GetWebResource(const AUri: string;
  out AHeaders: string; out AContent: TStream): Boolean;

  function GetThemeRes: string;
  begin
    if FDarkTheme then
      Result := 'DX_DARK_CSS'
    else
      Result := 'DX_LIGHT_CSS';
  end;

var
  AResource: string;
  AIndex: Integer;
  AResourceStream: TStream;
  AMemStream: TMemoryStream;
  AZipFile: TZipFile;
  AHeader: TZipHeader;
  AExtractStream: TStream;
  AAllowSetTheme: Boolean;
begin
  AResource := AUri.Substring(RootURIFilter.Length - 1).Replace('.', '_');

  AIndex := AResource.LastIndexOf('?');
  if AIndex <> -1 then
    AResource := AResource.Substring(0, AIndex);
  if AResource = ThemeNameReplace then
    AResource := GetThemeRes;

  Result := FindResource(HInstance, PChar(AResource), RT_RCDATA) <> 0;
  if not Result then
    Exit;

  AResourceStream := TResourceStream.Create(HInstance, AResource, RT_RCDATA);
  if TZipFile.IsValid(AResourceStream) then
  begin
    AMemStream := TMemoryStream.Create;
    AZipFile := TZipFile.Create;
    try
      AResourceStream.Position := 0;
      AZipFile.Open(AResourceStream, zmRead);
      AZipFile.Read(0, AExtractStream, AHeader, False);
      try
        AMemStream.LoadFromStream(AExtractStream);
      finally
        AExtractStream.Free;
      end;
    finally
      AZipFile.Free;
    end;

    AResourceStream.Free;
    AResourceStream := AMemStream;
  end;

  AHeaders := GetHeaders(AResource, AAllowSetTheme);
  AContent := AResourceStream;
end;

procedure TdxHtmlEditorBrowserAdapter.Redo;
begin
  ExecuteAsync(cRedo);
end;

procedure TdxHtmlEditorBrowserAdapter.Refresh;
begin
  FSavedHtml := GetHtmlText;
  inherited;
end;

procedure TdxHtmlEditorBrowserAdapter.setReadOnly(AValue: Boolean);
begin
  ExecuteAsync(cSetReadOnly, AValue.ToJsString());
end;

procedure TdxHtmlEditorBrowserAdapter.InsertImage(const AImageString: string;
  const AImageType: string; AWidth: Integer; AHeight: Integer; const ARange: TdxHtmlEditorTextRange);
begin
  if ARange.IsEmpty then
    ExecuteAsync(cInsertImage, [GetStringArg(AImageString), AImageType, AWidth.ToString, AHeight.ToString])
  else
    ExecuteAsync(cInsertImage, [GetStringArg(AImageString), AImageType, AWidth.ToString, AHeight.ToString, ARange.ToJson]);
end;

procedure TdxHtmlEditorBrowserAdapter.InsertImageByUrl(const AUrl: string; AWidth,
  AHeight: Integer; const ARange: TdxHtmlEditorTextRange);
begin
  if ARange.IsEmpty then
    ExecuteAsync(cInsertImageByUrl, [GetStringArg(AUrl), AWidth.ToString, AHeight.ToString])
  else
    ExecuteAsync(cInsertImageByUrl, [GetStringArg(AUrl), AWidth.ToString, AHeight.ToString, ARange.ToJson])
end;

procedure TdxHtmlEditorBrowserAdapter.InsertLink(
  ALinkInfo: TdxHtmlEditorHyperlinkInfo; const ARange: TdxHtmlEditorTextRange);
begin
  if ARange.IsEmpty then
    ExecuteAsync(cSetHyperlink, [ALinkInfo.ToJson])
  else
    ExecuteAsync(cSetHyperlink, [ALinkInfo.ToJson, ARange.ToJson]);
end;

procedure TdxHtmlEditorBrowserAdapter.insertTable(ARowCount, AColumnCount: Integer);
begin
  ExecuteAsync(cInsertTable, [ARowCount.ToString, AColumnCount.ToString]);
end;

function TdxHtmlEditorBrowserAdapter.getHtmlText: string;
var
  AResult: String;
  AValue: TJSONValue;
begin
  Result := '';
  AResult := Execute(cGetHtml);
  if AResult <> '' then
  begin
    AValue := TJSONObject.ParseJSONValue(AResult);
    try
      Result := AValue.Value;
    finally
      AValue.Free;
    end;
  end;
end;

function TdxHtmlEditorBrowserAdapter.GetImageInfo: TdxHtmlEditorImageInfo;
var
  AResult: String;
  AValue: TJSONValue;
begin
  Result := nil;
  AResult := Execute(cGetImageInfo);
  if AResult <> '' then
  begin
    AValue := TJSONObject.ParseJSONValue(AResult);
    try
      Result := TdxHtmlEditorImageInfo.Create;
      Result.Parse(AValue);
    finally
      AValue.Free;
    end;
  end;
end;

procedure TdxHtmlEditorBrowserAdapter.SetDarkTheme(const AValue: Boolean);
begin
  if FDarkTheme <> AValue then
  begin
    FDarkTheme := AValue;
    ExecuteAsync(cReloadCSS);
  end;
end;

procedure TdxHtmlEditorBrowserAdapter.SetFormat(
  AFormat: TdxHtmlEditorTextFormat);
begin
  ExecuteAsync(cSetFormat, [AFormat.ToJson]);
  AFormat.ClearChanges;
end;

procedure TdxHtmlEditorBrowserAdapter.setHtmlText(const AHtmlString: string);
var
  ABase64String: string;
begin
  if not FLoaded then
  begin
    FSavedHtml := AHtmlString;
    Exit;
  end;

  with TBase64Encoding.Create(0) do
  try
    ABase64String := GetStringArg(Encode(AHtmlString));
  finally
    Free;
  end;
  ExecuteAsync(cSetHtml, [ABase64String]);
end;

procedure TdxHtmlEditorBrowserAdapter.SetupBrowser;
begin
  inherited;
  // Disable default menu (ICoreWebView2ContextMenuRequestedEventHandler for OnPopupEvent)
  Browser.DefaultContextMenusEnabled := false;

  // Add message handlers
  AddMessageHandler(cOnLoaded, DoLoaded);
  AddMessageHandler(cOnSelectionChanged, DoSelectionChanged);
  AddMessageHandler(cOnTextChanged, DoTextChanged);
  // Request handling
  Browser.AddWebResourceRequestedFilter(RootURIFilter, COREWEBVIEW2_WEB_RESOURCE_CONTEXT_ALL);
  Browser.Navigate(RootURI);
end;

procedure TdxHtmlEditorBrowserAdapter.Undo;
begin
  ExecuteAsync(cUndo);
end;

{ TdxHtmlEditor }

constructor TdxHtmlEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FEdgeBrowser := TEdgeBrowser.Create(nil);
  FEdgeBrowser.Align := alClient;
  FEdgeBrowser.Parent := Self;
  FEdgeBrowser.Visible := True;

  FTextFormat := TdxHtmlEditorTextFormat.Create;
  FTextFormat.OnFormatChanged := OnTextFormatChanged;
end;

destructor TdxHtmlEditor.Destroy;
begin
  FTextFormat.Free;
  Finalize;
  inherited;
end;

procedure TdxHtmlEditor.DoChanged;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TdxHtmlEditor.DoLoaded(Sender: TObject);
begin
  FLoaded := True;
  if Assigned(FOnLoaded) then
    FOnLoaded(Self);
end;

procedure TdxHtmlEditor.DoSelectionChanged(
  const ASelection: TdxHtmlEditorTextRange; ATextFormat: TdxHtmlEditorTextFormat;
  const AHistory: TdxHtmlEditorHistory; const ASelectedText: string);
begin
  FHistory := AHistory;
  FSelection := ASelection;
  FSelectedText := ASelectedText;
  FTextFormat.Assign(ATextFormat);
  DoChanged;
end;

procedure TdxHtmlEditor.DoTextChanged(const AHistory: TdxHtmlEditorHistory; const ASelection: TdxHtmlEditorTextRange);
begin
  FHistory := AHistory;
  FSelection := ASelection;
  DoChanged;
end;

procedure TdxHtmlEditor.ExecuteTableOperation(
  AOperation: TdxHtmlTableOperation);
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).ExecuteTableOperation(AOperation);
end;

procedure TdxHtmlEditor.Finalize;
begin
  FreeAndNil(FBrowserAdapter);
end;

function TdxHtmlEditor.GetCanRedo: Boolean;
begin
  Result := FHistory.CanRedo;
end;

function TdxHtmlEditor.GetCanUndo: Boolean;
begin
  Result := FHistory.CanUndo;
end;

function TdxHtmlEditor.GetDarkTheme: Boolean;
begin
  Result := TdxHtmlEditorBrowserAdapter(FBrowserAdapter).DarkTheme;
end;

function TdxHtmlEditor.GetHtmlText: string;
begin
  Result := TdxHtmlEditorBrowserAdapter(FBrowserAdapter).getHtmlText;
end;

function TdxHtmlEditor.GetImageInfo: TdxHtmlEditorImageInfo;
begin
  Result := TdxHtmlEditorBrowserAdapter(FBrowserAdapter).GetImageInfo;
end;

procedure TdxHtmlEditor.Initialize;
begin
  FBrowserAdapter := TdxHtmlEditorBrowserAdapter.Create(Self, FEdgeBrowser);
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).OnLoaded := DoLoaded;
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).OnSelectionChanged := DoSelectionChanged;
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).OnTextChanged := DoTextChanged;

  FEdgeBrowser.CreateWebView;
end;

procedure TdxHtmlEditor.InsertImageByUrl(const AUrl: string; AWidth,
  AHeight: Integer; ARange: TdxHtmlEditorTextRange);
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).InsertImageByUrl(AUrl, AWidth, AHeight, ARange);
end;

procedure TdxHtmlEditor.InsertImageByUrl(const AUrl: string; AWidth: Integer; AHeight: Integer);
var
  ARange: TdxHtmlEditorTextRange;
begin
  ARange.Reset;
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).InsertImageByUrl(AUrl, AWidth, AHeight, ARange);
end;

procedure TdxHtmlEditor.InsertLink(ALinkInfo: TdxHtmlEditorHyperlinkInfo);
var
  ARange: TdxHtmlEditorTextRange;
begin
  ARange.Reset;
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).InsertLink(ALinkInfo, ARange);
end;

procedure TdxHtmlEditor.InsertLink(ALinkInfo: TdxHtmlEditorHyperlinkInfo; ARange: TdxHtmlEditorTextRange);
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).InsertLink(ALinkInfo, ARange);
end;

procedure TdxHtmlEditor.InsertTable(ARowCount, AColumnCount: Integer);
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).InsertTable(ARowCount, AColumnCount);
end;

procedure TdxHtmlEditor.OnTextFormatChanged(Sender: TObject);
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).SetFormat(SelectedTextFormat);
end;

procedure TdxHtmlEditor.Redo;
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).Redo;
end;

procedure TdxHtmlEditor.SetDarkTheme(AValue: Boolean);
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).DarkTheme := AValue;
end;

procedure TdxHtmlEditor.SetHtmlText(const AValue: string);
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).setHtmlText(AValue);
end;

procedure TdxHtmlEditor.SetReadOnly(const AValue: Boolean);
begin
  if FReadOnly <> AValue then
  begin
    TdxHtmlEditorBrowserAdapter(FBrowserAdapter).setReadOnly(AValue);
    FReadOnly := AValue;
  end;
end;

procedure TdxHtmlEditor.Undo;
begin
  TdxHtmlEditorBrowserAdapter(FBrowserAdapter).Undo;
end;

{ TdxHtmlEditorTextRange }

function TdxHtmlEditorTextRange.IsEmpty: Boolean;
begin
  Result := Self.Length = 0;
end;

procedure TdxHtmlEditorTextRange.Reset;
begin
  Index := 0;
  Length := 0;
end;

{ TdxHtmlEditorHyperlinkInfo }

constructor TdxHtmlEditorHyperlinkInfo.Create(const AText, AUrl: string);
begin
  inherited Create;
  FText := AText;
  FUrl := AUrl;
end;

procedure TdxHtmlEditorHyperlinkInfo.AssignTo(Dest: TPersistent);
var
  ADest: TdxHtmlEditorHyperlinkInfo;
begin
  ADest := TdxHtmlEditorHyperlinkInfo(Dest);
  ADest.FText := FText;
  ADest.FUrl := FUrl;
  ADest.FRange := FRange;
end;

{ TdxHtmlEditorTextFormat }

constructor TdxHtmlEditorTextFormat.Create;
begin
  inherited Create;
end;

destructor TdxHtmlEditorTextFormat.Destroy;
begin
  FreeAndNil(FHyperlink);
  inherited;
end;

procedure TdxHtmlEditorTextFormat.AssignTo(Dest: TPersistent);
var
  ADest: TdxHtmlEditorTextFormat;
begin
  ADest := TdxHtmlEditorTextFormat(Dest);
  ADest.FChanges := FChanges;

  ADest.FBold := FBold;
  ADest.FItalic := FItalic;
  ADest.FUnderline := FUnderline;
  ADest.FStrikeout := FStrikeout;

  ADest.FAlignment := FAlignment;
  ADest.FHeadingLevel := FHeadingLevel;

  ADest.FFontName := FFontName;
  ADest.FFontSize := FFontSize;

  ADest.FListType := FListType;
  ADest.FIndent := FIndent;
  ADest.FLineHeight := FLineHeight;

  ADest.FIsImage := FIsImage;
  ADest.FIsTable := FIsTable;

  FreeAndNil(ADest.FHyperlink);
  if FHyperlink <> nil then
  begin
    ADest.FHyperlink := TdxHtmlEditorHyperlinkInfo.Create();
    ADest.FHyperlink.Assign(FHyperlink);
  end;
end;

procedure TdxHtmlEditorTextFormat.ClearChanges;
begin
  FChanges := [];
end;

procedure TdxHtmlEditorTextFormat.DoFormatChanged(AChange :TFormatChange);
begin
  Include(FChanges, AChange);
  if Assigned(FOnFormatChanged) then
    FOnFormatChanged(Self);
end;

procedure TdxHtmlEditorTextFormat.SetAlignment(AValue: TAlignment);
begin
  if FAlignment <> AValue then
  begin
    FAlignment := AValue;
    DoFormatChanged(TFormatChange.Alignment);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetBold(AValue: Boolean);
begin
  if FBold <> AValue then
  begin
    FBold := AValue;
    DoFormatChanged(TFormatChange.Bold);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetFontName(AValue: string);
begin
  if FFontName <> AValue then
  begin
    FFontName := AValue;
    DoFormatChanged(TFormatChange.FontName);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetFontSize(AValue: Integer);
begin
  if FFontSize <> AValue then
  begin
    FFontSize := AValue;
    DoFormatChanged(TFormatChange.FontSize);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetHeadingLevel(AValue: TdxHtmlEditorHeadingLevel);
begin
  if FHeadingLevel <> AValue then
  begin
    FHeadingLevel := AValue;
    DoFormatChanged(TFormatChange.HeadingLevel);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetIndent(AValue: Integer);
begin
  if FIndent <> AValue then
  begin
    FIndent := AValue;
    DoFormatChanged(TFormatChange.Indent);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetItalic(AValue: Boolean);
begin
  if FItalic <> AValue then
  begin
    FItalic := AValue;
    DoFormatChanged(TFormatChange.Italic);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetLineHeight(AValue: Single);
begin
  if FLineHeight <> AValue then
  begin
    FLineHeight := AValue;
    DoFormatChanged(TFormatChange.LineHeight);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetListType(AValue: TdxHtmlEditorListType);
begin
  if FListType <> AValue then
  begin
    FListType := AValue;
    DoFormatChanged(TFormatChange.ListType);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetStrikeout(AValue: Boolean);
begin
  if FStrikeout <> AValue then
  begin
    FStrikeout := AValue;
    DoFormatChanged(TFormatChange.Strikeout);
  end;
end;

procedure TdxHtmlEditorTextFormat.SetUnderline(AValue: Boolean);
begin
  if FUnderline <> AValue then
  begin
    FUnderline := AValue;
    DoFormatChanged(TFormatChange.Underline);
  end;
end;

end.
