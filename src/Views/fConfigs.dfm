object frmConfigs: TfrmConfigs
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configurar Gr'#225'ficos'
  ClientHeight = 323
  ClientWidth = 443
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
  object dbgTabela: TDBGrid
    Left = 0
    Top = 0
    Width = 443
    Height = 288
    Align = alClient
    DataSource = dsConfigs
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 368
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 443
    Height = 35
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      443
      35)
    object btnEdit: TButton
      Left = 221
      Top = 6
      Width = 100
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = 'Editar'
      TabOrder = 0
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 115
      Top = 6
      Width = 100
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnNew: TButton
      Left = 327
      Top = 6
      Width = 100
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = 'Incluir'
      TabOrder = 2
      OnClick = btnNewClick
    end
  end
  object dsConfigs: TDataSource
    DataSet = mtbConfigs
    Left = 376
    Top = 72
  end
  object mtbConfigs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 376
    Top = 24
    object mtbConfigsId: TIntegerField
      FieldName = 'Id'
    end
    object mtbConfigsDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
  end
end
