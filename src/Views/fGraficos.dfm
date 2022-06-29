object frmGraficos: TfrmGraficos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gerar Gr'#225'ficos'
  ClientHeight = 571
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFooter: TPanel
    Left = 0
    Top = 502
    Width = 688
    Height = 69
    Align = alBottom
    TabOrder = 0
    object pnlFooterLeft: TPanel
      Left = 327
      Top = 1
      Width = 360
      Height = 67
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnEmail: TButton
        Left = 240
        Top = 0
        Width = 120
        Height = 67
        Align = alRight
        Caption = 'Email'
        TabOrder = 0
        OnClick = btnEmailClick
      end
      object btnImprimir: TButton
        Left = 120
        Top = 0
        Width = 120
        Height = 67
        Align = alRight
        Caption = 'Imprimir'
        TabOrder = 1
        OnClick = btnImprimirClick
      end
      object btnGerar: TButton
        Left = 0
        Top = 0
        Width = 120
        Height = 67
        Align = alRight
        Caption = 'Gerar'
        TabOrder = 2
        OnClick = btnGerarClick
      end
    end
    object pnlFooterRight: TPanel
      Left = 1
      Top = 1
      Width = 326
      Height = 67
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        326
        67)
      object SpeedButton1: TSpeedButton
        Left = 281
        Top = 5
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E882E0E882E0E
          882E0E882E0E882EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0E882E07A72F099E2E0B932E0E882EFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E882E05AF2F08
          BA29099E2E0E882EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0E882E04B62F08B82807A72F0E882EFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E882E03BB2F09
          B52605AF2F0E882EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E882E0E882E
          0E882E0E882E0E882E188D3616C44009B22504B62F0B922E0C902E0C8E2E0D8C
          2E0D892E0E882EFFFFFF2A964673E28D68E0845DDD7B53DA7349D66A41CB5D1D
          B63506B72B04B62F05AF2F07A72F099E2E0B932E0E882EFFFFFF2D97497EE597
          79D1856ECE7C64CC7459CA6B51C26046C1581EB63507B52807B62807B62A07B7
          2B099E2E0E882EFFFFFF30984B8AE7A07FE59775E38F6AE0865FDD7D58D27052
          C36143CB5F17C54103BB2F04B62F05AF2F07A72F0E882EFFFFFF0E882E0E882E
          0E882E0E882E0E882E0E882E61DE7E5DC56A4CD76D0E882E0E882E0E882E0E88
          2E0E882E0E882EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E882E6DE18869
          C77458DB770E882EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0E882E78E49275CA7E63DE800E882EFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E882E83E69B7F
          D38A6FE18A0E882EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0E882E8FE8A485E69C7BE4930E882EFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E882E0E882E0E
          882E0E882E0E882EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = SpeedButton1Click
      end
      object Label1: TLabel
        Left = 10
        Top = 42
        Width = 13
        Height = 13
        Caption = 'De'
      end
      object Label2: TLabel
        Left = 162
        Top = 42
        Width = 17
        Height = 13
        Caption = 'At'#233
      end
      object cbbConfigs: TComboBox
        Left = 8
        Top = 5
        Width = 271
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object edtDataI: TDateTimePicker
        Left = 29
        Top = 38
        Width = 120
        Height = 21
        Date = 43831.000000000000000000
        Time = 43831.000000000000000000
        TabOrder = 1
      end
      object edtDataF: TDateTimePicker
        Left = 184
        Top = 38
        Width = 120
        Height = 21
        Date = 44926.000000000000000000
        Time = 0.723849548608996000
        TabOrder = 2
      end
    end
  end
  object chart: TDBChart
    Left = 0
    Top = 0
    Width = 688
    Height = 502
    SubTitle.Text.Strings = (
      'De .. At'#233)
    Title.Text.Strings = (
      'Titulo')
    Legend.Symbol.Gradient.EndColor = 10708548
    View3D = False
    Align = alClient
    TabOrder = 1
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
  end
  object ActionList1: TActionList
    Left = 616
    Top = 448
    object SendMail: TSendMail
      Category = 'Internet'
      Caption = '&Send Mail...'
      Hint = 'Send email'
    end
  end
end
