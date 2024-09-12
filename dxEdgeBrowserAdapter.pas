unit dxEdgeBrowserAdapter;

interface

uses
  System.Classes, System.JSON,
  System.Generics.Collections,
  Vcl.Controls, Vcl.Edge;

type
  TJSInteropArgs = TJSONArray;
  TJSMessageHandler = procedure(Args: TJSInteropArgs) of object;

  TdxEdgeBrowserAdapter = class
  private
    FOwner: TComponent;
    FBrowser: TEdgeBrowser;
    FHandlers: TDictionary<string, TJSMessageHandler>;

    procedure OnCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
    procedure OnWebMessageReceived(Sender: TCustomEdgeBrowser; Args: TWebMessageReceivedEventArgs);
    procedure OnWebResourceRequested(Sender: TCustomEdgeBrowser; Args: TWebResourceRequestedEventArgs);
  protected
    procedure AddMessageHandler(const AHandlerName: string; AMethod: TJSMessageHandler);

    procedure SetupBrowser; virtual;
    procedure FinalizeBrowser; virtual;

    procedure Refresh; virtual;

    function GetMessage(AJson: TJSONValue; out AMessageName: string): Boolean; virtual;
    function GetMessageParams(AJson: TJSONValue; out AParams: TJSInteropArgs): Boolean; virtual;

    function GetWebResource(const AUri: string; out AHeaders: string; out AContent: TStream): Boolean; virtual;

    function ExecuteScript(const AJavaScript: string): string;
    procedure ExecuteScriptAsync(const AJavaScript: string);

    property Browser: TEdgeBrowser read FBrowser;
  public
    constructor Create(AOwner: TComponent; ABrowser: TEdgeBrowser);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, Winapi.ActiveX, Winapi.WebView2, Winapi.EdgeUtils,
  Vcl.Forms,
  dxThreading;

function ContentResponse(const AEnvironment: ICoreWebView2Environment; const AHeaders: string; AContent: TStream): ICoreWebView2WebResourceResponse;
begin
  AEnvironment.CreateWebResourceResponse(TStreamAdapter.Create(AContent, soOwned), 200, 'OK', PChar(AHeaders), Result);
end;

function NotFoundResponse(const AEnvironment: ICoreWebView2Environment): ICoreWebView2WebResourceResponse;
begin
  AEnvironment.CreateWebResourceResponse(nil, 404, 'Not found', '', Result);
end;

{ TdxEdgeBrowserAdapter }

constructor TdxEdgeBrowserAdapter.Create(AOwner: TComponent; ABrowser: TEdgeBrowser);
begin
  inherited Create;
  FOwner := AOwner;
  FBrowser := ABrowser;
  FBrowser.OnCreateWebViewCompleted := OnCreateWebViewCompleted;
  FHandlers := TDictionary<string, TJSMessageHandler>.Create;
end;

destructor TdxEdgeBrowserAdapter.Destroy;
begin
  FinalizeBrowser;
  FHandlers.Free;
  inherited;
end;

function TdxEdgeBrowserAdapter.ExecuteScript(const AJavaScript: string): string;
var
  ALock: Boolean;
  AResult: string;
begin
  AResult := '';
  if FBrowser.DefaultInterface <> nil then
  begin
    ALock := True;
    FBrowser.DefaultInterface.ExecuteScript(PChar(AJavaScript),
      Callback<HResult, PChar>.CreateAs<ICoreWebView2ExecuteScriptCompletedHandler>(
        function(ErrorCode: HResult; ResultObjectAsJson: PWideChar): HResult stdcall
        begin
          Result := S_OK;
          if ResultObjectAsJson <> 'null' then
            AResult := String(ResultObjectAsJson);
          ALock := False;
        end));
    while not Application.Terminated and ALock do
      Application.ProcessMessages;
  end;
  Result := AResult;
end;

procedure TdxEdgeBrowserAdapter.ExecuteScriptAsync(const AJavaScript: string);
begin
  if FBrowser.DefaultInterface <> nil then
    TdxUIThreadSyncService.EnqueueInvokeInUIThread(Self,
      procedure ()
      begin
        FBrowser.DefaultInterface.ExecuteScript(PChar(AJavaScript), nil);
      end);
end;

procedure TdxEdgeBrowserAdapter.AddMessageHandler(const AHandlerName: string;
  AMethod: TJSMessageHandler);
begin
  FHandlers.Add(AHandlerName, AMethod);
end;

procedure TdxEdgeBrowserAdapter.FinalizeBrowser;
begin
  if FBrowser <> nil then
  begin
    FBrowser.OnCreateWebViewCompleted := nil;
    FBrowser.OnWebMessageReceived := nil;
    FBrowser.OnWebResourceRequested := nil;
    FBrowser := nil;
  end;
end;

function TdxEdgeBrowserAdapter.GetMessage(AJson: TJSONValue; out AMessageName: string): Boolean;
begin
  Result := False;
end;

function TdxEdgeBrowserAdapter.GetMessageParams(AJson: TJSONValue; out AParams: TJSInteropArgs): Boolean;
begin
  Result := False;
end;

function TdxEdgeBrowserAdapter.GetWebResource(const AUri: string;
  out AHeaders: string; out AContent: TStream): Boolean;
begin
  Result := False;
end;

procedure TdxEdgeBrowserAdapter.OnCreateWebViewCompleted(
  Sender: TCustomEdgeBrowser; AResult: HRESULT);
begin
  if AResult = S_OK then
    TdxUIThreadSyncService.EnqueueInvokeInUIThread(Self,
      procedure ()
      begin
        SetupBrowser;
      end);
end;

procedure TdxEdgeBrowserAdapter.OnWebMessageReceived(
  Sender: TCustomEdgeBrowser; Args: TWebMessageReceivedEventArgs);
var
  P: PChar;
  AJSONObj: TJSONValue;
  AMethodName: string;
  AMethod: TJSMessageHandler;
  AArgs, ALocalArgs: TJSONArray;
begin
  if Succeeded(Args.ArgsInterface.TryGetWebMessageAsString(P)) then
  begin
    try
      AJSONObj := TJSONObject.ParseJSONValue(String(P));
      try
        if GetMessage(AJSONObj, AMethodName) then
        begin
          if FHandlers.TryGetValue(AMethodName, AMethod) then
          begin
            ALocalArgs := nil;
            if GetMessageParams(AJSONObj, AArgs) then
              ALocalArgs := AArgs.Clone as TJSONArray;

            TdxUIThreadSyncService.EnqueueInvokeInUIThread(Self,
            procedure ()
            begin
              AMethod(ALocalArgs);
              ALocalArgs.Free;
            end);
          end;
        end;
      finally
        AJSONObj.Free;
      end;
    finally
      CoTaskMemFree(P);
    end;
  end;
end;

procedure TdxEdgeBrowserAdapter.OnWebResourceRequested(
  Sender: TCustomEdgeBrowser; Args: TWebResourceRequestedEventArgs);
var
  AEnvironment: ICoreWebView2Environment;
  AHeaders: string;
  AContent: TStream;
  ARequest: ICoreWebView2WebResourceRequest;
  AResponse: ICoreWebView2WebResourceResponse;
  AUri: PChar;
begin
  AEnvironment := Sender.EnvironmentInterface;
  if AEnvironment = nil then
    Exit;
  if Succeeded(Args.ArgsInterface.Get_Response(AResponse)) and
     Succeeded(Args.ArgsInterface.Get_Request(ARequest)) and Succeeded(ARequest.Get_uri(AUri)) then
  try
    if GetWebResource(String(AUri), AHeaders, AContent) then
      Args.ArgsInterface.Set_Response(ContentResponse(AEnvironment, AHeaders, AContent))
    else
      Args.ArgsInterface.Set_Response(NotFoundResponse(AEnvironment));
  finally
    CoTaskMemFree(AUri);
  end;
end;

procedure TdxEdgeBrowserAdapter.Refresh;
begin
  FBrowser.Refresh;
end;

procedure TdxEdgeBrowserAdapter.SetupBrowser;
begin
  FBrowser.SettingsInterface.Set_IsStatusBarEnabled(1);
  FBrowser.SettingsInterface.Set_IsScriptEnabled(1);
  FBrowser.SettingsInterface.Set_AreDevToolsEnabled(0);

  FBrowser.OnWebMessageReceived := OnWebMessageReceived;
  FBrowser.OnWebResourceRequested := OnWebResourceRequested;
end;


end.
