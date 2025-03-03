object fmRelatorioProduto: TfmRelatorioProduto
  Left = 0
  Top = 0
  Caption = 'Relat'#195#179'rio de Produtos'
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
    DataSource = dsProdutos
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
        Left = 200
        Top = 10
        Width = 226
        Height = 24
        Caption = 'Relatorio de Produtos'
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
        Left = 42
        Top = 8
        Width = 44
        Height = 16
        Alignment = taCenter
        Caption = 'Codigo'
      end
      object RLLabel3: TRLLabel
        Left = 120
        Top = 10
        Width = 120
        Height = 16
        Caption = 'Nome Produto'
      end
      object RLLabel4: TRLLabel
        Left = 358
        Top = 6
        Width = 70
        Height = 16
        Caption = 'Categoria'
      end
      object RLLabel5: TRLLabel
        Left = 550
        Top = 2
        Width = 34
        Height = 16
        Caption = 'Valor'
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
        Width = 100
        Height = 16
        Alignment = taCenter
        DataField = 'ID'
        DataSource = dsProdutos
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 120
        Top = 6
        Width = 232
        Height = 16
        DataField = 'NOME'
        DataSource = dsProdutos
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 358
        Top = 6
        Width = 150
        Height = 16
        DataField = 'CATEGORIA'
        DataSource = dsProdutos
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 514
        Top = 6
        Width = 70
        Height = 16
        Alignment = taRightJustify
        DataField = 'VALOR'
        DataSource = dsProdutos
        Text = ''
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 138
      Width = 718
      Height = 40
      BandType = btFooter
      object RLLabel6: TRLLabel
        Left = 450
        Top = 10
        Width = 90
        Height = 16
        Caption = 'Total Pre'#195#167'o:'
      end
      object RLDBResult1: TRLDBResult
        Left = 550
        Top = 10
        Width = 70
        Height = 16
        DataField = 'VALOR'
        DataSource = dsProdutos
        Info = riSum
        Text = ''
      end
    end
  end
  object qrProdutos: TFDQuery
    Connection = dmPrincipal.fdConn
    SQL.Strings = (
      
        'SELECT p.ID, p.NOME, p.VALOR, c.DESCRICAO AS CATEGORIA FROM PROD' +
        'UTOS p JOIN CATEGORIAS c ON c.ID = p.CATEGORIA_ID ORDER BY p.ID;')
    Left = 40
    Top = 400
    object qrProdutosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrProdutosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qrProdutosVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object qrProdutosCATEGORIA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CATEGORIA'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object dsProdutos: TDataSource
    DataSet = qrProdutos
    Left = 120
    Top = 400
  end
end
