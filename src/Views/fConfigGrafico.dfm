object frmConfigGrafico: TfrmConfigGrafico
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configurar Gr'#225'fico'
  ClientHeight = 252
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 13
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object GroupBox1: TGroupBox
    Left = 241
    Top = 67
    Width = 233
    Height = 123
    Caption = 'Eixo Y'
    TabOrder = 0
    object Label3: TLabel
      Left = 10
      Top = 73
      Width = 39
      Height = 13
      Caption = 'Coluna2'
    end
    object Label4: TLabel
      Left = 10
      Top = 21
      Width = 42
      Height = 13
      Caption = 'Coluna 1'
    end
    object cbbY1: TComboBox
      Left = 10
      Top = 38
      Width = 212
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object cbbY2: TComboBox
      Left = 10
      Top = 89
      Width = 212
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 2
    Top = 69
    Width = 233
    Height = 58
    Caption = 'Tipo do Gr'#225'fico'
    TabOrder = 1
    object cbbTipo: TComboBox
      Left = 10
      Top = 21
      Width = 212
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbbTipoChange
      Items.Strings = (
        ''
        'Linhas'
        'Coluns'
        'Pizza')
    end
  end
  object gbEixoX: TGroupBox
    Left = 2
    Top = 133
    Width = 233
    Height = 55
    Caption = 'Eixo X'
    TabOrder = 2
    object cbbX1: TComboBox
      Left = 10
      Top = 21
      Width = 212
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        ''
        'Data Emiss'#227'o'
        'Data Vencimento'
        'Cidade'
        'Nome')
    end
  end
  object btnCancelar: TButton
    Left = 316
    Top = 215
    Width = 74
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object btnGravar: TButton
    Left = 396
    Top = 215
    Width = 78
    Height = 25
    Caption = 'Gravar'
    TabOrder = 4
    OnClick = btnGravarClick
  end
  object edtDesc: TEdit
    Left = 12
    Top = 32
    Width = 451
    Height = 21
    TabOrder = 5
    Text = 'edtDesc'
  end
end
