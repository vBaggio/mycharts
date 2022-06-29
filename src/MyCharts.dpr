program MyCharts;

uses
  Vcl.Forms,
  fMain in 'Views\fMain.pas' {frmMain},
  uConnection in 'DAO\uConnection.pas',
  uConfigGrafico in 'Models\uConfigGrafico.pas',
  fGraficos in 'Views\fGraficos.pas' {frmGraficos},
  fConfigs in 'Views\fConfigs.pas' {frmConfigs},
  uGraficosController in 'Controllers\uGraficosController.pas',
  uDbSeeder in 'DAO\uDbSeeder.pas',
  uConfigGraficoDAO in 'DAO\uConfigGraficoDAO.pas',
  fConfigGrafico in 'Views\fConfigGrafico.pas' {frmConfigGrafico},
  uCadConfigController in 'Controllers\uCadConfigController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  TVerificarTabelas.VerificarTabelas;

  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmConfigGrafico, frmConfigGrafico);
  Application.Run;
end.
