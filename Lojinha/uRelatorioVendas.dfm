object fmRelatorioVendas: TfmRelatorioVendas
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dsPedidos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 40
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 264
        Top = 10
        Width = 190
        Height = 24
        Caption = 'Relat'#243'rio de Vendas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 78
      Width = 718
      Height = 30
      BandType = btColumnHeader
      object RLLabel2: TRLLabel
        Left = 10
        Top = 10
        Width = 40
        Height = 16
        Caption = 'Cliente'
      end
      object RLLabel3: TRLLabel
        Left = 200
        Top = 10
        Width = 80
        Height = 16
        Caption = 'Data Pedido'
      end
      object RLLabel4: TRLLabel
        Left = 350
        Top = 10
        Width = 70
        Height = 16
        Caption = 'Quantidade'
      end
      object RLLabel5: TRLLabel
        Left = 450
        Top = 10
        Width = 40
        Height = 16
        Caption = 'Valor'
      end
      object RLLabel6: TRLLabel
        Left = 550
        Top = 10
        Width = 40
        Height = 16
        Caption = 'Total'
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 108
      Width = 718
      Height = 30
      object RLDBText1: TRLDBText
        Left = 10
        Top = 10
        Width = 150
        Height = 16
        DataField = 'CLIENTE'
        DataSource = dsPedidos
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 200
        Top = 10
        Width = 120
        Height = 16
        DataField = 'DATA_PEDIDO'
        DataSource = dsPedidos
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 350
        Top = 10
        Width = 80
        Height = 16
        DataField = 'QUANTIDADE'
        DataSource = dsPedidos
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 450
        Top = 10
        Width = 80
        Height = 16
        DataField = 'VALOR'
        DataSource = dsPedidos
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 550
        Top = 10
        Width = 80
        Height = 16
        DataField = 'TOTAL'
        DataSource = dsPedidos
        Text = ''
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 138
      Width = 718
      Height = 40
      BandType = btFooter
      object RLDBResult1: TRLDBResult
        Left = 550
        Top = 10
        Width = 80
        Height = 16
        DataField = 'TOTAL'
        DataSource = dsPedidos
        Info = riSum
        Text = ''
      end
      object RLLabel7: TRLLabel
        Left = 450
        Top = 10
        Width = 90
        Height = 16
        Caption = 'Total Geral:'
      end
    end
  end
  object qrPedidos: TFDQuery
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
    Left = 40
    Top = 400
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
    object qrPedidosINTENSPEDIDO_ID: TIntegerField
      FieldName = 'INTENSPEDIDO_ID'
      Origin = 'INTENSPEDIDO_ID'
    end
    object qrPedidosTOTAL: TSingleField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
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
    object qrPedidosID_ITEM: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_ITEM'
      Origin = 'ID_ITEM'
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
  end
  object dsPedidos: TDataSource
    DataSet = qrPedidos
    Left = 120
    Top = 400
  end
end
