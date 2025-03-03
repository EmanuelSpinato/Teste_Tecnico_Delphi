unit uCadastroClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls;

type
  TfmCadastroClientes = class(TfmCadastroBase)
    qrDadosID: TIntegerField;
    qrDadosNOME: TStringField;
    qrDadosENDERECO: TStringField;
    qrDadosEMAIL: TStringField;
    qrDadosCPF: TStringField;
    qrDadosTELEFONE: TStringField;
    Label1: TLabel;
    edId: TDBEdit;
    edNome: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    edEndereco: TDBEdit;
    Label4: TLabel;
    edEmail: TDBEdit;
    Label5: TLabel;
    edCPF: TDBEdit;
    Label6: TLabel;
    edTelefone: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCPFKeyPress(Sender: TObject; var Key: Char);
    procedure edTelefoneKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function ValidarObrigatorios: boolean; override;
    procedure BeforeEdit; override;    // Implementação do método abstrato
    procedure BeforePost; override;    // Implementação do método abstrato
  public
    { Public declarations }
  end;

var
  fmCadastroClientes: TfmCadastroClientes;

implementation

uses
  uSystemUtils;

{$R *.dfm}

{ Implementação do método abstrato BeforeEdit }
procedure TfmCadastroClientes.BeforeEdit;
begin
  // Ações a serem executadas antes de editar o registro.
  // Exemplo: você pode inicializar campos ou realizar verificações.
  //ShowMessage('Preparando para editar o cliente...');
end;

{ Implementação do método abstrato BeforePost }
procedure TfmCadastroClientes.BeforePost;
begin
  // Ações a serem executadas antes de salvar o registro.
  // Exemplo: realizar validações adicionais ou processar dados.
  //ShowMessage('Preparando para salvar o cliente...');
end;

{ Bloqueia a entrada de caracteres não numéricos no campo CPF }
procedure TfmCadastroClientes.edCPFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  // Permite apenas números (0-9) e o Backspace (#8) para correções.
  if not (Key in ['0'..'9', #8]) then
    Key := #0;  // Bloqueia a entrada de caracteres não numéricos
end;

{ Bloqueia a entrada de caracteres não numéricos no campo Telefone }
procedure TfmCadastroClientes.edTelefoneKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  // Permite apenas números (0-9) e o Backspace (#8) para correções.
  if not (Key in ['0'..'9', #8]) then
    Key := #0;  // Bloqueia a entrada de caracteres não numéricos
end;

{ Libera o formulário da memória quando ele é fechado }
procedure TfmCadastroClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fmCadastroClientes := nil;  // Libera o formulário da memória
end;

{ Validação dos campos obrigatórios antes de salvar o registro }
function TfmCadastroClientes.ValidarObrigatorios: boolean;
begin
  if Trim(edId.Text) = '' then
  begin
    ShowMessage('Informe o id.');
    edId.SetFocus;
    Exit(false);
  end;

  if Trim(edNome.Text) = '' then
  begin
    ShowMessage('Informe o nome.');
    edNome.SetFocus;
    Exit(false);
  end;

  if Trim(edEndereco.Text) = '' then
  begin
    ShowMessage('Informe o endereco.');
    edEndereco.SetFocus;
    Exit(false);
  end;

  if Trim(edEmail.Text) = '' then
  begin
    ShowMessage('Informe o email.');
    edEmail.SetFocus;
    Exit(false);
  end;

  Result := inherited ValidarObrigatorios;  // Chama a validação da classe base
end;

end.

