object fmSprCounts: TfmSprCounts
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1089#1095#1077#1090#1086#1074
  ClientHeight = 331
  ClientWidth = 620
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
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 620
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
  object grSprCount: TcxGrid
    Left = 0
    Top = 25
    Width = 620
    Height = 306
    Align = alClient
    TabOrder = 1
    object grSprCountDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = oradssprcount
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      object grSprCountDBTableView1Column1: TcxGridDBColumn
        Caption = #1042#1083#1072#1076#1077#1083#1077#1094
        DataBinding.FieldName = 'userName'
        Width = 139
      end
      object grSprCountDBTableView1Column2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'name'
        Width = 163
      end
      object grSprCountDBTableView1Column3: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'nameValut'
      end
      object grSprCountDBTableView1Column4: TcxGridDBColumn
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        DataBinding.FieldName = 'comm'
        Width = 160
      end
    end
    object grSprCountLevel1: TcxGridLevel
      GridView = grSprCountDBTableView1
    end
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = actIns
          end
          item
            Action = actEDit
          end
          item
            Action = actDel
          end
          item
            Action = actREfresh
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 368
    Top = 96
    StyleName = 'Platform Default'
    object actIns: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = actInsExecute
    end
    object actEDit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnExecute = actEDitExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = actDelExecute
    end
    object actREfresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnExecute = actREfreshExecute
    end
  end
  object oqSprCount: TOraQuery
    Session = dmOra.OraSession
    SQL.Strings = (
      'select * from hbuh.v_spr_valut')
    Left = 360
    Top = 24
  end
  object oradssprcount: TOraDataSource
    DataSet = oqSprCount
    Left = 464
    Top = 16
  end
  object OraSP: TOraStoredProc
    Session = dmOra.OraSession
    Left = 464
    Top = 104
  end
end
