inherited fmCadastroCategorias: TfmCadastroCategorias
  Caption = 'Cadastro de Categorias'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 13
  inherited pcPrincipal: TPageControl
    ActivePage = tsEdits
    inherited tsGrid: TTabSheet
      inherited pnButtonsGrid: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited tsEdits: TTabSheet
      inherited pnButtonsEdits: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited pnEdits: TPanel
        StyleElements = [seFont, seClient, seBorder]
        object Label1: TLabel
          Left = 16
          Top = 8
          Width = 10
          Height = 13
          Caption = 'Id'
          FocusControl = edId
        end
        object Label2: TLabel
          Left = 16
          Top = 48
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
          FocusControl = edDescricao
        end
        object edId: TDBEdit
          Left = 16
          Top = 24
          Width = 134
          Height = 21
          DataField = 'ID'
          DataSource = dsDados
          TabOrder = 0
        end
        object edDescricao: TDBEdit
          Left = 16
          Top = 64
          Width = 329
          Height = 21
          DataField = 'DESCRICAO'
          DataSource = dsDados
          TabOrder = 1
        end
      end
    end
  end
  inherited qrDados: TFDQuery
    SQL.Strings = (
      'SELECT * FROM CATEGORIAS')
    object qrDadosID: TFDAutoIncField
      DefaultExpression = '0'
      DisplayLabel = 'Id'
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qrDadosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 100
    end
  end
end
