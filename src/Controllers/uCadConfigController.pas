unit uCadConfigController;

interface

uses
  System.SysUtils, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  uConfigGrafico, uConfigGraficoDAO;

type TCombo = (tcG, tcX, tcY1, tcY2);

type TCadConfigController = class
  private
    FConfig: TConfigGrafico;
    FCgDAO: TConfigGraficoDAO;
  public
    constructor Create(AId: integer = 0);
    destructor Destroy; override;

    procedure atualizarCombo(var ACbb:TComboBox; Tipo:TCombo);
    function getDesc: string;
    function setarDesc(ADesc: string): boolean;
    function setarTipo(var ACbb:TComboBox): boolean;
    function setarCampo(var ACbb:TComboBox; Tipo:TCombo): boolean;
    function gravarConfig(Amsg: string): boolean;
end;

implementation

{ TCadConfigController }

procedure TCadConfigController.atualizarCombo(var ACbb: TComboBox; Tipo: TCombo);
var i: integer;
begin
  ACbb.Items.Clear;

  ACbb.ItemIndex := -1;

  case Tipo of
    tcG:
    begin
      ACbb.Items.Add(TConvTipo.GraficoToStr(tgLinhas));
      ACbb.Items.Add(TConvTipo.GraficoToStr(tgColunas));
      ACbb.Items.Add(TConvTipo.GraficoToStr(tgPizza));

      ACbb.ItemIndex := Ord(FConfig.TipoGrafico) - 1;
    end;

    tcX:
    begin
      for i := Low(FConfig.CamposPermitidosX) to High(FConfig.CamposPermitidosX) do
      begin
        ACbb.Items.Add(TConvTipo.CampoToStr(FConfig.CamposPermitidosX[i]));

        if FConfig.CampoX = FConfig.CamposPermitidosX[i] then
          ACbb.ItemIndex := i;
      end;
    end;

    tcY1:
    begin
      for i := Low(FConfig.CamposPermitidosY) to High(FConfig.CamposPermitidosY) do
      begin
        ACbb.Items.Add(TConvTipo.CampoToStr(FConfig.CamposPermitidosY[i]));

        if FConfig.CampoY1 = FConfig.CamposPermitidosY[i] then
          ACbb.ItemIndex := i;
      end;
    end;

    tcY2:
    begin
      ACbb.Enabled := FConfig.TipoGrafico <> tgPizza;

      ACbb.Items.Add(TConvTipo.CampoToStr(tcVazio));
      for i := Low(FConfig.CamposPermitidosY) to High(FConfig.CamposPermitidosY) do
      begin
        ACbb.Items.Add(TConvTipo.CampoToStr(FConfig.CamposPermitidosY[i]));

        if FConfig.CampoY2 = FConfig.CamposPermitidosY[i] then
          ACbb.ItemIndex := i+1;
      end;


      ACbb.Enabled := FConfig.TipoGrafico <> tgPizza;
    end;
  end;
end;

constructor TCadConfigController.Create(AId: integer = 0);
begin
  FCgDao := TConfigGraficoDAO.Create;
  FConfig :=  TConfigGrafico.Create(AId);

  if AId > 0 then
  begin
    if not FCgDao.Load(FConfig) then
      raise Exception.Create('Error ao carregar config');
  end;
end;

destructor TCadConfigController.Destroy;
begin
  FreeAndNil(FConfig);
  FreeAndNil(FCgDAO);
  inherited;
end;

function TCadConfigController.getDesc: string;
begin
  Result := FConfig.Descricao;
end;


function TCadConfigController.setarCampo(var ACbb:TComboBox; Tipo:TCombo): boolean;
begin
  case Tipo of
    tcX:  FConfig.CampoX  := TConvTipo.CampoFromStr(ACbb.Text);
    tcY1: FConfig.CampoY1 := TConvTipo.CampoFromStr(ACbb.Text);
    tcY2: FConfig.CampoY2 := TConvTipo.CampoFromStr(ACbb.Text);
  end;

  Result := True;
end;

function TCadConfigController.setarDesc(ADesc: string): boolean;
begin
   FConfig.Descricao := ADesc;
   Result := True;
end;

function TCadConfigController.setarTipo(var ACbb: TComboBox): boolean;
begin
  Result :=  not (ACbb.Text = TConvTipo.GraficoToStr(FConfig.TipoGrafico));

  if Result then
    FConfig.TipoGrafico := TConvTipo.GraficoFromStr(ACbb.Text);
end;

function TCadConfigController.gravarConfig(Amsg: string): boolean;
begin
  try
    Result := false;
    Amsg := 'Erro ao gravar';

    if not (FConfig.Descricao > '') then
    begin
      Amsg := 'derscriçao inválida';
      Exit;
    end;

    //validacoes

    Result := FCgDAO.Save(FConfig);

    if Result then
      Amsg := '';

  except
    Result := false;
  end;

end;

end.
