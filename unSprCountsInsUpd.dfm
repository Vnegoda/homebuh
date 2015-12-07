object fmSprCountsInsUpd: TfmSprCountsInsUpd
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1089#1095#1077#1090#1086#1074
  ClientHeight = 273
  ClientWidth = 447
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
  object cbUserName: TcxLookupComboBox
    Left = 125
    Top = 26
    Properties.KeyFieldNames = 'id'
    Properties.ListColumns = <
      item
        Caption = #1042#1083#1072#1076#1077#1083#1077#1094' '#1089#1095#1077#1090#1072
        FieldName = 'name'
      end>
    Properties.ListSource = OraDSUser
    TabOrder = 0
    Width = 296
  end
  object cbValuta: TcxLookupComboBox
    Left = 125
    Top = 144
    Properties.KeyFieldNames = 'id'
    Properties.ListColumns = <
      item
        Caption = #1042#1072#1083#1102#1090#1072
        FieldName = 'full_name'
      end>
    Properties.ListSource = OraDSValuta
    TabOrder = 1
    Width = 296
  end
  object edComment: TcxTextEdit
    Left = 125
    Top = 104
    TabOrder = 2
    Text = 'edComment'
    Width = 296
  end
  object edName: TcxTextEdit
    Left = 125
    Top = 65
    TabOrder = 3
    Text = 'edName'
    Width = 296
  end
  object cxLabel1: TcxLabel
    Left = 23
    Top = 27
    Caption = #1042#1083#1072#1076#1077#1083#1077#1094' '#1089#1095#1077#1090#1072
  end
  object cxLabel2: TcxLabel
    Left = 23
    Top = 66
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object cxLabel3: TcxLabel
    Left = 23
    Top = 105
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
  end
  object cxLabel4: TcxLabel
    Left = 23
    Top = 145
    Caption = #1042#1072#1083#1102#1090#1072
  end
  object bnSave: TcxButton
    Left = 112
    Top = 224
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ModalResult = 1
    TabOrder = 8
    OnClick = bnSaveClick
  end
  object bnCancel: TcxButton
    Left = 280
    Top = 224
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 9
  end
  object OraQUser: TOraQuery
    Left = 392
    Top = 65528
  end
  object OraDSUser: TOraDataSource
    DataSet = OraQUser
    Left = 328
  end
  object OraQValuta: TOraQuery
    Left = 384
    Top = 168
  end
  object OraDSValuta: TOraDataSource
    DataSet = OraQValuta
    Left = 336
    Top = 176
  end
  object OraSP: TOraStoredProc
    Session = dmOra.OraSession
    Left = 24
    Top = 200
  end
  object oraQFill: TOraQuery
    Session = dmOra.OraSession
    SQL.Strings = (
      'select * from hbuh.v_spr_count where id=:v_id')
    Left = 80
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'v_id'
        Value = 8
      end>
  end
  object OraDSFill: TOraDataSource
    AutoEdit = False
    DataSet = oraQFill
    Left = 136
    Top = 176
  end
end
