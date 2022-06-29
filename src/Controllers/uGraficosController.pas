unit uGraficosController;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, VCL.Forms,
  System.Generics.Collections, System.DateUtils, System.IOUtils,
  VCLTee.DBChart, VClTee.TeePrevi,VCLTee.TeeEdiGene, VCLTee.EditChar, Vcl.ExtActns,
  uConnection, uConfigGrafico, uConfigGraficoDAO;

type TGraficosController = class
  private
    FCgDAO: TConfigGraficoDAO;
    FConfigs: TListaConfigGrafico;

    function carregarConfigs: boolean;

  public
    constructor Create;
    destructor Destroy; override;
    function atualizarGridConfigs(var AMTb: TFDMemTable): boolean;
    function atualizarComboConfigs(ACbb: TComboBox): boolean;
    function renderizarGrafico(var AChart: TDBChart; var AMsg: string; AIdxConfig: integer; ADataI, ADataF: TDateTime): boolean;
    procedure imprimirGrafico(var AChart: TDBChart);
    function emailGrafico(var AChart: TDBChart; var ASendEmail:TSendMail; ADest: string): boolean;
    function excluirConfig(AId: integer): boolean;
end;

implementation

{ TGraficosController }

constructor TGraficosController.Create;
begin
  FCgDAO := TConfigGraficoDAO.Create;
  FConfigs := TListaConfigGrafico.Create;
end;

destructor TGraficosController.Destroy;
begin
  FreeAndNil(FConfigs);
  FreeAndNil(FcgDAO);
  inherited;
end;

function TGraficosController.atualizarGridConfigs(var AMTb: TFDMemTable): boolean;
var AuxConfig: TConfigGrafico;
begin
  try

    Result := Self.carregarConfigs;

    AMTb.DisableControls;

    if not AMTb.Active then
      AMTb.Open;

    AMtb.EmptyDataSet;

    for AuxConfig in FConfigs.Itens do
    begin
      with AMTb, AuxConfig do
      begin
        Append;
          FieldByName('Id').AsInteger       := Id;
          FieldByName('Descricao').AsString := Descricao;
        Post;
      end;
    end;

    AMTb.EnableControls;

    AMtb.First;

  except
    Result := False;
  end;
end;

function TGraficosController.carregarConfigs: boolean;
var AuxConfig: TConfigGrafico;
begin
  FConfigs.Itens.Clear;

  Result := FCgDAO.LoadAll(FConfigs);
end;

function TGraficosController.emailGrafico(var AChart: TDBChart; var ASendEmail:TSendMail; ADest: string): boolean;
var path: string;
begin
  try
    path := ExtractFilePath(Application.ExeName) + 'temp\';
    if not TDirectory.Exists(path) then
      TDirectory.CreateDirectory(path);

    path := path + 'grafico.jpeg';
    AChart.SaveToBitmapFile(path);

    ASendEMail.Attachments.Clear;
    ASendEmail.Attachments.Add(path);
    Result := ASendEmail.Execute;
  except
    Result := false;
  end;
end;

function TGraficosController.excluirConfig(AId: integer): boolean;
begin
  Result := FCgDAO.Delete(AId);
end;

procedure TGraficosController.imprimirGrafico(var AChart: TDBChart);
begin
  ChartPreview(nil, AChart);
end;

function TGraficosController.renderizarGrafico(var AChart: TDBChart; var AMsg: string;
  AIdxConfig: integer; ADataI, ADataF: TDateTime): boolean;
var
  Config: TConfigGrafico;
begin
  Result := False;

  if (AIdxConfig < 0) or ((AIdxConfig + 1) > Fconfigs.Itens.Count) then
  begin
    AMsg := 'Configuração de gráfico inválida.';
    Exit;
  end;

  if ADataF < ADataI then
  begin
    AMsg := 'Data final não pode ser menor que a inicial.';
    Exit;
  end;

  Config := FConfigs.Itens[AIdxConfig];

  Result := FCgDao.renderizarGrafico(AChart, Config, aDataI, ADataF);
end;

function TGraficosController.atualizarComboConfigs(ACbb: TComboBox): boolean;
var Config: TConfigGrafico;
begin
  ACbb.Clear;

  Result := carregarConfigs;

  if not Result then
    Exit;

  for Config in FConfigs.Itens do
  begin
    ACbb.Items.Add(Config.Descricao);
  end;

end;

end.
