object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1059#1095#1077#1090' '#1092#1080#1085#1072#1085#1089#1086#1074
  ClientHeight = 357
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 534
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
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = actExit
              end>
            Caption = #1060#1072#1081#1083
          end
          item
            Items = <
              item
                Action = actOperatioin
              end>
            Caption = #1054#1087#1077#1088#1072#1094#1080#1080
          end
          item
            Items = <
              item
                Action = actReportMonth
              end>
            Caption = #1054#1090#1095#1077#1090#1099
          end
          item
            Items = <
              item
                Action = actKursValut
              end
              item
                Action = actSprCounts
              end
              item
                Action = actSprValut
              end
              item
                Action = actSprKateg
              end>
            Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
          end
          item
            Items = <
              item
                Action = actUser
              end
              item
                Caption = '-'
              end
              item
                Action = actOptions
              end>
            Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 56
    Top = 72
    StyleName = 'Platform Default'
    object actExit: TAction
      Category = #1060#1072#1081#1083
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
    object actOperatioin: TAction
      Category = #1054#1087#1077#1088#1072#1094#1080#1080
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080
    end
    object actReportMonth: TAction
      Category = #1054#1090#1095#1077#1090#1099
      Caption = #1054#1090#1095#1077#1090#1099' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084
    end
    object actKursValut: TAction
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Caption = #1050#1091#1088#1089' '#1074#1072#1083#1102#1090
    end
    object actSprCounts: TAction
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1089#1095#1077#1090#1086#1074
    end
    object actSprValut: TAction
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1074#1072#1083#1102#1090
      OnExecute = actSprValutExecute
    end
    object actSprKateg: TAction
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1082#1072#1090#1077#1075#1086#1088#1080#1081
    end
    object actOptions: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    end
    object actUser: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
    end
  end
end
