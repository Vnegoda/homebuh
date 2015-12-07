object fmInsUpdSprValut: TfmInsUpdSprValut
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072' '#1074#1072#1083#1102#1090
  ClientHeight = 249
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object cxLabel1: TcxLabel
    Left = 40
    Top = 24
    Caption = #1050#1086#1076
  end
  object cxLabel2: TcxLabel
    Left = 40
    Top = 73
    Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
    Properties.WordWrap = True
    Width = 74
  end
  object cxLabel3: TcxLabel
    Left = 40
    Top = 136
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object cxedAbbr: TcxTextEdit
    Left = 120
    Top = 23
    TabOrder = 3
    Text = 'cxedAbbr'
    OnKeyPress = cxedAbbrKeyPress
    Width = 65
  end
  object cxedShortName: TcxTextEdit
    Left = 120
    Top = 78
    TabOrder = 4
    Text = 'cxedShortName'
    OnKeyPress = cxedShortNameKeyPress
    Width = 353
  end
  object cxedName: TcxTextEdit
    Left = 120
    Top = 134
    TabOrder = 5
    Text = 'cxedName'
    OnKeyPress = cxedNameKeyPress
    Width = 353
  end
  object bnCancel: TcxButton
    Left = 292
    Top = 200
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 6
  end
  object bnSave: TcxButton
    Left = 172
    Top = 200
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ModalResult = 1
    TabOrder = 7
    OnClick = bnSaveClick
  end
  object oraQFill: TOraQuery
    Session = dmOra.OraSession
    Left = 320
    Top = 16
  end
  object OraSP: TOraStoredProc
    Session = dmOra.OraSession
    Left = 392
    Top = 32
  end
end
