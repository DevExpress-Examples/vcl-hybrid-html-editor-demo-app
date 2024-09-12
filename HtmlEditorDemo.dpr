program HtmlEditorDemo;

uses
  Vcl.Forms,
  dxUIAClasses,
  dxHtmlEditor in 'dxHtmlEditor.pas',
  dxEdgeBrowserAdapter in 'dxEdgeBrowserAdapter.pas',
  uMain in 'uMain.pas' {fmHtmlEditor},
  dxInsertTableDialog in 'Dialogs\dxInsertTableDialog.pas' {dxInsertTableDialogForm},
  dxImageDialog in 'Dialogs\dxImageDialog.pas' {dxImageDialogForm};

{$R *.res}

begin
  dxUIAutomationEnabled := False;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmHtmlEditor, fmHtmlEditor);
  Application.Run;
end.
