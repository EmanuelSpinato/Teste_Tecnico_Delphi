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
    pcPrincipal: TPageControl;  // Controle de páginas com abas para visualização e edição
    tsGrid: TTabSheet;          // Aba para exibição dos registros em grid
    tsEdits: TTabSheet;         // Aba para edição e inserção de registros
    pnButtonsGrid: TPanel;      // Painel de botões para ações no grid
    btInserir: TButton;         // Botão para inserir novo registro
    btEditar: TButton;          // Botão para editar o registro selecionado
    btExcluit: TButton;         // Botão para excluir o registro selecionado
    grDados: TDBGrid;           // Grid para exibir os dados da query
    pnButtonsEdits: TPanel;     // Painel de botões na tela de edição
    btSalvar: TButton;          // Botão para salvar o registro
    btCancelar: TButton;        // Botão para cancelar a edição ou inserção
    qrDados: TFDQuery;          // Query para manipulação dos dados
    dsDados: TDataSource;       // DataSource para conectar a query ao grid
    pnEdits: TPanel;            // Painel que contém os campos de edição
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
    procedure BeforeEdit; virtual; abstract; // Evento para realizar ações antes de editar
    procedure BeforePost; virtual; abstract; // Evento para realizar ações antes de salvar
    function ValidarObrigatorios: boolean; virtual; // Validação de campos obrigatórios
  public
  end;

var
  fmCadastroBase: TfmCadastroBase;

implementation

{$R *.dfm}

uses
  udmPrincipal, uSystemUtils;

{
  Método acionado ao clicar no botão "Cancelar".
  Cancela a operação de edição/inserção e retorna para a visualização em grid.
}
procedure TfmCadastroBase.btCancelarClick(Sender: TObject);
begin
  qrDados.Cancel;  // Cancela a operação corrente
  pcPrincipal.ActivePage := tsGrid;  // Retorna para a aba de visualização (grid)
end;

{
  Método acionado ao clicar no botão "Salvar".
  Salva os dados, realiza validações, e lida com possíveis erros durante a operação.
}
procedure TfmCadastroBase.btSalvarClick(Sender: TObject);
begin
  if ValidarObrigatorios then  // Verifica se os campos obrigatórios estão preenchidos
  begin
    try
      BeforePost;  // Chamado para executar ações antes de salvar (implementado nas classes filhas)
      qrDados.Post;  // Confirma o registro no banco de dados
      pcPrincipal.ActivePage := tsGrid;  // Retorna para a visualização em grid
    except
      on E: Exception do
      begin
        // Lida com o erro de chave primária duplicada
        if E.Message.Contains('PRIMARY') then
          MsgWarning('Não é permitido registro duplicado.' + E.Message)
        else
          MsgWarning('Evento inesperado: ' + E.Message);  // Outros erros
      end;
    end;
  end;
end;

{
  Método acionado ao clicar no botão "Editar".
  Abre a tela de edição e coloca o registro no modo de edição.
}
procedure TfmCadastroBase.btEditarClick(Sender: TObject);
begin
  try
    if not qrDados.IsEmpty then  // Verifica se há registro selecionado
    begin
      pcPrincipal.ActivePage := tsEdits;  // Muda para a aba de edição
      BeforeEdit;  // Executa ações antes de editar (implementado nas classes filhas)
      qrDados.Edit;  // Coloca o registro no modo de edição
    end
    else
      MsgWarning('Nenhum registro selecionado para edição.');  // Exibe aviso se não houver registro
  except
    on E: Exception do
      MsgWarning('Erro ao tentar editar: ' + E.Message);  // Lida com erros
  end;
end;

{
  Método acionado ao clicar no botão "Excluir".
  Exibe uma confirmação antes de excluir o registro selecionado.
}
procedure TfmCadastroBase.btExcluitClick(Sender: TObject);
begin
  if MsgConfirm('Confirma a exclusão do registro?') then
    qrDados.Delete;  // Exclui o registro caso o usuário confirme
end;

{
  Método acionado ao clicar no botão "Inserir".
  Abre a aba de edição para inserção de um novo registro.
}
procedure TfmCadastroBase.btInserirClick(Sender: TObject);
begin
  qrDados.Append;  // Inicia a inserção de um novo registro
  pcPrincipal.ActivePage := tsEdits;  // Muda para a aba de edição
end;

{
  Evento acionado ao fechar o formulário.
  Define a ação para liberar o formulário da memória (caFree).
}
procedure TfmCadastroBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;  // Libera o formulário da memória ao ser fechado
end;

{
  Evento acionado ao exibir o formulário.
  Inicializa o estado do formulário, abre a query e oculta as abas de edição.
}
procedure TfmCadastroBase.FormShow(Sender: TObject);
begin
  EsconderAbas;  // Oculta as abas para deixar o PageControl organizado
  qrDados.Open;  // Abre a query para exibir os registros no grid
end;

{
  Função para validar campos obrigatórios.
  Esta função pode ser sobrescrita nas classes filhas para adicionar validações específicas.
}
function TfmCadastroBase.ValidarObrigatorios: boolean;
begin
  Result := true;  // Retorna verdadeiro por padrão (sem validação)
end;

{
  Esconde todas as abas do PageControl, exceto a aba de visualização (grid).
}
procedure TfmCadastroBase.EsconderAbas;
var
  I: Integer;
begin
  for I := 0 to pcPrincipal.PageCount - 1 do
    pcPrincipal.Pages[I].TabVisible := false;  // Oculta todas as abas

  pcPrincipal.ActivePage := tsGrid;  // Deixa a aba de visualização ativa
end;

end.

