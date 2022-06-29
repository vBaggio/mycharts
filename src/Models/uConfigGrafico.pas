unit uConfigGrafico;

interface

uses
  System.Generics.Collections, System.SysUtils;

type
  TTipoGrafico = (tgVazio = 0, tgLinhas = 1, tgColunas = 2, tgPizza = 3);

  TTipoCampo   = (tcVazio = 0, tcCusto = 1, tcVenda = 2, tcCidade = 3, tcUF = 4, tcQuantidade = 5,
                  tcEmisDia = 6, tcEmisSemana = 7, tcEmisMes = 8, tcEmisAno = 9);

  TArrayTipoCampo = array of TTipoCampo;

  TConvTipo = class
    public
      class function CampoFromStr(AStr: string): TTipoCampo;
      class function CampoToStr(ATipo: TTipoCampo): string;
      class function GraficoFromStr(AStr: string): TTipoGrafico;
      class function GraficoToStr(ATipo: TTipoGrafico): string;
  end;


  TConfigGrafico = class
    private
      FId: integer;
      FTipoGrafico: TTipoGrafico;
      FDescricao: string;
      FCampoX:  TTipoCampo;
      FCampoY1: TTipoCampo;
      FCampoY2: TTipoCampo;
      FCamposPermitidosX: TArrayTipoCampo;
      FCamposPermitidosY: TArrayTipoCampo;
      procedure setTipoGrafico(ATipoGrafico: TTipoGrafico);

    public
      constructor Create(AId: integer = 0);
      destructor Destroy; override;
      property Id: integer read FId;
      property TipoGrafico: TTipoGrafico read FTipoGrafico write setTipoGrafico;
      property Descricao: string read FDescricao write FDescricao;
      property CampoX: TTipoCampo read FCampoX write FCampoX;
      property CampoY1: TTipoCampo read FCampoY1 write FCampoY1;
      property CampoY2: TTipoCampo read FCampoY2 write FCampoY2;
      property CamposPermitidosX: TArrayTipoCampo read FCamposPermitidosX;
      property CamposPermitidosY: TArrayTipoCampo read FCamposPermitidosY;
  end;

  TListaConfigGrafico = class
    public
      Itens: TObjectList<TConfigGrafico>;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

{ TConfigGrafico }

constructor TConfigGrafico.Create(AId: integer);
begin
  FId := AId;
  FCampoX  := tcVazio;
  FCampoY1 := tcVazio;
  FCampoY2 := tcVazio;

  setTipoGrafico(tgVazio);
end;

destructor TConfigGrafico.Destroy;
begin
  inherited;
end;

procedure TConfigGrafico.setTipoGrafico(ATipoGrafico: TTipoGrafico);
begin
  FTipoGrafico := ATipoGrafico;

  case FTipoGrafico of
    tgVazio:
    begin
      setLength(FCamposPermitidosX, 0);
      setLength(FCamposPermitidosY, 0);
    end;

    tgLinhas:
    begin
      setLength(FCamposPermitidosX, 4);
      FCamposPermitidosX[0] := tcEmisDia;
      FCamposPermitidosX[1] := tcEmisSemana;
      FCamposPermitidosX[2] := tcEmisMes;
      FCamposPermitidosX[3] := tcEmisAno;

      setLength(FCamposPermitidosY, 3);
      FCamposPermitidosY[0] := tcCusto;
      FCamposPermitidosY[1] := tcVenda;
      FCamposPermitidosY[2] := tcQuantidade;
    end;

    tgColunas:
    begin
      setLength(FCamposPermitidosX, 6);
      FCamposPermitidosX[0] := tcEmisDia;
      FCamposPermitidosX[1] := tcEmisSemana;
      FCamposPermitidosX[2] := tcEmisMes;
      FCamposPermitidosX[3] := tcEmisAno;
      FCamposPermitidosX[4] := tcCidade;
      FCamposPermitidosX[5] := tcUF;

      setLength(FCamposPermitidosY, 3);
      FCamposPermitidosY[0] := tcCusto;
      FCamposPermitidosY[1] := tcVenda;
      FCamposPermitidosY[2] := tcQuantidade;
    end;

    tgPizza:
    begin
      setLength(FCamposPermitidosX, 6);
      FCamposPermitidosX[0] := tcEmisDia;
      FCamposPermitidosX[1] := tcEmisSemana;
      FCamposPermitidosX[2] := tcEmisMes;
      FCamposPermitidosX[3] := tcEmisAno;
      FCamposPermitidosX[4] := tcCidade;
      FCamposPermitidosX[5] := tcUF;

      setLength(FCamposPermitidosY, 3);
      FCamposPermitidosY[0] := tcCusto;
      FCamposPermitidosY[1] := tcVenda;
      FCamposPermitidosY[2] := tcQuantidade;
    end;
  end;

  FCampoX  := tcVazio;
  FCampoY1 := tcVazio;
  FCampoY2 := tcVazio;

end;

{ TListaConfigGrafico }

constructor TListaConfigGrafico.Create;
begin
  Itens := TObjectList<TConfigGrafico>.Create;
end;

destructor TListaConfigGrafico.Destroy;
begin
  FreeAndNil(Itens);
  inherited;
end;

{ TConvTipo }

class function TConvTipo.CampoFromStr(AStr: string): TTipoCampo;
begin
  Result := tcVazio;
  if AStr = ''            then Result:= tcVazio;
  if AStr = 'Custo'       then Result:= tcCusto;
  if AStr = 'Venda'       then Result:= tcVenda;
  if AStr = 'Cidade'      then Result:= tcCidade;
  if AStr = 'UF'          then Result:= tcUF;
  if AStr = 'Quantidade'  then Result:= tcQuantidade;
  if AStr = 'Emis Dia'    then Result:= tcEmisDia;
  if AStr = 'Emis Semana' then Result:= tcEmisSemana;
  if AStr = 'Emis Mes'    then Result:= tcEmisMes;
  if AStr = 'Emis Ano'    then Result:= tcEmisAno;
end;

class function TConvTipo.CampoToStr(ATipo: TTipoCampo): string;
begin
  case ATipo of
    tcVazio:      Result := '';
    tcCusto:      Result := 'Custo';
    tcVenda:      Result := 'Venda';
    tcCidade:     Result := 'Cidade';
    tcUF:         Result := 'UF';
    tcQuantidade: Result := 'Quantidade';
    tcEmisDia:    Result := 'Emis Dia';
    tcEmisSemana: Result := 'Emis Semana';
    tcEmisMes:    Result := 'Emis Mes';
    tcEmisAno:    Result := 'Emis Ano';
  end;
end;

class function TConvTipo.GraficoFromStr(AStr: string): TTipoGrafico;
begin
  Result := tgVazio;
  if AStr = ''        then Result:= tgVazio;
  if AStr = 'Linhas'  then Result:= tgLinhas;
  if AStr = 'Colunas' then Result:= tgColunas;
  if AStr = 'Pizza'   then Result:= tgPizza;
end;

class function TConvTipo.GraficoToStr(ATipo: TTipoGrafico): string;
begin
  case ATipo of
    tgVazio:   Result := '';
    tgLinhas:  Result := 'Linhas';
    tgColunas: Result := 'Colunas';
    tgPizza:   Result := 'Pizza';
  end;
end;

end.
