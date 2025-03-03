unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, RLReport; // Adicionei RLReport para relatórios

type
  // Classe principal do formulário
  TfmPrincipal = class(TForm)
    mmPrincipal: TMainMenu; // Menu principal da aplicação
    Cadastros1: TMenuItem;  // Menu de cadastros
    Clientes1: TMenuItem;   // Submenu de Clientes
    Fornecedores1: TMenuItem; // Submenu de Fornecedores
    Produtos1: TMenuItem;   // Submenu de Produtos
    Categorias1: TMenuItem; // Submenu de Categorias
    mnuPedidos1: TMenuItem;  // Submenu de Pedidos (nome atualizado para boas práticas)
    N1: TMenuItem;          // Separador de menu
    Sair1: TMenuItem;       // Opção para sair do sistema
    Movimentos1: TMenuItem;     // Submenu de Vendas
    Relatrios1: TMenuItem;  // Menu de Relatórios
    Estoque1: TMenuItem;    // Submenu de Relatório de Estoque
    sbPrincipal: TStatusBar; // Barra de status para mensagens e status da aplicação
    Estoque2: TMenuItem;    // Submenu de estoque (entradas/saídas)
    Entradas1: TMenuItem;   // Submenu de entradas de estoque
    Sadas1: TMenuItem;      // Submenu de saídas de estoque
    ListagemProdutos1: TMenuItem; // Submenu de listagem de produtos
    Usurios1: TMenuItem;    // Submenu de usuários
    Vendas1: TMenuItem;     // Submenu de vendas
    // Métodos que tratam o clique nos menus
    procedure Clientes1Click(Sender: TObject);
    procedure Categorias1Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Entradas1Click(Sender: TObject);
    procedure ListagemProdutos1Click(Sender: TObject);
    procedure Estoque1Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject); // Evento de criação do formulário
    procedure mnuPedidos1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject); // Método para o menu de vendas
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrincipal: TfmPrincipal;

implementation

{$R *.dfm}

uses
  uCadastroClientes, uCadastroCategorias, uCadastroFornecedores,
  uCadastroProdutos, uMovimentoEstoqueEntrada, uRelatorioProduto,
  uRelatorioMovimentoEstoque, uCadastroUsuarios, uCadastroPedido,
  uRelatorioVendas;

{ Evento disparado ao clicar no menu "Clientes" }
procedure TfmPrincipal.Clientes1Click(Sender: TObject);
begin
  if fmCadastroClientes = nil then
    fmCadastroClientes := TfmCadastroClientes.Create(Self); // Instancia o formulário, se necessário

  fmCadastroClientes.Show; // Exibe o formulário de cadastro de clientes
end;

{ Evento disparado ao clicar no menu "Categorias" }
procedure TfmPrincipal.Categorias1Click(Sender: TObject);
begin
  if fmCadastroCategorias = nil then
    fmCadastroCategorias := TfmCadastroCategorias.Create(Self); // Instancia o formulário, se necessário

  fmCadastroCategorias.Show; // Exibe o formulário de cadastro de categorias
end;

{ Evento disparado ao clicar no menu "Fornecedores" }
procedure TfmPrincipal.Fornecedores1Click(Sender: TObject);
begin
  if fmCadastroFornecedores = nil then
    fmCadastroFornecedores := TfmCadastroFornecedores.Create(Self); // Instancia o formulário, se necessário

  fmCadastroFornecedores.Show; // Exibe o formulário de cadastro de fornecedores
end;

{ Evento disparado ao clicar no menu "Produtos" }
procedure TfmPrincipal.Produtos1Click(Sender: TObject);
begin
  if fmCadastroProdutos = nil then
    fmCadastroProdutos := TfmCadastroProdutos.Create(Self); // Instancia o formulário, se necessário

  fmCadastroProdutos.Show; // Exibe o formulário de cadastro de produtos
end;

{ Evento disparado ao clicar no menu "Entradas de Estoque" }
procedure TfmPrincipal.Entradas1Click(Sender: TObject);
begin
  if fmMovimentoEstoqueEntrada = nil then
    fmMovimentoEstoqueEntrada := TfmMovimentoEstoqueEntrada.Create(Self); // Instancia o formulário, se necessário

  fmMovimentoEstoqueEntrada.Show; // Exibe o formulário de movimentação de entradas de estoque
end;

{ Evento disparado ao clicar no menu "Relatório de Produtos" }
procedure TfmPrincipal.ListagemProdutos1Click(Sender: TObject);
begin
  // Cria o formulário de relatório de produtos
  fmRelatorioProduto := TfmRelatorioProduto.Create(Self);
  try
    // Abre a query antes de exibir o relatório
    fmRelatorioProduto.qrProdutos.Open;
    // Exibe a visualização do relatório de produtos
    fmRelatorioProduto.RLReport1.Preview;
  finally
    // Libera o formulário da memória após o uso
    fmRelatorioProduto.Free;
  end;
end;

{ Evento disparado ao clicar no menu "Relatório de Estoque" }
procedure TfmPrincipal.Estoque1Click(Sender: TObject);
begin
  // Cria o formulário de relatório de movimento de estoque
  fmRelatorioMovimentoEstoque := TfmRelatorioMovimentoEstoque.Create(Self);
  try
    // Abre a query antes de exibir o relatório
    fmRelatorioMovimentoEstoque.qrDados.Open;
    // Exibe a visualização do relatório de movimento de estoque
    fmRelatorioMovimentoEstoque.rpMovimentos.Preview;
  finally
    // Libera o formulário da memória após o uso
    fmRelatorioMovimentoEstoque.Free;
  end;
end;

{ Evento disparado ao clicar no menu "Usuários" }
procedure TfmPrincipal.Usurios1Click(Sender: TObject);
begin
  if fmCadastroUsuarios = nil then
    fmCadastroUsuarios := TfmCadastroUsuarios.Create(Self); // Instancia o formulário, se necessário

  fmCadastroUsuarios.Show; // Exibe o formulário de cadastro de usuários
end;

{ Evento disparado ao clicar no menu "Vendas" }
procedure TfmPrincipal.Vendas1Click(Sender: TObject);
begin
  // Cria o formulário de relatório de vendas
  fmRelatorioVendas := TfmRelatorioVendas.Create(Self);
  try
    // Abre a query antes de exibir o relatório
    fmRelatorioVendas.qrPedidos.Open;
    // Exibe a visualização do relatório de vendas
    fmRelatorioVendas.RLReport1.Preview;
  finally
    // Libera o formulário da memória após o uso
    fmRelatorioVendas.Free;
  end;
end;

{ Evento disparado ao clicar no menu "Sair" }
procedure TfmPrincipal.Sair1Click(Sender: TObject);
begin
  // Exibe um diálogo de confirmação antes de sair do sistema
  if MessageDlg('Tem certeza que deseja sair do sistema?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Application.Terminate; // Encerra a aplicação
  end;
end;

{ Evento disparado ao criar o formulário principal }
procedure TfmPrincipal.FormCreate(Sender: TObject);
begin
  // Inicializações podem ser colocadas aqui, se necessário
end;

{ Evento disparado ao clicar no menu "Pedidos" }
procedure TfmPrincipal.mnuPedidos1Click(Sender: TObject);
begin
  if fmCadastroPedido = nil then
    fmCadastroPedido := TfmCadastroPedido.Create(Self); // Instancia o formulário de cadastro de pedidos, se necessário

  fmCadastroPedido.Show; // Exibe o formulário de cadastro de pedidos
end;

end.


