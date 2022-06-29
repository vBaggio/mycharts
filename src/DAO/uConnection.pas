unit uConnection;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  Vcl.Forms, Vcl.Dialogs, IniFiles;

type
  TMyConnection = class
  private
    class var MyConn : TMyConnection;

    FConn: TFDConnection;
    FQuery: TFDQuery;

    CONN_IP:string;
    CONN_PORT:string;
    CONN_DBNAME:string;
    CONN_USER:string;
    CONN_PASS:string;

    procedure LerIni;
    procedure SetupConnection;

  public
    constructor Create;
    destructor Destroy; override;

    class function getConn: TFDConnection;                  
    class function resetConn: TFDConnection;
    class function getQuery: TFDQuery;
  end;

implementation

{ TMyConnection }


constructor TMyConnection.Create;
begin
  Self.SetupConnection;
end;

destructor TMyConnection.Destroy;
begin
  FConn.Free;

  inherited;
end;

procedure TMyConnection.SetupConnection;
begin
  try
    if not Assigned(FConn) then
      FConn := TFDConnection.Create(nil);

    LerIni;

    FConn.Connected := False;

    FConn.Params.DriverID := 'MYSQL';

    FConn.Params.Add('Server='+ Self.CONN_IP);
    FConn.Params.Add('Port='+ Self.CONN_PORT);
    FConn.Params.Database := Self.CONN_DBNAME;
    FConn.Params.UserName := Self.CONN_USER;
    FConn.Params.Password := Self.CONN_PASS;
    FConn.LoginPrompt     := False;

    FConn.Connected := True;
  except
    ShowMessage('Erro ao conectar com o banco de dados.' + #13 + 'Verifique o arquivo .ini no diretório do executável.');
    Application.Terminate;
  end;
end;

procedure TMyConnection.LerIni;
var
  ininame: string;
  inifile: TIniFile;
begin
  ininame := ChangeFileExt( Application.ExeName, '.ini' );
  inifile := TIniFile.Create(ininame);

  if not FileExists(ininame) then
  begin
    inifile.WriteString( 'Db', 'IP',     'localhost');
    inifile.WriteString( 'Db', 'PORT',   '3306');
    inifile.WriteString( 'Db', 'DBNAME', 'mycharts');
    inifile.WriteString( 'Db', 'USER',   'root');
    inifile.WriteString( 'Db', 'PASS',   '');
  end;

  try
    CONN_IP     := inifile.ReadString( 'Db', 'IP',     'localhost');
    CONN_PORT   := inifile.ReadString( 'Db', 'PORT',   '3306');
    CONN_DBNAME := inifile.ReadString( 'Db', 'DBNAME', 'mycharts');
    CONN_USER   := inifile.ReadString( 'Db', 'USER',   'root');
    CONN_PASS   := inifile.ReadString( 'Db', 'PASS',   '');
  finally
    inifile.Free;
  end;
end;

class function TMyConnection.getConn: TFDConnection;
begin
  if not Assigned(MyConn) then
    MyConn := TMyConnection.Create;

  if not Self.MyConn.FConn.Connected then
    MyConn.SetupConnection;

  Result := MyConn.FConn;
end;

class function TMyConnection.resetConn: TFDConnection;
begin
  Self.MyConn.SetupConnection;

  Result := Self.getConn;
end;

class function TMyConnection.getQuery:TFDQuery;
begin
  Myconn.FQuery := TFDQuery.Create(nil);
  MyConn.FQuery.Connection := getConn;

  MyConn.FQuery.SQL.Clear;


  Result := Myconn.FQuery;
end;

end.
