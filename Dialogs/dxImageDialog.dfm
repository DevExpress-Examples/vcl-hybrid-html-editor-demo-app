object dxImageDialogForm: TdxImageDialogForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Insert Image'
  ClientHeight = 335
  ClientWidth = 621
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object lcMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 621
    Height = 335
    TabOrder = 0
    AutoSize = True
    LayoutLookAndFeel = dxLayoutCxLookAndFeel1
    HighlightRoot = False
    object btnOK: TcxButton
      Left = 194
      Top = 131
      Width = 85
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 3
    end
    object btnCancel: TcxButton
      Left = 286
      Top = 131
      Width = 85
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 4
    end
    object seWidth: TcxSpinEdit
      Left = 71
      Top = 46
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 150
    end
    object seHeight: TcxSpinEdit
      Left = 71
      Top = 80
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 150
    end
    object txtUrl: TcxTextEdit
      Left = 71
      Top = 12
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 300
    end
    object lcMainGroup_Root: TdxLayoutGroup
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Visible = False
      LayoutLookAndFeel = dxLayoutCxLookAndFeel1
      Hidden = True
      Padding.AssignedValues = [lpavBottom]
      ShowBorder = False
      Index = -1
    end
    object lcMainGroup3: TdxLayoutGroup
      Parent = lcMainGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 2
      ShowBorder = False
      Index = 0
    end
    object lcMainSpaceItem1: TdxLayoutEmptySpaceItem
      Parent = lcMainGroup3
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object lcMainGroup14: TdxLayoutGroup
      Parent = lcMainGroup_Root
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object lcbtnOK: TdxLayoutItem
      Parent = lcMainGroup14
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Ok'
      CaptionOptions.Visible = False
      Control = btnOK
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object lcbtnCancel: TdxLayoutItem
      Parent = lcMainGroup14
      CaptionOptions.Visible = False
      Control = btnCancel
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 85
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lcWidth: TdxLayoutItem
      Parent = lcMainGroup3
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'Width:'
      Control = seWidth
      ControlOptions.AlignHorz = ahLeft
      ControlOptions.OriginalHeight = 27
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lcHeight: TdxLayoutItem
      Parent = lcMainGroup3
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'Height:'
      Control = seHeight
      ControlOptions.AlignHorz = ahLeft
      ControlOptions.OriginalHeight = 27
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object lcUrl: TdxLayoutItem
      Parent = lcMainGroup3
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'Image Url:'
      Control = txtUrl
      ControlOptions.OriginalHeight = 27
      ControlOptions.OriginalWidth = 300
      ControlOptions.ShowBorder = False
      Index = 0
    end
  end
  object dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList
    Left = 488
    Top = 358
    object dxLayoutCxLookAndFeel1: TdxLayoutCxLookAndFeel
      PixelsPerInch = 96
    end
  end
end
