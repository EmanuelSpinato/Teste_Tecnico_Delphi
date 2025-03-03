unit uRelatorioProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, RLFilters, RLPDFFilter;

type
  TfmRelatorioProduto = class(TForm)
    qrProdutos: TFDQuery;
    dsProdutos: TDataSource;
    RLReport1: TRLReport;
    RLBand1: TRLBand; // Cabeçalho do relatório
    RLLabel1: TRLLabel; // Título do relatório
    RLBand2: TRLBand; // Cabeçalho das colunas
    RLLabel2: TRLLabel; // Coluna ID
    RLLabel3: TRLLabel; // Coluna Nome
    RLLabel4: TRLLabel; // Coluna Categoria
    RLLabel5: TRLLabel; // Coluna Valor
    RLBand3: TRLBand; // Detalhes
    RLDBText1: TRLDBText; // Campo ID
    RLDBText2: TRLDBText; // Campo Nome
    RLDBText3: TRLDBText; // Campo Categoria
    RLDBText4: TRLDBText; // Campo Valor
    RLBand4: TRLBand; // Rodapé
    RLDBResult1: TRLDBResult;
    qrProdutosID: TIntegerField;
    qrProdutosNOME: TStringField;
    qrProdutosCATEGORIA: TStringField;
    qrProdutosVALOR: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelatorioProduto: TfmRelatorioProduto;

implementation

{$R *.dfm}

uses udmPrincipal;

procedure TfmRelatorioProduto.FormCreate(Sender: TObject);
begin
  qrProdutos.SQL.Text := 'SELECT ' +
                         'P.ID, ' +
                         'P.NOME, ' +
                         'C.DESCRICAO AS CATEGORIA, ' +
                         'P.VALOR ' +
                         'FROM PRODUTOS P ' +
                         'JOIN CATEGORIAS C ON C.ID = P.CATEGORIA_ID ' +
                         'ORDER BY P.ID';
  qrProdutos.Prepare;
end;

procedure TfmRelatorioProduto.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  qrProdutos.Open; // Abre a query antes de gerar o relatório
end;

end.

