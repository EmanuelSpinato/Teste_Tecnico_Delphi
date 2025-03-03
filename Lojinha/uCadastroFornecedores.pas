unit uCadastroFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfmCadastroFornecedores = class(TfmCadastroBase)
    qrDadosNOME: TStringField;
    qrDadosENDERECO: TStringField;
    qrDadosEMAIL: TStringField;
    qrDadosCNPJ: TStringField;
    qrDadosTELEFONE: TStringField;
    qrDadosID: TFDAutoIncField;
    Label1: TLabel;
    edId: TDBEdit;
    Label2: TLabel;
    edNome: TDBEdit;
    Label3: TLabel;
    edEndereco: TDBEdit;
    Label4: TLabel;
    edEmail: TDBEdit;
    Label5: TLabel;
    edCNPJ: TDBEdit;
    Label6: TLabel;
    edTelefone: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function IsValidCNPJ(CNPJ: string): Boolean;
    function IsValidPhoneNumber(PhoneNumber: string): Boolean;
    function IsValidEmail(Email: string): Boolean;
  protected
    function ValidarObrigatorios: boolean; override;
    procedure BeforePost; override;
  public
    { Public declarations }
  end;

var
  fmCadastroFornecedores: TfmCadastroFornecedores;

implementation

{$R *.dfm}

{ TfmCadastroFornecedores }

procedure TfmCadastroFornecedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fmCadastroFornecedores := nil;
end;

function TfmCadastroFornecedores.IsValidCNPJ(CNPJ: string): Boolean;
begin
  // Exemplo básico de validação de CNPJ
  Result := (Length(CNPJ) = 14);
end;

function TfmCadastroFornecedores.IsValidPhoneNumber(PhoneNumber: string): Boolean;
begin
  // Validação simples de número de telefone
  Result := (Length(PhoneNumber) >= 10) and (Length(PhoneNumber) <= 11);
end;

function TfmCadastroFornecedores.IsValidEmail(Email: string): Boolean;
begin
  // Verificação básica para presença do símbolo '@'
  Result := Pos('@', Email) > 1;
end;

function TfmCadastroFornecedores.ValidarObrigatorios: boolean;
begin
  // Validação dos campos obrigatórios
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
    ShowMessage('Informe o endereço.');
    edEndereco.SetFocus;
    Exit(false);
  end;

  if Trim(edEmail.Text) = '' then
  begin
    ShowMessage('Informe o email.');
    edEmail.SetFocus;
    Exit(false);
  end
  else if not IsValidEmail(Trim(edEmail.Text)) then
  begin
    ShowMessage('E-mail inválido. Informe um e-mail válido.');
    edEmail.SetFocus;
    Exit(false);
  end;

  if not IsValidCNPJ(Trim(edCNPJ.Text)) then
  begin
    ShowMessage('CNPJ inválido. Informe um CNPJ válido.');
    edCNPJ.SetFocus;
    Exit(false);
  end;

  if not IsValidPhoneNumber(Trim(edTelefone.Text)) then
  begin
    ShowMessage('Telefone inválido. Informe um número de telefone válido.');
    edTelefone.SetFocus;
    Exit(false);
  end;

  // Retorna true se todas as validações passarem
  Result := true;
end;

procedure TfmCadastroFornecedores.BeforePost;
begin
  // Verifique as validações antes de salvar os dados
  if not ValidarObrigatorios then
  begin
    Abort;  // Se a validação falhar, cancela o salvamento
  end;
  inherited;  // Chama o método da classe base se necessário
end;

end.

