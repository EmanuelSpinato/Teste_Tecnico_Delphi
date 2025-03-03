unit uCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfmCadastroBase = class(TForm)
    pcPrincipal: TPageControl;  // Controle de p�ginas com abas para visualiza��o e edi��o
    tsGrid: TTabSheet;          // Aba para exibi��o dos registros em grid
    tsEdits: TTabSheet;         // Aba para edi��o e inser��o de registros
    pnButtonsGrid: TPanel;      // Painel de bot�es para a��es no grid
    btInserir: TButton;         // Bot�o para inserir novo registro
    btEditar: TButton;          // Bot�o para editar o registro selecionado
    btExcluit: TButton;         // Bot�o para excluir o registro selecionado
    grDados: TDBGrid;           // Grid para exibir os dados da query
    pnButtonsEdits: TPanel;     // Painel de bot�es na tela de edi��o
    btSalvar: TButton;          // Bot�o para salvar o registro
    btCancelar: TButton;        // Bot�o para cancelar a edi��o ou inser��o
    qrDados: TFDQuery;          // Query para manipula��o dos dados
    dsDados: TDataSource;       // DataSource para conectar a query ao grid
    pnEdits: TPanel;            // Painel que cont�m os campos de edi��o
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluitClick(Sender: TObject);
  private
    procedure EsconderAbas; // Esconde as abas do PageControl
  protected
    procedure BeforeEdit; virtual; abstract; // Evento para realizar a��es antes de editar
    procedure BeforePost; virtual; abstract; // Evento para realizar a��es antes de salvar
    function ValidarObrigatorios: boolean; virtual; // Valida��o de campos obrigat�rios
  public
  end;

var
  fmCadastroBase: TfmCadastroBase;

implementation

{$R *.dfm}

uses
  udmPrincipal, uSystemUtils;

{
  M�todo acionado ao clicar no bot�o "Cancelar".
  Cancela a opera��o de edi��o/inser��o e retorna para a visualiza��o em grid.
}
procedure TfmCadastroBase.btCancelarClick(Sender: TObject);
begin
  qrDados.Cancel;  // Cancela a opera��o corrente
  pcPrincipal.ActivePage := tsGrid;  // Retorna para a aba de visualiza��o (grid)
end;

{
  M�todo acionado ao clicar no bot�o "Salvar".
  Salva os dados, realiza valida��es, e lida com poss�veis erros durante a opera��o.
}
procedure TfmCadastroBase.btSalvarClick(Sender: TObject);
begin
  if ValidarObrigatorios then  // Verifica se os campos obrigat�rios est�o preenchidos
  begin
    try
      BeforePost;  // Chamado para executar a��es antes de salvar (implementado nas classes filhas)
      qrDados.Post;  // Confirma o registro no banco de dados
      pcPrincipal.ActivePage := tsGrid;  // Retorna para a visualiza��o em grid
    except
      on E: Exception do
      begin
        // Lida com o erro de chave prim�ria duplicada
        if E.Message.Contains('PRIMARY') then
          MsgWarning('N�o � permitido registro duplicado.' + E.Message)
        else
          MsgWarning('Evento inesperado: ' + E.Message);  // Outros erros
      end;
    end;
  end;
end;

{
  M�todo acionado ao clicar no bot�o "Editar".
  Abre a tela de edi��o e coloca o registro no modo de edi��o.
}
procedure TfmCadastroBase.btEditarClick(Sender: TObject);
begin
  try
    if not qrDados.IsEmpty then  // Verifica se h� registro selecionado
    begin
      pcPrincipal.ActivePage := tsEdits;  // Muda para a aba de edi��o
      BeforeEdit;  // Executa a��es antes de editar (implementado nas classes filhas)
      qrDados.Edit;  // Coloca o registro no modo de edi��o
    end
    else
      MsgWarning('Nenhum registro selecionado para edi��o.');  // Exibe aviso se n�o houver registro
  except
    on E: Exception do
      MsgWarning('Erro ao tentar editar: ' + E.Message);  // Lida com erros
  end;
end;

{
  M�todo acionado ao clicar no bot�o "Excluir".
  Exibe uma confirma��o antes de excluir o registro selecionado.
}
procedure TfmCadastroBase.btExcluitClick(Sender: TObject);
begin
  if MsgConfirm('Confirma a exclus�o do registro?') then
    qrDados.Delete;  // Exclui o registro caso o usu�rio confirme
end;

{
  M�todo acionado ao clicar no bot�o "Inserir".
  Abre a aba de edi��o para inser��o de um novo registro.
}
procedure TfmCadastroBase.btInserirClick(Sender: TObject);
begin
  qrDados.Append;  // Inicia a inser��o de um novo registro
  pcPrincipal.ActivePage := tsEdits;  // Muda para a aba de edi��o
end;

{
  Evento acionado ao fechar o formul�rio.
  Define a a��o para liberar o formul�rio da mem�ria (caFree).
}
procedure TfmCadastroBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;  // Libera o formul�rio da mem�ria ao ser fechado
end;

{
  Evento acionado ao exibir o formul�rio.
  Inicializa o estado do formul�rio, abre a query e oculta as abas de edi��o.
}
procedure TfmCadastroBase.FormShow(Sender: TObject);
begin
  EsconderAbas;  // Oculta as abas para deixar o PageControl organizado
  qrDados.Open;  // Abre a query para exibir os registros no grid
end;

{
  Fun��o para validar campos obrigat�rios.
  Esta fun��o pode ser sobrescrita nas classes filhas para adicionar valida��es espec�ficas.
}
function TfmCadastroBase.ValidarObrigatorios: boolean;
begin
  Result := true;  // Retorna verdadeiro por padr�o (sem valida��o)
end;

{
  Esconde todas as abas do PageControl, exceto a aba de visualiza��o (grid).
}
procedure TfmCadastroBase.EsconderAbas;
var
  I: Integer;
begin
  for I := 0 to pcPrincipal.PageCount - 1 do
    pcPrincipal.Pages[I].TabVisible := false;  // Oculta todas as abas

  pcPrincipal.ActivePage := tsGrid;  // Deixa a aba de visualiza��o ativa
end;

end.

