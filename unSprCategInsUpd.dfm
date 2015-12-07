object fmSprCategInsUpd: TfmSprCategInsUpd
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'fmSprCategInsUpd'
  ClientHeight = 286
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object peParentCateg: TcxPopupEdit
    Left = 168
    Top = 49
    Properties.PopupClientEdge = True
    Properties.PopupControl = dxDBTreeView1
    Properties.PopupHeight = 300
    Properties.PopupMinHeight = 300
    Properties.PopupMinWidth = 233
    Properties.PopupSysPanelStyle = True
    TabOrder = 0
    Text = 'cxPENameCateg'
    Width = 233
  end
  object dxDBTreeView1: TdxDBTreeView
    Left = 391
    Top = 21
    Width = 48
    Height = 44
    ShowNodeHint = True
    DataSource = oraDSFillParent
    KeyField = 'ID'
    ListField = 'NAME'
    ParentField = 'ID_PARENT'
    RootValue = Null
    SeparatedSt = ' - '
    RaiseOnError = True
    Indent = 19
    OnChanging = dxDBTreeView1Changing
    OnChange = dxDBTreeView1Change
    ParentColor = False
    Options = [trDBCanDelete, trDBConfirmDelete, trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
    SelectedIndex = -1
    TabOrder = 1
    Visible = False
    OnDblClick = dxDBTreeView1DblClick
  end
  object cxLabel1: TcxLabel
    Left = 24
    Top = 40
    Caption = #1056#1086#1076#1080#1090#1077#1083#1100#1089#1082#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
    Properties.WordWrap = True
    Width = 79
  end
  object edNameCateg: TcxTextEdit
    Left = 168
    Top = 88
    TabOrder = 3
    Text = 'edNameCateg'
    Width = 121
  end
  object cxLabel2: TcxLabel
    Left = 24
    Top = 89
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
  end
  object rgTypeDvig: TcxRadioGroup
    Left = 24
    Top = 128
    Caption = #1058#1080#1087' '#1076#1074#1080#1078#1077#1085#1080#1103
    Properties.Items = <
      item
        Caption = #1044#1086#1093#1086#1076
        Value = 0
      end
      item
        Caption = #1056#1072#1089#1093#1086#1076
        Value = 1
      end>
    ItemIndex = 1
    TabOrder = 5
    Height = 65
    Width = 126
  end
  object bnCancel: TcxButton
    Left = 232
    Top = 232
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 6
  end
  object bnOk: TcxButton
    Left = 96
    Top = 232
    Width = 75
    Height = 25
    Caption = #1054#1050
    ModalResult = 1
    TabOrder = 7
    OnClick = bnOkClick
  end
  object oraDSFillParent: TOraDataSource
    AutoEdit = False
    DataSet = oraQFillParent
    Left = 408
    Top = 88
  end
  object oraQFillParent: TOraQuery
    Session = dmOra.OraSession
    SQL.Strings = (
      'select * from hbuh.v_spr_category')
    Left = 392
    Top = 150
  end
  object oraSPSave: TOraStoredProc
    Left = 384
    Top = 224
  end
  object oraDSFill: TOraDataSource
    AutoEdit = False
    DataSet = oraQFill
    Left = 336
    Top = 72
  end
  object oraQFill: TOraQuery
    Session = dmOra.OraSession
    SQL.Strings = (
      'select * from hbuh.v_spr_category')
    Left = 320
    Top = 134
  end
end
