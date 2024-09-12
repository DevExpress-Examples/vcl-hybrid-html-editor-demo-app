unit dxInsertTableDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, dxUIAClasses, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxSpinEdit, dxCoreGraphics,
  dxLayoutControlAdapters, dxLayoutcxEditAdapters, cxClasses,
  dxLayoutLookAndFeels, dxLayoutContainer, cxButtonEdit, dxLayoutControl;

type
  TdxInsertTableDialogForm = class(TForm)
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
    seColumns: TcxSpinEdit;
    lcColumns: TdxLayoutItem;
    seRows: TcxSpinEdit;
    lcRows: TdxLayoutItem;
  strict private
    function GetRows: Integer;
    function GetColumns: Integer;
    procedure SetRows(AValue: Integer);
    procedure SetColumns(AValue: Integer);
  public
    property Columns: Integer read GetColumns write SetColumns;
    property Rows: Integer read GetRows write SetRows;
  end;



implementation

{$R *.dfm}

{ TdxInsertTableDialogForm }

function TdxInsertTableDialogForm.GetColumns: Integer;
begin
  Result := seColumns.Value;
end;

function TdxInsertTableDialogForm.GetRows: Integer;
begin
  Result := seRows.Value;
end;

procedure TdxInsertTableDialogForm.SetColumns(AValue: Integer);
begin
  seColumns.Value := AValue;
end;

procedure TdxInsertTableDialogForm.SetRows(AValue: Integer);
begin
  seRows.Value := AValue;
end;

end.
