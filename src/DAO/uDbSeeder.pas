unit uDbSeeder;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  System.Classes, VCL.Dialogs, Vcl.Controls, VCL.Forms, System.Math, System.DateUtils,
  uConnection;

type TVerificarTabelas = class
  private
    class var Conn: TFDConnection;
    Query: TFDQuery;
  public
    class function VerificarTabelas: boolean;
end;

implementation

{ TVerificarTabelas }

class function TVerificarTabelas.VerificarTabelas: boolean;
var List: TStringList;
begin
  try
    Conn := TMyConnection.getConn;
    List := TStringList.Create;

    with Conn do
    begin
      try
        GetTableNames('','','',List,[osMy],[tkTable], false);

        var criarClientes, criarPedidos, criarConfigs: boolean;
        criarClientes := not (List.IndexOf('clientes') > -1);
        criarPedidos  := not (List.IndexOf('pedidos') > -1);
        criarConfigs  := not (List.IndexOf('config_graficos') > -1) ;

        if criarClientes or criarPedidos or criarConfigs then
        begin
          if not (MessageDlg('Criar as tabelas ?' , mtConfirmation, [mbOK, mbCancel], 0) = mrOk) then
          begin
            Application.Terminate;
            Exit;
          end;

          if criarClientes then
          begin
            ExecSQL(
              'CREATE TABLE clientes (    ' +
              '  idclientes INT NOT NULL, ' +
              '  nome VARCHAR(45) NULL,   ' +
              '  cidade VARCHAR(45) NULL, ' +
              '  uf VARCHAR(2) NULL,      ' +
              '  PRIMARY KEY (idclientes) ' +
              ');                         '
            );
          end;

          if criarPedidos then
          begin
            ExecSQL(
              'CREATE TABLE pedidos (                            ' +
              '  idpedidos INT NOT NULL AUTO_INCREMENT,          ' +
              '  idclientes INT NULL,                            ' +
              '  emis DATE NULL,                                 ' +
              '  venc DATE NULL,                                 ' +
              '  totalcusto DOUBLE NULL,                         ' +
              '  totalvenda DOUBLE NULL,                         ' +
              '  PRIMARY KEY (idpedidos),                        ' +
              '  INDEX fk_clientes_idx (idclientes ASC) VISIBLE, ' +
              '  CONSTRAINT fk_clientes                          ' +
              '    FOREIGN KEY (idclientes)                      ' +
              '    REFERENCES clientes (idclientes)              ' +
              '    ON DELETE RESTRICT                            ' +
              '    ON UPDATE NO ACTION                           ' +
              ');                                                '
            );
          end;

          if criarConfigs then
          begin
            ExecSQL(
              'CREATE TABLE config_graficos (                     ' +
              '	 idconfiggraficos BIGINT auto_increment NOT NULL, ' +
              '	 descricao VARCHAR(100) NULL,                     ' +
              '	 campox integer NULL,                             ' +
              '	 campoy1 integer NULL,                            ' +
              '	 campoy2 integer NULL,                            ' +
              '	 tipografico integer NULL,                        ' +
              '	 PRIMARY KEY (idconfiggraficos)                   ' +
              ');                                                 '
            );
          end;
        end;

        try
          ExecSQL('SET autocommit=0;');
          StartTransaction;

          if criarClientes then
          begin
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (1, "Cliente 01", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (2, "Cliente 02", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (3, "Cliente 03", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (4, "Cliente 04", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (5, "Cliente 05", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (6, "Cliente 06", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (7, "Cliente 07", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (8, "Cliente 08", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (9, "Cliente 09", "SÃO PAULO", "SP")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (10, "Cliente 10", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (11, "Cliente 11", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (12, "Cliente 12", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (13, "Cliente 13", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (14, "Cliente 14", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (15, "Cliente 15", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (16, "Cliente 16", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (17, "Cliente 17", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (18, "Cliente 18", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (19, "Cliente 19", "RIO DE JANEIRO", "RJ")');
            ExecSQL('INSERT INTO clientes (idclientes, nome, cidade, uf) VALUES (20, "Cliente 20", "RIO DE JANEIRO", "RJ")');
          end;

          if criarPedidos then
          begin
            var i: integer;
            for i := 1 to 100 do
            begin

              var custo, venda: double;
              custo := RandomRange(100, 200);
              venda := custo + RandomRange(100, 150);

              var emis, venc: TDateTime;
              emis := EncodeDate(RandomRange(2020, 2022), RandomRange(1, 12), RandomRange(1, 28));
              venc := IncDay(emis, RandomRange(1, 15));

              ExecSQL(
               'INSERT INTO pedidos                                   ' +
               ' (idclientes, emis, venc, totalcusto, totalvenda)     ' +
               'VALUES                                                ' +
               ' (:idclientes, :emis, :venc, :totalcusto, :totalvenda)' ,
               [RandomRange(1, 20), emis, venc, custo, venda]
              );

            end;
          end;

          if criarConfigs then
          begin
            ExecSQL(
              'INSERT INTO config_graficos (descricao, campox, campoy1, campoy2, tipografico) ' +
              'VALUES ("Custo x Vendas por Mês", 8, 1, 2, 1);                                 '
            );

            ExecSQL(
              'INSERT INTO config_graficos (descricao, campox, campoy1, campoy2, tipografico) ' +
              'VALUES ("Vendas por Cidade", 3, 2, 0, 3);                                      '
            );

            ExecSQL(
              'INSERT INTO config_graficos (descricao, campox, campoy1, campoy2, tipografico) ' +
              'VALUES ("Pedidos por Ano", 9, 5, 0, 2);                                        '
            );

          end;

          Commit;
        except
          Rollback;
        end;
      except
        ShowMessage('Erro ao criar tabelas.');
        Application.Terminate;
        Exit;
      end;
    end;
  finally
    List.Free;
    TMyConnection.ResetConn;
  end;

end;

end.
