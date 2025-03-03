unit uRelatorioVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, RLFilters, RLPDFFilter;

type
  TfmRelatorioVendas = class(TForm)
    qrPedidos: TFDQuery;
    dsPedidos: TDataSource;
    RLReport1: TRLReport;
    RLBand1: TRLBand; // Cabeçalho do relatório
    RLLabel1: TRLLabel; // Título do relatório
    RLBand2: TRLBand; // Cabeçalho das colunas
    RLLabel2: TRLLabel; // Coluna ID
    RLLabel3: TRLLabel; // Coluna Data
    RLLabel4: TRLLabel; // Coluna Cliente
    RLLabel5: TRLLabel; // Coluna Total
    RLBand3: TRLBand; // Detalhes
    RLDBText1: TRLDBText; // Campo ID
    RLDBText2: TRLDBText; // Campo Data
    RLDBText3: TRLDBText; // Campo Cliente
    RLDBText4: TRLDBText; // Campo Total
    RLBand4: TRLBand; // Rodapé
    RLDBResult1: TRLDBResult;
    qrPedidosID: TIntegerField;
    qrPedidosDATA_PEDIDO: TDateField;
    qrPedidosCLIENTE_ID: TIntegerField;
    qrPedidosINTENSPEDIDO_ID: TIntegerField;
    qrPedidosTOTAL: TSingleField;
    qrPedidosCLIENTE: TStringField;
    qrPedidosQUANTIDADE: TIntegerField;
    qrPedidosID_ITEM: TIntegerField;
    qrPedidosPRODUTO: TStringField;
    qrPedidosVALOR: TFMTBCDField;
    qrPedidosDESCRICAO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelatorioVendas: TfmRelatorioVendas;

implementation

{$R *.dfm}

uses udmPrincipal;

procedure TfmRelatorioVendas.FormCreate(Sender: TObject);
begin
  qrPedidos.SQL.Text := 'SELECT ' +
                         'P.ID, ' +
                         'P.DATA_PEDIDO, ' +
                         'P.CLIENTE_ID, ' +
                         'P.INTENSPEDIDO_ID, ' +
                         'P.TOTAL, ' +
                         'C.NOME AS CLIENTE, ' +
                         'I.QUANTIDADE, ' +
                         'I.ID_ITEM, ' +
                         'PR.NOME AS PRODUTO, ' +
                         'PR.VALOR, ' +
                         'CA.DESCRICAO ' +
                         'FROM PEDIDOS P ' +
                         'JOIN CLIENTES C ON C.ID = P.CLIENTE_ID ' +
                         'JOIN ITENSPEDIDO I ON I.ID_ITEM = P.INTENSPEDIDO_ID ' +
                         'JOIN PRODUTOS PR ON PR.ID = I.ID_PRODUTO ' +
                         'JOIN CATEGORIAS CA ON CA.ID = PR.CATEGORIA_ID ' +
                         'ORDER BY P.ID';
  qrPedidos.Prepare;
end;

procedure TfmRelatorioVendas.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  qrPedidos.Open; // Abre a query antes de gerar o relatório
end;

end.
