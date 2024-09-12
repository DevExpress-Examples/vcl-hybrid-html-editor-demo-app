unit dxImageDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, dxUIAClasses, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxSpinEdit, dxCoreGraphics,
  dxLayoutControlAdapters, dxLayoutcxEditAdapters, cxClasses,
  dxLayoutLookAndFeels, dxLayoutContainer, cxButtonEdit, dxLayoutControl;

type
  TdxImageDialogForm = class(TForm)
    lcMain: TdxLayoutControl;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMainGroup3: TdxLayoutGroup;
    lcMainSpaceItem1: TdxLayoutEmptySpaceItem;
    lcMainGroup14: TdxLayoutGroup;
    lcbtnOK: TdxLayoutItem;
    lcbtnCancel: TdxLayoutItem;
    dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList;
    dxLayoutCxLookAndFeel1: TdxLayoutCxLookAndFeel;
    seWidth: TcxSpinEdit;
    lcWidth: TdxLayoutItem;
    seHeight: TcxSpinEdit;
    lcHeight: TdxLayoutItem;
    txtUrl: TcxTextEdit;
    lcUrl: TdxLayoutItem;
  strict private
    function GetHeight: Integer;
    function GetUrl: string;
    function GetWidth: Integer;
    procedure SetHeight(Value: Integer);
    procedure SetUrl(const Value: string);
    procedure SetWidth(Value: Integer);
  private
  public
    property Url: string read GetUrl write SetUrl;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
  end;

implementation

{$R *.dfm}

{ TdxImageDialogForm }

function TdxImageDialogForm.GetHeight: Integer;
begin
  Result := seHeight.Value;
end;

function TdxImageDialogForm.GetUrl: string;
begin
  Result := txtUrl.Text;
end;

function TdxImageDialogForm.GetWidth: Integer;
begin
  Result := seWidth.Value;
end;

procedure TdxImageDialogForm.SetHeight(Value: Integer);
begin
  seHeight.Value := Value;
end;

procedure TdxImageDialogForm.SetUrl(const Value: string);
begin
  txtUrl.Text := Value;
end;

procedure TdxImageDialogForm.SetWidth(Value: Integer);
begin
  seWidth.Value := Value;
end;

end.
