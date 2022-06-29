unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.MySQL;

type
  TfrmMain = class(TForm)
    menuMain: TMainMenu;
    Grficos1: TMenuItem;
    Configuraes1: TMenuItem;
    Grficos2: TMenuItem;
    GerarGrficos1: TMenuItem;
    driverMySQL: TFDPhysMySQLDriverLink;
    procedure GerarGrficos1Click(Sender: TObject);
    procedure Configuraes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  fGraficos, fConfigs;

procedure TfrmMain.Configuraes1Click(Sender: TObject);
begin
  call_configs;
end;

procedure TfrmMain.GerarGrficos1Click(Sender: TObject);
begin
  call_graficos;
end;

end.
