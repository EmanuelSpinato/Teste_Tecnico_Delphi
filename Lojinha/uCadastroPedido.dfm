object fmCadastroPedido: TfmCadastroPedido
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pedido'
  ClientHeight = 450
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 574
    Height = 450
    ActivePage = tsGrid
    Align = alClient
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    object tsGrid: TTabSheet
      Caption = 'Visualizar'
      object pnButtonsGrid: TPanel
        Left = 477
        Top = 0
        Width = 89
        Height = 420
        Align = alRight
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object btInserir: TButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Inserir'
          TabOrder = 0
          OnClick = btInserirClick
        end
        object btEditar: TButton
          Left = 8
          Top = 36
          Width = 75
          Height = 25
          Caption = 'Editar'
          TabOrder = 1
          OnClick = btEditarClick
        end
        object btExcluir: TButton
          Left = 8
          Top = 64
          Width = 75
          Height = 25
          Caption = 'Excluir'
          TabOrder = 2
        end
      end
      object grDados: TDBGrid
        Left = 0
        Top = 0
        Width = 477
        Height = 420
        Align = alClient
        DataSource = dsPedidos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Width = 27
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLIENTE'
            Width = 206
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRODUTO'
            Width = 126
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_PEDIDO'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'QUANTIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL'
            Visible = True
          end>
      end
    end
    object tsEdits: TTabSheet
      Caption = 'Editar'
      ImageIndex = 1
      object pnButtonsEdits: TPanel
        Left = 477
        Top = 0
        Width = 89
        Height = 420
        Align = alRight
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 1
        object btSalvar: TButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Salvar'
          TabOrder = 0
          OnClick = btSalvarClick
        end
        object btCancelar: TButton
          Left = 8
          Top = 36
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = btCancelarClick
        end
      end
      object pnEdits: TPanel
        Left = 0
        Top = 0
        Width = 477
        Height = 420
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 8
          Width = 10
          Height = 15
          Caption = 'Id'
          FocusControl = edIdPedido
        end
        object Label2: TLabel
          Left = 16
          Top = 48
          Width = 37
          Height = 15
          Caption = 'Cliente'
        end
        object Label3: TLabel
          Left = 16
          Top = 90
          Width = 81
          Height = 15
          Caption = 'Data do Pedido'
          FocusControl = edIdPedido
        end
        object Label4: TLabel
          Left = 16
          Top = 134
          Width = 68
          Height = 15
          Caption = 'Lista de itens'
          FocusControl = edIdPedido
        end
        object edIdPedido: TDBEdit
          Left = 16
          Top = 24
          Width = 65
          Height = 23
          DataField = 'ID'
          DataSource = dsPedidos
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object DbCbCliente: TDBLookupComboBox
          Left = 16
          Top = 65
          Width = 400
          Height = 23
          DataField = 'CLIENTE_ID'
          DataSource = dsPedidos
          KeyField = 'ID'
          ListField = 'NOME'
          ListSource = dsClientes
          TabOrder = 1
        end
        object DtpPedido: TDateTimePicker
          Left = 16
          Top = 107
          Width = 82
          Height = 23
          Date = 45707.000000000000000000
          Time = 0.665728043983108400
          TabOrder = 2
        end
      end
      object TdbgItens: TDBGrid
        Left = 16
        Top = 155
        Width = 497
        Height = 244
        BiDiMode = bdLeftToRight
        DataSource = dsItensPedidos
        ParentBiDiMode = False
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ID_ITEM'
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            ReadOnly = False
            Width = 160
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'QUANTIDADE'
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            ReadOnly = False
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL_ITEM'
            Width = 94
            Visible = True
          end>
      end
    end
  end
  object qrItensPedidos: TFDQuery
    OnCalcFields = qrItensPedidosCalcFields
    Connection = dmPrincipal.fdConn
    SQL.Strings = (
      'SELECT i.ID_ITEM, p.NOME, p.VALOR, i.QUANTIDADE, i.ID_PRODUTO'
      'FROM ITENSPEDIDO i'
      'INNER JOIN PRODUTOS p ON i.ID_PRODUTO = p.ID'
      'ORDER BY i.ID_ITEM;'
      '')
    Left = 118
    Top = 40
    object qrItensPedidosQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
    end
    object qrItensPedidosNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qrItensPedidosVALOR: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object qrItensPedidosTOTAL_ITEM: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TOTAL_ITEM'
      Calculated = True
    end
    object qrItensPedidosID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
    end
    object qrItensPedidosID_ITEM: TIntegerField
      FieldName = 'ID_ITEM'
      Required = True
    end
  end
  object qrPedidos: TFDQuery
    Active = True
    Connection = dmPrincipal.fdConn
    SQL.Strings = (
      
        'SELECT P.ID, P.DATA_PEDIDO, P.CLIENTE_ID, P.INTENSPEDIDO_ID, P.T' +
        'OTAL,'
      'C.NOME AS CLIENTE,'
      'I.QUANTIDADE,'
      'i.ID_ITEM, '
      'PR.NOME AS PRODUTO,'
      'PR.VALOR,'
      'CA.DESCRICAO'
      'FROM PEDIDOS p'
      'JOIN CLIENTES c ON c.ID = p.CLIENTE_ID'
      'JOIN ITENSPEDIDO i ON i.ID_ITEM = p.INTENSPEDIDO_ID'
      'JOIN PRODUTOS pr ON pr.ID = i.ID_PRODUTO'
      'JOIN CATEGORIAS ca ON ca.ID = pr.CATEGORIA_ID'
      'ORDER BY P.ID;')
    Left = 278
    Top = 40
    object qrPedidosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrPedidosDATA_PEDIDO: TDateField
      FieldName = 'DATA_PEDIDO'
      Origin = 'DATA_PEDIDO'
      Required = True
    end
    object qrPedidosCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
      Origin = 'CLIENTE_ID'
      Required = True
    end
    object qrPedidosCLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qrPedidosQUANTIDADE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      ProviderFlags = []
      ReadOnly = True
    end
    object qrPedidosPRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PRODUTO'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qrPedidosVALOR: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object qrPedidosDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qrPedidosTOTAL: TSingleField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
    end
    object qrPedidosINTENSPEDIDO_ID: TIntegerField
      FieldName = 'INTENSPEDIDO_ID'
      Origin = 'INTENSPEDIDO_ID'
    end
    object qrPedidosID_ITEM: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_ITEM'
      Origin = 'ID_ITEM'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object qrClientes: TFDQuery
    Active = True
    Connection = dmPrincipal.fdConn
    SQL.Strings = (
      'SELECT a.ID, a.NOME, a.ENDERECO, a.EMAIL, a.CPF, a.TELEFONE'
      'FROM CLIENTES a')
    Left = 314
    Top = 112
    object qrClientesID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object qrClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Required = True
      Size = 100
    end
    object qrClientesEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Required = True
      Size = 100
    end
    object qrClientesCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      FixedChar = True
      Size = 11
    end
    object qrClientesTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
    end
  end
  object dsClientes: TDataSource
    DataSet = qrClientes
    Left = 410
    Top = 112
  end
  object dsPedidos: TDataSource
    DataSet = qrPedidos
    Left = 362
    Top = 40
  end
  object dsItensPedidos: TDataSource
    DataSet = qrItensPedidos
    Left = 202
    Top = 40
  end
end
