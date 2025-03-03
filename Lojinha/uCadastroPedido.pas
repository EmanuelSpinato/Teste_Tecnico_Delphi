unit uCadastroPedido;

interface

uses
  System.UITypes, // Adicionado para corrigir o erro H2443
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TfmCadastroPedido = class(TForm)
    qrItensPedidos: TFDQuery;
    qrPedidos: TFDQuery;
    qrClientes: TFDQuery;
    dsClientes: TDataSource;
    dsPedidos: TDataSource;
    qrClientesID: TIntegerField;
    qrClientesNOME: TStringField;
    qrClientesENDERECO: TStringField;
    qrClientesEMAIL: TStringField;
    qrClientesCPF: TStringField;
    qrClientesTELEFONE: TStringField;
    qrPedidosID: TIntegerField; // Campo ID da tabela PEDIDOS
    qrPedidosDATA_PEDIDO: TDateField;
    qrPedidosCLIENTE_ID: TIntegerField;
    qrPedidosINTENSPEDIDO_ID: TIntegerField; // Campo INTENSPEDIDO_ID da tabela PEDIDOS
    dsItensPedidos: TDataSource;
    pcPrincipal: TPageControl;
    tsGrid: TTabSheet;
    pnButtonsGrid: TPanel;
    btInserir: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    grDados: TDBGrid;
    tsEdits: TTabSheet;
    pnButtonsEdits: TPanel;
    btSalvar: TButton;
    btCancelar: TButton;
    pnEdits: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edIdPedido: TDBEdit;
    DbCbCliente: TDBLookupComboBox;
    DtpPedido: TDateTimePicker;
    qrItensPedidosID_ITEM: TIntegerField; // Campo ID_ITEM da tabela ITENSPEDIDO
    qrItensPedidosID_PRODUTO: TIntegerField;
    qrItensPedidosQUANTIDADE: TIntegerField;
    TdbgItens: TDBGrid;
    Label4: TLabel;
    qrItensPedidosTOTAL_ITEM: TFloatField;
    qrPedidosCLIENTE: TStringField;
    qrPedidosQUANTIDADE: TIntegerField;
    qrPedidosPRODUTO: TStringField;
    qrPedidosDESCRICAO: TStringField;
    qrItensPedidosVALOR: TFMTBCDField;
    qrPedidosTOTAL: TSingleField;
    procedure btInserirClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qrItensPedidosCalcFields(DataSet: TDataSet);
    procedure qrPedidosCalcFields(DataSet: TDataSet);
    procedure TdbgItensCellExit(Sender: TObject; ACol, ARow: Integer);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure qrItensPedidosAfterPost(DataSet: TDataSet);
    procedure qrItensPedidosAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    procedure CarregarDados;
    procedure HabilitarEdicao(Habilitar: Boolean);
    procedure ConfigurarDbCbCliente;
    procedure AtualizarTotalItem(ARow: Integer);
    function ProximoID: Integer;
    procedure AlternarAbas(ExibirEdits: Boolean);
    procedure AtualizarTotalPedidoNoBanco(PedidoID: Integer);
  public
    { Public declarations }
  end;

var
  fmCadastroPedido: TfmCadastroPedido;

implementation

{$R *.dfm}

// Evento do botão Inserir
procedure TfmCadastroPedido.btInserirClick(Sender: TObject);
var
  ClienteID: Integer;
begin
  // Verifica se um cliente foi selecionado
  if VarIsNull(DbCbCliente.KeyValue) then
  begin
    ShowMessage('Selecione um cliente antes de inserir um pedido.');
    Exit; // Sai do procedimento sem inserir o pedido
  end;

  // Converte o valor de DbCbCliente.KeyValue para Integer
  ClienteID := DbCbCliente.KeyValue;

  if not qrPedidos.Active then
    qrPedidos.Open;

  qrPedidos.Append; // Inicia a inserção de um novo registro
  try
    // Atribui o próximo ID disponível
    qrPedidosID.AsInteger := ProximoID;

    // Define a data do pedido como a data atual
    qrPedidos.FieldByName('DATA_PEDIDO').AsDateTime := Date;

    // Define o CLIENTE_ID com base no valor selecionado no DBLookupComboBox
    qrPedidos.FieldByName('CLIENTE_ID').AsInteger := ClienteID;

    // Atribui o ID_ITEM selecionado ao campo INTENSPEDIDO_ID
    qrPedidos.FieldByName('INTENSPEDIDO_ID').AsInteger := qrItensPedidosID_ITEM.AsInteger;

    // Inicializa o TOTAL como 0 (será atualizado posteriormente)
    qrPedidos.FieldByName('TOTAL').AsFloat := 0;

    // Salva o registro no banco de dados
    qrPedidos.Post;

    // Atualiza o DataSource para exibir o novo registro no DBGrid
    qrPedidos.Refresh;

    // Habilita a edição e alterna para a aba de edição
    HabilitarEdicao(True);
    AlternarAbas(True);
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao atribuir valores ao pedido: ' + E.Message);
      qrPedidos.Cancel; // Cancela a inserção em caso de erro
      Exit;
    end;
  end;
end;

// Evento do botão Editar
procedure TfmCadastroPedido.btEditarClick(Sender: TObject);
begin
  if qrPedidos.RecordCount > 0 then
  begin
    qrPedidos.Edit;
    HabilitarEdicao(True);
    AlternarAbas(True);
  end;
end;

// Evento do botão Salvar
procedure TfmCadastroPedido.btSalvarClick(Sender: TObject);
var
  NovoPedidoID: Integer;
begin
  try
    qrPedidos.Connection.StartTransaction;

    if qrPedidos.State in [dsInsert, dsEdit] then
    begin
      qrPedidos.FieldByName('DATA_PEDIDO').AsDateTime := Date;
      qrPedidos.FieldByName('CLIENTE_ID').AsInteger := DbCbCliente.KeyValue;

      // Verifica se há um item selecionado no grid TdbgItens
      if not qrItensPedidos.IsEmpty then
      begin
        // Atribui o ID_ITEM selecionado ao campo INTENSPEDIDO_ID
        qrPedidos.FieldByName('INTENSPEDIDO_ID').AsInteger := qrItensPedidosID_ITEM.AsInteger;
      end;

      // Salva o pedido
      qrPedidos.Post;
      NovoPedidoID := qrPedidosID.AsInteger;

      // Atualiza o TOTAL do pedido no banco de dados
      AtualizarTotalPedidoNoBanco(NovoPedidoID);

      // Confirma a transação
      qrPedidos.Connection.Commit;

      ShowMessage('Pedido salvo com sucesso!');
      HabilitarEdicao(False);
      AlternarAbas(False);
    end;
  except
    on E: Exception do
    begin
      // Reverte a transação em caso de erro
      qrPedidos.Connection.Rollback;
      ShowMessage('Erro ao salvar o pedido: ' + E.Message);
    end;
  end;
end;

// Evento do botão Cancelar
procedure TfmCadastroPedido.btCancelarClick(Sender: TObject);
begin
  if qrPedidos.State in [dsInsert, dsEdit] then
    qrPedidos.Cancel;

  HabilitarEdicao(False);
  AlternarAbas(False);
end;

// Evento do botão Excluir
procedure TfmCadastroPedido.btExcluirClick(Sender: TObject);
var
  PedidoID: Integer;
begin
  if qrPedidos.RecordCount > 0 then
  begin
    if MessageDlg('Deseja realmente excluir este pedido e todos os seus itens?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      PedidoID := qrPedidosID.AsInteger;

      try
        qrPedidos.Connection.StartTransaction;

        // Exclui os itens do pedido
        with TFDQuery.Create(nil) do
        try
          Connection := qrPedidos.Connection;
          SQL.Text := 'DELETE FROM ITENSPEDIDO WHERE ID_ITEM = :ID_ITEM';
          Params.ParamByName('ID_ITEM').AsInteger := PedidoID;
          ExecSQL;
        finally
          Free;
        end;

        // Exclui o pedido
        with TFDQuery.Create(nil) do
        try
          Connection := qrPedidos.Connection;
          SQL.Text := 'DELETE FROM PEDIDOS WHERE ID = :ID';
          Params.ParamByName('ID').AsInteger := PedidoID;
          ExecSQL;
        finally
          Free;
        end;

        // Confirma a transação
        qrPedidos.Connection.Commit;

        // Atualiza os datasets
        qrPedidos.Close;
        qrPedidos.Open;
        qrItensPedidos.Close;
        qrItensPedidos.Open;

        ShowMessage('Pedido e itens excluídos com sucesso!');
      except
        on E: Exception do
        begin
          // Reverte a transação em caso de erro
          qrPedidos.Connection.Rollback;
          ShowMessage('Erro ao excluir o pedido: ' + E.Message);
        end;
      end;
    end;
  end
  else
  begin
    ShowMessage('Nenhum pedido selecionado para exclusão.');
  end;
end;

// Inicialização do formulário
procedure TfmCadastroPedido.FormCreate(Sender: TObject);
begin
  CarregarDados;
  ConfigurarDbCbCliente;
  HabilitarEdicao(False);
  AlternarAbas(False);
  DtpPedido.Date := Date;

  // Associar eventos ao qrItensPedidos
  qrItensPedidos.AfterPost := qrItensPedidosAfterPost;
  qrItensPedidos.AfterDelete := qrItensPedidosAfterDelete;

  // Associar evento de campos calculados ao qrPedidos
  qrPedidos.OnCalcFields := qrPedidosCalcFields;

  // Configuração das colunas do grDados
  grDados.Columns[7].FieldName := 'TOTAL';
  grDados.Columns[7].Title.Caption := 'Total do Pedido';
end;

// Exibição do formulário
procedure TfmCadastroPedido.FormShow(Sender: TObject);
begin
  qrClientes.Open;
  qrPedidos.Open;
  qrItensPedidos.Open;
end;

// Funções Auxiliares
procedure TfmCadastroPedido.CarregarDados;
begin
  qrClientes.Open;
  qrPedidos.Open;
  qrItensPedidos.Open;
end;

procedure TfmCadastroPedido.HabilitarEdicao(Habilitar: Boolean);
begin
  pnEdits.Enabled := Habilitar;
  pnButtonsEdits.Enabled := Habilitar;
  pnButtonsGrid.Enabled := not Habilitar;
  grDados.Enabled := not Habilitar;
end;

procedure TfmCadastroPedido.ConfigurarDbCbCliente;
begin
  DbCbCliente.ListSource := dsClientes;
  DbCbCliente.ListField := 'NOME';
  DbCbCliente.KeyField := 'ID';
  DbCbCliente.DataSource := dsPedidos;
  DbCbCliente.DataField := 'CLIENTE_ID';
end;

// Cálculo do TOTAL_ITEM
procedure TfmCadastroPedido.qrItensPedidosCalcFields(DataSet: TDataSet);
begin
  qrItensPedidosTOTAL_ITEM.AsFloat := qrItensPedidosQUANTIDADE.AsInteger * qrItensPedidosVALOR.AsFloat;

  // Atualiza o TotalPedido com o valor do TOTAL_ITEM do item selecionado
  if qrPedidos.State in [dsEdit, dsInsert] then
  begin
    qrPedidos.Edit;
    qrPedidosTOTAL.AsFloat := qrItensPedidosTOTAL_ITEM.AsFloat;
    qrPedidos.Post;
  end;
end;

// Cálculo do TOTAL
procedure TfmCadastroPedido.qrPedidosCalcFields(DataSet: TDataSet);
begin
  // Atribui o total calculado ao campo qrPedidosTOTAL
  if not qrItensPedidos.IsEmpty then
    qrPedidosTOTAL.AsFloat := qrItensPedidosTOTAL_ITEM.AsFloat
  else
    qrPedidosTOTAL.AsFloat := 0;
end;

procedure TfmCadastroPedido.TdbgItensCellExit(Sender: TObject; ACol, ARow: Integer);
begin
  AtualizarTotalItem(ARow);

  // Atualiza o TotalPedido com o valor do TOTAL_ITEM do item selecionado
  if qrPedidos.State in [dsEdit, dsInsert] then
  begin
    qrPedidos.Edit;
    qrPedidosTOTAL.AsFloat := qrItensPedidosTOTAL_ITEM.AsFloat;
    qrPedidos.Post;
  end;
end;

function TfmCadastroPedido.ProximoID: Integer;
begin
  Result := 1;
  with TFDQuery.Create(nil) do
  try
    Connection := qrPedidos.Connection;
    SQL.Text := 'SELECT MAX(ID) AS MAX_ID FROM PEDIDOS';
    Open;
    if FieldByName('MAX_ID').AsInteger > 0 then
      Result := FieldByName('MAX_ID').AsInteger + 1;
  finally
    Free;
  end;
end;

procedure TfmCadastroPedido.AlternarAbas(ExibirEdits: Boolean);
begin
  if ExibirEdits then
    pcPrincipal.ActivePage := tsEdits
  else
    pcPrincipal.ActivePage := tsGrid;
end;

procedure TfmCadastroPedido.AtualizarTotalItem(ARow: Integer);
begin
  if not qrItensPedidos.IsEmpty then
  begin
    qrItensPedidos.Edit;
    qrItensPedidosTOTAL_ITEM.AsFloat := qrItensPedidosVALOR.AsFloat * qrItensPedidosQUANTIDADE.AsInteger;
    qrItensPedidos.Post;
  end;
end;

// Atualiza o TOTAL do pedido no banco de dados
procedure TfmCadastroPedido.AtualizarTotalPedidoNoBanco(PedidoID: Integer);
var
  TotalPedido: Double;
begin
  TotalPedido := 0;

  // Atribui o TOTAL_ITEM do item selecionado ao TotalPedido
  if not qrItensPedidos.IsEmpty then
    TotalPedido := qrItensPedidosTOTAL_ITEM.AsFloat;

  // Atualiza o campo TOTAL na tabela PEDIDOS
  with TFDQuery.Create(nil) do
  try
    Connection := qrPedidos.Connection;
    SQL.Text := 'UPDATE PEDIDOS SET TOTAL = :TOTAL WHERE ID = :ID';
    Params.ParamByName('TOTAL').AsFloat := TotalPedido;
    Params.ParamByName('ID').AsInteger := PedidoID;
    ExecSQL;
  finally
    Free;
  end;

  // Atualiza o dataset para refletir as mudanças
  qrPedidos.Refresh;
end;

// Evento AfterPost do qrItensPedidos
procedure TfmCadastroPedido.qrItensPedidosAfterPost(DataSet: TDataSet);
begin
  // Atualiza o TOTAL do pedido no banco de dados
  if qrPedidos.State in [dsEdit, dsInsert] then
    AtualizarTotalPedidoNoBanco(qrPedidosID.AsInteger);
end;

// Evento AfterDelete do qrItensPedidos
procedure TfmCadastroPedido.qrItensPedidosAfterDelete(DataSet: TDataSet);
begin
  // Atualiza o TOTAL do pedido no banco de dados
  if qrPedidos.State in [dsEdit, dsInsert] then
    AtualizarTotalPedidoNoBanco(qrPedidosID.AsInteger);
end;

end.
