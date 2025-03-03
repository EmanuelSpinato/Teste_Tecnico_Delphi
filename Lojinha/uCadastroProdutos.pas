unit uCadastroProdutos;

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
  TfmCadastroProdutos = class(TfmCadastroBase)
    qrDadosNOME: TStringField;
    qrDadosVALOR: TFMTBCDField;
    qrDadosID: TFDAutoIncField;
    Label1: TLabel;
    edId: TDBEdit;
    Label2: TLabel;
    edNome: TDBEdit;
    Label3: TLabel;
    Valor: TDBEdit;
    btFornecedores: TButton;
    qrCategorias: TFDQuery;
    dsCategorias: TDataSource;
    qrCategoriasID: TIntegerField;
    qrCategoriasDESCRICAO: TStringField;
    lkCategoria: TDBLookupComboBox;
    lbCategoria: TLabel;
    qrDadosCATEGORIA_ID: TIntegerField;
    qrDadosCATEGORIA: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btFornecedoresClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure BeforeEdit; override;  // Sobrescreve o método BeforeEdit da classe base
    procedure BeforePost; override;  // Sobrescreve o método BeforePost da classe base
    function ValidarObrigatorios: boolean; override;
  public
  end;

var
  fmCadastroProdutos: TfmCadastroProdutos;

implementation

{$R *.dfm}

uses uCadastroProdutosFornecedores, udmPrincipal;

{ TfmCadastroProdutos }

procedure TfmCadastroProdutos.BeforeEdit;
begin
  // Implementação do que deve acontecer antes de editar
  // Aqui, você pode adicionar validações ou inicializações específicas
  ShowMessage('Antes de editar o produto!');
end;

procedure TfmCadastroProdutos.BeforePost;
begin
  // Implementação do que deve acontecer antes de salvar
  // Você pode adicionar verificações ou validações adicionais
  if qrDadosVALOR.AsCurrency <= 0 then
  begin
    ShowMessage('O valor do produto deve ser maior que zero.');
    Abort;  // Interrompe o processo de salvamento
  end;

  // Aqui você pode adicionar mais validações, como verificar a categoria ou outros campos
end;

procedure TfmCadastroProdutos.btFornecedoresClick(Sender: TObject);
begin
  inherited;

  fmCadastroProdutosFornecedores := TfmCadastroProdutosFornecedores.Create(Self);
  try
    fmCadastroProdutosFornecedores.edIdProduto.Text := qrDadosID.AsString;
    fmCadastroProdutosFornecedores.edNomeProduto.Text := qrDadosNOME.AsString;
    fmCadastroProdutosFornecedores.ShowModal;
  finally
    fmCadastroProdutosFornecedores.Free;
  end;
end;

procedure TfmCadastroProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fmCadastroProdutos := nil;
end;

procedure TfmCadastroProdutos.FormShow(Sender: TObject);
begin
  inherited;
  qrCategorias.Open;
end;

function TfmCadastroProdutos.ValidarObrigatorios: boolean;
begin
  if Trim(edNome.Text) = '' then
  begin
    ShowMessage('Informe o nome.');
    ednome.SetFocus;
    Exit(false);
  end;

  Result := inherited ValidarObrigatorios;
end;

end.

