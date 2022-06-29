unit fConfigs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uGraficosController, fConfigGrafico;

type
  TfrmConfigs = class(TForm)
    dbgTabela: TDBGrid;
    Panel1: TPanel;
    dsConfigs: TDataSource;
    mtbConfigs: TFDMemTable;
    mtbConfigsId: TIntegerField;
    mtbConfigsDescricao: TStringField;
    btnEdit: TButton;
    btnDelete: TButton;
    btnNew: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    Controller: TGraficosController;
  public
    { Public declarations }
  end;

var
  frmConfigs: TfrmConfigs;
  procedure call_configs;

implementation

{$R *.dfm}

procedure call_configs;
begin
  try
    frmConfigs := TfrmConfigs.Create(nil);
    frmConfigs.ShowModal;
  finally
    FreeAndNil(frmConfigs);
  end;
end;

procedure TfrmConfigs.btnDeleteClick(Sender: TObject);
begin
  if mtbConfigsId.AsInteger > 0 then
    Controller.excluirConfig(mtbConfigsId.AsInteger);

  Controller.atualizarGridConfigs(mtbConfigs);
end;

procedure TfrmConfigs.btnEditClick(Sender: TObject);
begin
  if mtbConfigsId.AsInteger > 0 then
   if call_configGrafico(mtbConfigsId.AsInteger) then
    Controller.atualizarGridConfigs(mtbConfigs);
end;

procedure TfrmConfigs.btnNewClick(Sender: TObject);
begin
  if call_configGrafico(0) then
    Controller.atualizarGridConfigs(mtbConfigs);
end;

procedure TfrmConfigs.FormCreate(Sender: TObject);
begin
  Controller := TGraficosController.Create;
end;

procedure TfrmConfigs.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmConfigs.FormShow(Sender: TObject);
begin
  Controller.atualizarGridConfigs(mtbConfigs);
end;

end.
