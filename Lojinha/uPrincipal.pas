unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, RLReport; // Adicionei RLReport para relat�rios

type
  // Classe principal do formul�rio
  TfmPrincipal = class(TForm)
    mmPrincipal: TMainMenu; // Menu principal da aplica��o
    Cadastros1: TMenuItem;  // Menu de cadastros
    Clientes1: TMenuItem;   // Submenu de Clientes
    Fornecedores1: TMenuItem; // Submenu de Fornecedores
    Produtos1: TMenuItem;   // Submenu de Produtos
    Categorias1: TMenuItem; // Submenu de Categorias
    mnuPedidos1: TMenuItem;  // Submenu de Pedidos (nome atualizado para boas pr�ticas)
    N1: TMenuItem;          // Separador de menu
    Sair1: TMenuItem;       // Op��o para sair do sistema
    Movimentos1: TMenuItem;     // Submenu de Vendas
    Relatrios1: TMenuItem;  // Menu de Relat�rios
    Estoque1: TMenuItem;    // Submenu de Relat�rio de Estoque
    sbPrincipal: TStatusBar; // Barra de status para mensagens e status da aplica��o
    Estoque2: TMenuItem;    // Submenu de estoque (entradas/sa�das)
    Entradas1: TMenuItem;   // Submenu de entradas de estoque
    Sadas1: TMenuItem;      // Submenu de sa�das de estoque
    ListagemProdutos1: TMenuItem; // Submenu de listagem de produtos
    Usurios1: TMenuItem;    // Submenu de usu�rios
    Vendas1: TMenuItem;     // Submenu de vendas
    // M�todos que tratam o clique nos menus
    procedure Clientes1Click(Sender: TObject);
    procedure Categorias1Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Entradas1Click(Sender: TObject);
    procedure ListagemProdutos1Click(Sender: TObject);
    procedure Estoque1Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject); // Evento de cria��o do formul�rio
    procedure mnuPedidos1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject); // M�todo para o menu de vendas
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
    fmCadastroClientes := TfmCadastroClientes.Create(Self); // Instancia o formul�rio, se necess�rio

  fmCadastroClientes.Show; // Exibe o formul�rio de cadastro de clientes
end;

{ Evento disparado ao clicar no menu "Categorias" }
procedure TfmPrincipal.Categorias1Click(Sender: TObject);
begin
  if fmCadastroCategorias = nil then
    fmCadastroCategorias := TfmCadastroCategorias.Create(Self); // Instancia o formul�rio, se necess�rio

  fmCadastroCategorias.Show; // Exibe o formul�rio de cadastro de categorias
end;

{ Evento disparado ao clicar no menu "Fornecedores" }
procedure TfmPrincipal.Fornecedores1Click(Sender: TObject);
begin
  if fmCadastroFornecedores = nil then
    fmCadastroFornecedores := TfmCadastroFornecedores.Create(Self); // Instancia o formul�rio, se necess�rio

  fmCadastroFornecedores.Show; // Exibe o formul�rio de cadastro de fornecedores
end;

{ Evento disparado ao clicar no menu "Produtos" }
procedure TfmPrincipal.Produtos1Click(Sender: TObject);
begin
  if fmCadastroProdutos = nil then
    fmCadastroProdutos := TfmCadastroProdutos.Create(Self); // Instancia o formul�rio, se necess�rio

  fmCadastroProdutos.Show; // Exibe o formul�rio de cadastro de produtos
end;

{ Evento disparado ao clicar no menu "Entradas de Estoque" }
procedure TfmPrincipal.Entradas1Click(Sender: TObject);
begin
  if fmMovimentoEstoqueEntrada = nil then
    fmMovimentoEstoqueEntrada := TfmMovimentoEstoqueEntrada.Create(Self); // Instancia o formul�rio, se necess�rio

  fmMovimentoEstoqueEntrada.Show; // Exibe o formul�rio de movimenta��o de entradas de estoque
end;

{ Evento disparado ao clicar no menu "Relat�rio de Produtos" }
procedure TfmPrincipal.ListagemProdutos1Click(Sender: TObject);
begin
  // Cria o formul�rio de relat�rio de produtos
  fmRelatorioProduto := TfmRelatorioProduto.Create(Self);
  try
    // Abre a query antes de exibir o relat�rio
    fmRelatorioProduto.qrProdutos.Open;
    // Exibe a visualiza��o do relat�rio de produtos
    fmRelatorioProduto.RLReport1.Preview;
  finally
    // Libera o formul�rio da mem�ria ap�s o uso
    fmRelatorioProduto.Free;
  end;
end;

{ Evento disparado ao clicar no menu "Relat�rio de Estoque" }
procedure TfmPrincipal.Estoque1Click(Sender: TObject);
begin
  // Cria o formul�rio de relat�rio de movimento de estoque
  fmRelatorioMovimentoEstoque := TfmRelatorioMovimentoEstoque.Create(Self);
  try
    // Abre a query antes de exibir o relat�rio
    fmRelatorioMovimentoEstoque.qrDados.Open;
    // Exibe a visualiza��o do relat�rio de movimento de estoque
    fmRelatorioMovimentoEstoque.rpMovimentos.Preview;
  finally
    // Libera o formul�rio da mem�ria ap�s o uso
    fmRelatorioMovimentoEstoque.Free;
  end;
end;

{ Evento disparado ao clicar no menu "Usu�rios" }
procedure TfmPrincipal.Usurios1Click(Sender: TObject);
begin
  if fmCadastroUsuarios = nil then
    fmCadastroUsuarios := TfmCadastroUsuarios.Create(Self); // Instancia o formul�rio, se necess�rio

  fmCadastroUsuarios.Show; // Exibe o formul�rio de cadastro de usu�rios
end;

{ Evento disparado ao clicar no menu "Vendas" }
procedure TfmPrincipal.Vendas1Click(Sender: TObject);
begin
  // Cria o formul�rio de relat�rio de vendas
  fmRelatorioVendas := TfmRelatorioVendas.Create(Self);
  try
    // Abre a query antes de exibir o relat�rio
    fmRelatorioVendas.qrPedidos.Open;
    // Exibe a visualiza��o do relat�rio de vendas
    fmRelatorioVendas.RLReport1.Preview;
  finally
    // Libera o formul�rio da mem�ria ap�s o uso
    fmRelatorioVendas.Free;
  end;
end;

{ Evento disparado ao clicar no menu "Sair" }
procedure TfmPrincipal.Sair1Click(Sender: TObject);
begin
  // Exibe um di�logo de confirma��o antes de sair do sistema
  if MessageDlg('Tem certeza que deseja sair do sistema?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Application.Terminate; // Encerra a aplica��o
  end;
end;

{ Evento disparado ao criar o formul�rio principal }
procedure TfmPrincipal.FormCreate(Sender: TObject);
begin
  // Inicializa��es podem ser colocadas aqui, se necess�rio
end;

{ Evento disparado ao clicar no menu "Pedidos" }
procedure TfmPrincipal.mnuPedidos1Click(Sender: TObject);
begin
  if fmCadastroPedido = nil then
    fmCadastroPedido := TfmCadastroPedido.Create(Self); // Instancia o formul�rio de cadastro de pedidos, se necess�rio

  fmCadastroPedido.Show; // Exibe o formul�rio de cadastro de pedidos
end;

end.


