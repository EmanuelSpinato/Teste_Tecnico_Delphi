unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfmLogin = class(TForm)
    Label1: TLabel;
    edLogin: TEdit;
    Label2: TLabel;
    edSenha: TEdit;
    btOk: TButton;
    btCancelar: TButton;
    qrLogin: TFDQuery;
    procedure btOkClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); // Novo evento para capturar o Enter
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

{$R *.dfm}

uses
  udmPrincipal, uCadastroBase, uSystemUtils;

procedure TfmLogin.btOkClick(Sender: TObject);
var
  SenhaBd, SenhaUser: string;
begin
  // Verifica se os campos de login e senha foram preenchidos
  if (Trim(edLogin.Text) = '') or (Trim(edSenha.Text) = '') then
  begin
    MsgWarning('Por favor, preencha o login e a senha.');
    Exit;
  end;

  // Fecha qualquer consulta anterior e define a nova consulta de login
  qrLogin.Close;
  qrLogin.SQL.Text := 'SELECT SENHA FROM USUARIOS WHERE LOGIN = :LOGIN';
  qrLogin.ParamByName('LOGIN').AsString := edLogin.Text;
  qrLogin.Open;

  // Verifica se o usuário existe no banco de dados
  if qrLogin.IsEmpty then
  begin
    MsgWarning('Login ou senha incorretos.');
    Exit;
  end;

  // Recupera a senha do banco de dados diretamente (sem decodificação)
  SenhaBd := qrLogin.FieldByName('SENHA').AsString;

  // Senha inserida pelo usuário
  SenhaUser := edSenha.Text;

  // Compara a senha inserida pelo usuário com a senha armazenada no banco de dados
  if SenhaUser <> SenhaBd then
  begin
    MsgWarning('Login ou senha incorretos.');
    Exit;
  end;

  // Se tudo estiver correto, fecha o formulário com sucesso
  ModalResult := mrOk;
end;

procedure TfmLogin.btCancelarClick(Sender: TObject);
begin
  // Fecha o formulário sem realizar login
  ModalResult := mrCancel;
end;

{ Evento para capturar o pressionamento da tecla Enter }
procedure TfmLogin.edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Verifica se a tecla pressionada foi o Enter
  if Key = VK_RETURN then
  begin
    // Aciona o evento do botão Ok (mesma ação que ocorre ao clicar no botão)
    btOkClick(Sender);
  end;
end;

end.

