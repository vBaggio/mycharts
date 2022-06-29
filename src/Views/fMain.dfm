object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'MyCharts'
  ClientHeight = 399
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object menuMain: TMainMenu
    Left = 16
    Top = 8
    object Grficos2: TMenuItem
      Caption = 'Gr'#225'ficos'
      object GerarGrficos1: TMenuItem
        Caption = 'Gerar Gr'#225'ficos'
        OnClick = GerarGrficos1Click
      end
    end
    object Grficos1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object Configuraes1: TMenuItem
        Caption = 'Configurar Gr'#225'ficos'
        OnClick = Configuraes1Click
      end
    end
  end
  object driverMySQL: TFDPhysMySQLDriverLink
    VendorLib = 'C:\ProjetosDelphi\MyCharts\bin\libmySQL.dll'
    Left = 24
    Top = 344
  end
end
