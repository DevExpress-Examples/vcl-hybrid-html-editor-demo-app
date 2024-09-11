<!-- default badges list -->
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T1252982)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
[![](https://img.shields.io/badge/💬_Leave_Feedback-feecdd?style=flat-square)](#does-this-example-address-your-development-requirementsobjectives)
<!-- default badges end -->

# A Proof-of-Concept for Hybrid VCL Components (Powered by JS/DevExtreme Wrappers for Delphi)

The demo application in this repository illustrates the idea of hybrid VCL applications that rely on a [WebView component](https://docwiki.embarcadero.com/Libraries/Athens/en/Vcl.Edge.TEdgeBrowser) (an embedded web browser) in a native container app for Microsoft Windows.

The **HTML Editor** demo project relies on the [TEdgeBrowser](https://docwiki.embarcadero.com/Libraries/Athens/en/Vcl.Edge.TEdgeBrowser) component from the standard VCL library to display the [JavaScript DevExtreme HTML Editor](https://js.devexpress.com/React/Documentation/18_2/ApiReference/UI_Widgets/dxHtmlEditor/) wrapped into [WebPack](https://webpack.js.org/) to eschew the internet connection requirement.

The editor switches between light and dark [CSS DevExtreme themes](https://js.devexpress.com/jQuery/Documentation/Guide/Themes_and_Styles/Predefined_Themes/) in response to switching between corresponding [DevExpress VCL skins and palettes](https://docs.devexpress.com/VCL/150003/ExpressSkinsLibrary/vcl-skin-library).

## How to Configure JS Widgets in Delphi Code

The DevExtreme HTML editor interacts with the [VCL Ribbon](https://docs.devexpress.com/VCL/dxRibbon.TdxRibbon) through Delphi code. The following code example illustrates the image insertion command available in the Ribbon UI:

```
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
```

## Prerequisites

* Embarcadero RAD Studio IDE 12.0 or newer (Community Edition is not supported)
* The [EdgeView2 SDK](https://getitnow.embarcadero.com/edgeview2-sdk/) package installed from GetIt
* DevExpress VCL Components v24.1.3 or newer

The RAD Studio IDE displays the following dialog when you build the demo project:

Click **Yes** to build and run the demo. The demo does not require internet connection.

> This example is a proof of concept and is not supposed to be used in production. Production use also requires a license for [DevExpress JavaScript products](https://www.devexpress.com/buy/js/) (not covered by VCL subscriptions). For more information, refer to [Hybrid VCL Components (aka JS/DevExtreme Wrappers)](https://community.devexpress.com/blogs/vcl/archive/2024/07/24/vcl-year-end-roadmap-v24-2.aspx) and [Additional Thoughts on Hybrid VCL Apps with DevExpress (Reporting, Dashboards, etc.)](https://community.devexpress.com/blogs/vcl/archive/2024/07/24/vcl-year-end-roadmap-v24-2.aspx)

<!-- feedback -->
## Does this example address your development requirements/objectives?

[<img src="https://www.devexpress.com/support/examples/i/yes-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=vcl-hybrid-html-editor-demo-app&~~~was_helpful=yes) [<img src="https://www.devexpress.com/support/examples/i/no-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=vcl-hybrid-html-editor-demo-app&~~~was_helpful=no)

(you will be redirected to DevExpress.com to submit your response)
<!-- feedback end -->
