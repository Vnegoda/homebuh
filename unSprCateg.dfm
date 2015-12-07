object fmSprCateg: TfmSprCateg
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1082#1072#1090#1077#1075#1086#1088#1080#1081
  ClientHeight = 359
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 418
    Height = 25
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
  end
  object dxDBTreeCateg: TdxDBTreeView
    Left = 0
    Top = 25
    Width = 418
    Height = 334
    ShowNodeHint = True
    DataSource = OraDSTree
    DisplayField = 'NAME'
    KeyField = 'ID'
    ListField = 'NAME'
    ParentField = 'ID_PARENT'
    RootValue = 0.000000000000000000
    SeparatedSt = ' - '
    StateIndexField = 'ID'
    RaiseOnError = True
    ReadOnly = True
    Indent = 19
    Align = alClient
    ParentColor = False
    Options = [trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
    SelectedIndex = -1
    TabOrder = 1
    PopupMenu = PopupMenu1
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = actREfresh
          end
          item
            Action = actEdit
          end
          item
            Action = actAdd
          end
          item
            Action = actDel
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 368
    Top = 80
    StyleName = 'Platform Default'
    object actREfresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnExecute = actREfreshExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnExecute = actEditExecute
    end
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = actAddExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = actDelExecute
    end
  end
  object oraQTree: TOraQuery
    Session = dmOra.OraSession
    SQL.Strings = (
      'select * from hbuh.v_spr_category')
    Left = 200
    Top = 192
  end
  object OraDSTree: TOraDataSource
    AutoEdit = False
    DataSet = oraQTree
    Left = 264
    Top = 144
  end
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 80
    object N2: TMenuItem
      Action = actAdd
    end
    object N1: TMenuItem
      Action = actEdit
    end
    object N3: TMenuItem
      Action = actDel
    end
  end
  object oraSPDel: TOraStoredProc
    Left = 344
    Top = 256
  end
end
