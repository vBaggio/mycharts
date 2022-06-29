unit uConfigGraficoDAO;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  System.Generics.Collections, System.DateUtils, VCLTee.DBChart, vcl.Dialogs,
  VCLTee.Chart, VCLTee.Series,
  uConnection, uConfigGrafico;

  type TConfigGraficoDAO = class
    public
      function Save(AConfig: TConfigGrafico): boolean;
      function Load(AConfig: TConfigGrafico): boolean;
      function LoadAll(ALista: TListaConfigGrafico):boolean;
      function Delete(AId: integer): boolean;
      function renderizarGrafico(var AChart: TDBChart; AConfig: TConfigGrafico; ADataI, ADataF: TDateTime): boolean;
  end;

implementation

{ TConfigGraficoDAO }

function TConfigGraficoDAO.Delete(AId: integer): boolean;
begin
  try
    TMyConnection.getConn.ExecSQL('DELETE FROM config_graficos WHERE idconfiggraficos = ' + intToStr(AId));

    Result := True;
  except
    Result := False;
  end;
end;

function TConfigGraficoDAO.Load(AConfig: TConfigGrafico): boolean;
var Query: TFDQuery;
begin
  Result := False;

  try
    Query := TMyConnection.getQuery;

    with Query, AConfig do
    begin
      SQL.Add('SELECT * FROM config_graficos WHERE idconfiggraficos = ' + intToStr(Id));
      Open;

      if not (RecordCount > 0) then
        Exit;

      TipoGrafico := TTipoGrafico(FieldByName('tipografico').AsInteger);
      Descricao   := FieldByName('descricao').AsString;
      CampoX      := TTipoCampo(FieldByName('campox').AsInteger);
      CampoY1     := TTipoCampo(FieldByName('campoy1').AsInteger);
      CampoY2     := TTipoCampo(FieldByName('campoy2').AsInteger);

      Result := True;

      Close;
    end;

  finally
    FreeAndNil(Query);
  end;

end;

function TConfigGraficoDAO.LoadAll(ALista: TListaConfigGrafico):boolean;
var Query: TFDQuery;
    AuxConfig: TConfigGrafico;
begin

  try
    Query := TMyConnection.getQuery;

    with Query do
    begin
      SQL.Add('SELECT * FROM config_graficos');
      Open;

      if not (RecordCount > 0) then
        Exit;

      while not Query.Eof do
      begin
        AuxConfig := TConfigGrafico.Create(FieldByName('idconfiggraficos').AsInteger);

        with AuxConfig do
        begin
          TipoGrafico := TTipoGrafico(FieldByName('tipografico').AsInteger);
          Descricao   := FieldByName('descricao').AsString;
          CampoX      := TTipoCampo(FieldByName('campox').AsInteger);
          CampoY1     := TTipoCampo(FieldByName('campoy1').AsInteger);
          CampoY2     := TTipoCampo(FieldByName('campoy2').AsInteger);
        end;

        ALista.Itens.Add(AuxConfig);

        Query.Next;
      end;

      Result := True;

      Close;
    end;

  finally
    FreeAndNil(Query);
  end;

end;

function TConfigGraficoDAO.renderizarGrafico(var AChart: TDBChart;
  AConfig: TConfigGrafico; ADataI, ADataF: TDateTime): boolean;

  function concatFields(AFields, AField: string): string;
  begin
    if AField > '' then
    begin
      if AFields > '' then
        AFields := AFields + ', ';

      AFields := AFields + AField;
    end;

    Result := AFields;
  end;


var
  Query: TFDQuery;
  fields_str, field_label, field_x, field_y1, field_y2, groupby: string;
begin
  try
    Query := TMyconnection.getQuery;

    AChart.SeriesList.Clear;
    AChart.Title.Text[0] := AConfig.Descricao;

    AChart.SubTitle.Text[0] := 'De ' + formatDateTime('dd/MM/yyyy', ADataI) + ' Até ' + formatDateTime('dd/MM/yyyy', ADataF);

    case AConfig.CampoX of
      tcEmisDia:
      begin
        groupby := 'DAY(emis), MONTH(emis), YEAR(emis)';
        field_x := 'emis as field_x';
        field_label := 'DATE_FORMAT(emis,"%d/%m/%Y") field_label';
      end;

      tcEmisSemana:
      begin
        groupby := 'CONCAT(YEAR(emis), "/", WEEK(emis))';
        field_x := 'emis as field_x';
        field_label := 'CONCAT(YEAR(emis), "/", WEEK(emis)) field_label';
      end;

      tcEmisMes:
      begin
        groupby := 'MONTH(emis), YEAR(emis)';
        field_x := 'cast(concat(year(emis), "-", LPAD(month(emis),2,"01"), "-", "01") as DATE) field_x';
        field_label := 'DATE_FORMAT(emis,"%m/%Y") as field_label';
      end;

      tcEmisAno:
      begin
        groupby := 'YEAR(emis)';
        field_x := 'cast(concat(year(emis), "-", "01", "-", "01") as DATE) field_x';
        field_label := 'DATE_FORMAT(emis,"%Y") as field_label';
      end;

      tcCidade:
      begin
        groupby := 'cidade';
        field_x := 'cidade as field_x';
        field_label := 'cidade as field_label';
      end;

      tcUF:
      begin
        groupby := 'uf';
        field_x := 'uf as field_x';
        field_label := 'uf as field_label';
      end;

      else
        raise Exception.Create('Campos inválidos');
    end;

    case AConfig.CampoY1 of
      tcCusto:      field_y1 := 'sum(totalcusto) field_y1';
      tcVenda:      field_y1 := 'sum(totalvenda) field_y1';
      tcQuantidade: field_y1 := 'count(*) field_y1';
      tcVazio:      field_y1 := '';
    end;

    case AConfig.CampoY2 of
      tcCusto:      field_y2 := 'sum(totalcusto) field_y2';
      tcVenda:      field_y2 := 'sum(totalvenda) field_y2';
      tcQuantidade: field_y2 := 'count(*) field_y2';
      tcVazio:      field_y2 := '';
    end;

    fields_str := concatFields(fields_str, field_x);
    fields_str := concatFields(fields_str, field_label);
    fields_str := concatFields(fields_str, field_y1);
    fields_str := concatFields(fields_str, field_y2);

    with Query do
    begin
      SQL.Add('SELECT ');
      SQL.Add(fields_str);
      SQL.Add('FROM Pedidos P join Clientes C on C.idclientes = P.idclientes ');
      SQL.Add('WHERE P.emis BETWEEN &datai AND &dataf ');
      SQL.Add('GROUP BY');
      SQL.Add(groupby);
      SQL.Add('ORDER BY emis ');

      MacroByName('datai').AsDateTime := ADataI;
      MacroByName('dataf').AsDateTime := ADataF;

      Open;

      var serieLines1, serieLines2: TLineSeries;
      var serieBar1, serieBar2: TBarSeries;
      var seriePie1, seriePie2: TPieSeries;

      case AConfig.TipoGrafico of
        tgLinhas:
        begin
          if AConfig.CampoY1 <> tcVazio then
          begin
            serieLines1 := TLineSeries.Create(nil);
            serieLines1.Marks.Visible := false;
            serieLines1.Title := TConvTipo.CampoToStr(AConfig.CampoY1);
          end;

          if AConfig.CampoY2 <> tcVazio then
          begin
            serieLines2 := TLineSeries.Create(nil);
            serieLines2.Marks.Visible := false;
            serieLines2.Title := TConvTipo.CampoToStr(AConfig.CampoY2);
          end;
        end;

        tgColunas:
        begin
          if AConfig.CampoY1 <> tcVazio then
          begin
            serieBar1 := TBarSeries.Create(nil);
            serieBar1.Marks.Visible := false;
            serieBar1.Title := TConvTipo.CampoToStr(AConfig.CampoY1);
          end;

          if AConfig.CampoY1 <> tcVazio then
          begin
            serieBar2 := TBarSeries.Create(nil);
            serieBar2.Marks.Visible := false;
            serieBar2.Title := TConvTipo.CampoToStr(AConfig.CampoY2);
          end;
        end;

        tgPizza:
        begin
          if AConfig.CampoY1 <> tcVazio then
          begin
            seriePie1 := TPieSeries.Create(nil);
            seriePie1.Marks.Visible := true;
          end;

          if AConfig.CampoY1 <> tcVazio then
          begin
            seriePie2 := TPieSeries.Create(nil);
            seriePie2.Marks.Visible := true;
          end;
        end;

      end;

      while not Eof do
      begin

        case AConfig.TipoGrafico of
          tgLinhas:
          begin
            if AConfig.CampoY1 <> tcVazio then
              serieLines1.AddXY(FieldByName('field_x').Value, FieldByName('field_y1').Value, FieldByName('field_label').Value);

            if AConfig.CampoY2 <> tcVazio then
              serieLines2.AddXY(FieldByName('field_x').Value, FieldByName('field_y2').Value, FieldByName('field_label').Value);
          end;

          tgColunas:
          begin
            if AConfig.CampoY1 <> tcVazio then
              serieBar1.AddY(FieldByName('field_y1').Value, FieldByName('field_label').Value);

            if AConfig.CampoY2 <> tcVazio then
              serieBar2.AddY(FieldByName('field_y2').Value, FieldByName('field_label').Value);
          end;

          tgPizza:
          begin
            if AConfig.CampoY1 <> tcVazio then
              seriePie1.AddY(FieldByName('field_y1').Value, FieldByName('field_label').Value);

            if AConfig.CampoY2 <> tcVazio then
              seriePie2.AddY(FieldByName('field_y2').Value, FieldByName('field_label').Value);
          end;

          tgVazio: raise Exception.Create('Tipo do gráfico inválido');
        end;

        Next;
      end;

      case AConfig.TipoGrafico of
        tgLinhas:
        begin
          if AConfig.CampoY1 <> tcVazio then
            AChart.AddSeries(serielines1);

          if AConfig.CampoY2 <> tcVazio then
            AChart.AddSeries(serielines2);
        end;

        tgColunas:
        begin
          if AConfig.CampoY1 <> tcVazio then
            AChart.AddSeries(seriebar1);

          if AConfig.CampoY2 <> tcVazio then
            AChart.AddSeries(seriebar2);
        end;

        tgPizza:
        begin
          if AConfig.CampoY1 <> tcVazio then
            AChart.AddSeries(seriepie1);

          if AConfig.CampoY2 <> tcVazio then
            AChart.AddSeries(seriepie2);
        end;
      end;

      Result := true;
    end;

  finally
    //ShowMessage(Query.SQL.Text);
    FreeAndNil(Query);
  end;
end;

function TConfigGraficoDAO.Save(AConfig: TConfigGrafico): boolean;
var Conn: TFDConnection;
begin
  try
    Conn := TMyConnection.getConn;

    with Conn, AConfig do
    begin
      if Id = 0 then
        ExecSQL(
          'INSERT INTO config_graficos                                                          ' +
          ' (descricao, campox, campoy1, campoy2, tipografico)        ' +
          'VALUES                                                                               ' +
          ' (:descricao, :campox, :campoy1, :campoy2, :tipografico) ' ,
          [Descricao, CampoX, CampoY1, CampoY2, TipoGrafico]
        )

      else
        ExecSQL(
          'UPDATE config_graficos SET                                                          ' +
          ' descricao = :descricao, campox = :campox, campoy1 = :campoy1, campoy2 = :campoy2,  ' +
          ' tipografico = :tipografico                                                         ' +
          'WHERE                                                                               ' +
          ' idconfiggraficos = :idconfigraficos                                                ' ,
          [Descricao, CampoX, CampoY1, CampoY2, TipoGrafico, Id]
        );
    end;

    Result := True;
  except
    Result := False;
  end;
end;

end.
