unit fConfigGrafico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uCadConfigController;

type
  TfrmConfigGrafico = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    cbbY1: TComboBox;
    cbbY2: TComboBox;
    GroupBox2: TGroupBox;
    cbbTipo: TComboBox;
    gbEixoX: TGroupBox;
    cbbX1: TComboBox;
    btnCancelar: TButton;
    btnGravar: TButton;
    edtDesc: TEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cbbTipoChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    Gravou: boolean;
    Controller: TCadConfigController;

    procedure atualizarOpcoes;
  public
    { Public declarations }
  end;

var
  frmConfigGrafico: TfrmConfigGrafico;
  function call_ConfigGrafico(AId: integer = 0): boolean;

implementation

{$R *.dfm}

function call_ConfigGrafico(AId: integer = 0): boolean;
begin
  try
    frmConfigGrafico := TfrmConfigGrafico.Create(nil);
    frmConfigGrafico.Gravou := false;
    frmConfigGrafico.Controller := TCadConfigController.Create(Aid);
    frmConfigGrafico.ShowModal;
  finally
    Result := frmConfigGrafico.Gravou;
    FreeAndNil(frmConfigGrafico.Controller);
    FreeAndNil(frmConfigGrafico);
  end;
end;
{ TfrmConfigGrafico }

procedure TfrmConfigGrafico.atualizarOpcoes;
begin
  Controller.atualizarCombo(cbbTipo, tcG);
  Controller.atualizarCombo(cbbX1,   tcX);
  Controller.atualizarCombo(cbbY1,   tcY1);
  Controller.atualizarCombo(cbbY2,   tcY2);
end;

procedure TfrmConfigGrafico.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfigGrafico.btnGravarClick(Sender: TObject);
var msg: string;
begin
  Controller.setarCampo(cbbX1, tcX);
  Controller.setarCampo(cbbY1, tcY1);
  Controller.setarCampo(cbbY2, tcY2);
  Controller.setarDesc(edtDesc.Text);

  Gravou :=  Controller.gravarConfig(msg);

  if Gravou then
    Close
  else
    ShowMessage(msg);
end;

procedure TfrmConfigGrafico.cbbTipoChange(Sender: TObject);
begin
  if Controller.setarTipo(cbbTipo) then
    atualizarOpcoes;
end;

procedure TfrmConfigGrafico.FormShow(Sender: TObject);
begin
  atualizarOpcoes;
  edtDesc.Text := Controller.getDesc;
end;

end.
