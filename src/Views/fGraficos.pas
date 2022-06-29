unit fGraficos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, Vcl.StdCtrls,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DB,
  VCLTee.DBChart, VClTee.TeePrevi,VCLTee.TeeEdiGene, VCLTee.EditChar, VCLTee.TeCanvas,

  uGraficosController, Vcl.Buttons, Vcl.ComCtrls, System.Actions, Vcl.ActnList,
  Vcl.ExtActns;

type
  TfrmGraficos = class(TForm)
    pnlFooter: TPanel;
    pnlFooterLeft: TPanel;
    pnlFooterRight: TPanel;
    btnEmail: TButton;
    btnImprimir: TButton;
    btnGerar: TButton;
    cbbConfigs: TComboBox;
    chart: TDBChart;
    SpeedButton1: TSpeedButton;
    edtDataI: TDateTimePicker;
    edtDataF: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    ActionList1: TActionList;
    SendMail: TSendMail;
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    Controller: TGraficosController;
  public
    { Public declarations }
  end;

var
  frmGraficos: TfrmGraficos;
  procedure call_graficos;

implementation

{$R *.dfm}

uses fConfigs;

procedure call_graficos;
begin
  try
    frmGraficos := TfrmGraficos.Create(nil);
    frmGraficos.ShowModal;

  finally
    FreeAndNil(frmGraficos);
  end;
end;

procedure TfrmGraficos.btnEmailClick(Sender: TObject);
begin
  if not Controller.emailGrafico(chart, SendMail, '') then
    ShowMessage('Erro ao enviar');

end;

procedure TfrmGraficos.btnGerarClick(Sender: TObject);
var Query: TFDQuery;
    serie: TLineSeries; serie2: TBarSeries; serie3:TPieSeries;
    i: integer;
    msg: string;
begin
  if not Controller.renderizarGrafico(chart, msg, cbbConfigs.ItemIndex, edtDataI.DateTime, edtDataF.DateTime) then
  begin
    ShowMessage(msg);
  end;
end;

procedure TfrmGraficos.btnImprimirClick(Sender: TObject);
begin
  Controller.imprimirGrafico(chart);
end;

procedure TfrmGraficos.FormCreate(Sender: TObject);
begin
  Controller := TGraficosController.Create;
end;

procedure TfrmGraficos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmGraficos.FormShow(Sender: TObject);
begin
  Controller.atualizarComboConfigs(cbbConfigs);
end;

procedure TfrmGraficos.SpeedButton1Click(Sender: TObject);
begin
  call_configs;
  Controller.atualizarComboConfigs(cbbConfigs);
end;

end.
