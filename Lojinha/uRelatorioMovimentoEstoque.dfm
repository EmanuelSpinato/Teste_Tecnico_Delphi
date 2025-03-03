object fmRelatorioMovimentoEstoque: TfmRelatorioMovimentoEstoque
  Left = 0
  Top = 0
  Caption = 'Relat'#195#179'rio de Movimenta'#195#167#195#163'o de Estoque'
  ClientHeight = 341
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object rpMovimentos: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = rpMovimentosBeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 40
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 264
        Top = 10
        Width = 206
        Height = 19
        Caption = 'Movimentacao de Estoque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 78
      Width = 718
      Height = 120
      BeforePrint = RLGroup1BeforePrint
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 24
        BandType = btHeader
        object RLLabel2: TRLLabel
          Left = 120
          Top = 4
          Width = 70
          Height = 16
          Caption = 'Produto'
        end
        object RLLabel3: TRLLabel
          Left = 450
          Top = 4
          Width = 74
          Height = 16
          Caption = 'Tipo'
        end
        object RLLabel4: TRLLabel
          Left = 530
          Top = 4
          Width = 80
          Height = 16
          Caption = 'Quantidade'
        end
        object RLLabel5: TRLLabel
          Left = 58
          Top = 5
          Width = 44
          Height = 16
          Caption = 'Codigo'
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 24
        Width = 718
        Height = 24
        BeforePrint = RLBand3BeforePrint
        object RLDBText1: TRLDBText
          Left = 50
          Top = 5
          Width = 64
          Height = 16
          Alignment = taCenter
          DataField = 'ID'
          DataSource = dsDados
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 120
          Top = 5
          Width = 324
          Height = 16
          DataField = 'NOME'
          DataSource = dsDados
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 450
          Top = 5
          Width = 74
          Height = 16
          DataField = 'TIPO_MOV_CF'
          DataSource = dsDados
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 530
          Top = 5
          Width = 80
          Height = 16
          Alignment = taCenter
          DataField = 'QUANTIDADE'
          DataSource = dsDados
          Text = ''
        end
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 198
      Width = 718
      Height = 40
      BandType = btFooter
      object RLDBResult1: TRLDBResult
        Left = 320
        Top = 10
        Width = 65
        Height = 16
        DataField = 'QUANTIDADE'
        DataSource = dsDados
        Info = riSum
        Text = ''
      end
      object RLLabel6: TRLLabel
        Left = 240
        Top = 10
        Width = 70
        Height = 16
        Caption = 'Total Geral:'
      end
      object RLLabel7: TRLLabel
        Left = 400
        Top = 10
        Width = 80
        Height = 16
        Caption = 'Total Entrada:'
      end
      object rlbTotalEntrada: TRLLabel
        Left = 490
        Top = 10
        Width = 90
        Height = 16
        BeforePrint = rlbTotalEntradaBeforePrint
      end
      object RLLabel9: TRLLabel
        Left = 400
        Top = 30
        Width = 70
        Height = 16
        Caption = 'Total Sa'#195#173'da:'
      end
      object rlbTotalSaida: TRLLabel
        Left = 490
        Top = 30
        Width = 90
        Height = 16
        BeforePrint = rlbTotalSaidaBeforePrint
      end
    end
  end
  object qrDados: TFDQuery
    Active = True
    OnCalcFields = qrDadosCalcFields
    Connection = dmPrincipal.fdConn
    SQL.Strings = (
      'SELECT PRO.ID,'
      '       PRO.NOME,'
      '       EST.TIPO,'
      '       EST.QUANTIDADE,'
      '       EST.DATA_MOVIMENTO'
      'FROM MOVIMENTOS_ESTOQUE EST'
      'INNER JOIN PRODUTOS PRO ON PRO.ID = EST.PRODUTO_ID'
      'ORDER BY PRO.ID')
    Left = 240
    Top = 232
    object qrDadosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrDadosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object qrDadosTIPO: TIntegerField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
    end
    object qrDadosQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Required = True
    end
    object qrDadosDATA_MOVIMENTO: TDateField
      FieldName = 'DATA_MOVIMENTO'
      Origin = 'DATA_MOVIMENTO'
      Required = True
    end
    object qrDadosTIPO_MOV_CF: TStringField
      FieldKind = fkCalculated
      FieldName = 'TIPO_MOV_CF'
      Calculated = True
    end
  end
  object dsDados: TDataSource
    DataSet = qrDados
    Left = 304
    Top = 232
  end
end
