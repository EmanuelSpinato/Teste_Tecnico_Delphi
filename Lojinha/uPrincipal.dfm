object fmPrincipal: TfmPrincipal
  Left = 0
  Top = 0
  Caption = 'Lojinha'
  ClientHeight = 271
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmPrincipal
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 13
  object sbPrincipal: TStatusBar
    Left = 0
    Top = 252
    Width = 442
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Version: 1.0.0'
  end
  object mmPrincipal: TMainMenu
    Left = 168
    Top = 88
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Usurios1: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = Usurios1Click
      end
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes1Click
      end
      object Fornecedores1: TMenuItem
        Caption = 'Fornecedores'
        OnClick = Fornecedores1Click
      end
      object Categorias1: TMenuItem
        Caption = 'Categorias'
        OnClick = Categorias1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
      object mnuPedidos1: TMenuItem
        Caption = 'Pedidos'
        OnClick = mnuPedidos1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        ShortCut = 32883
        OnClick = Sair1Click
      end
    end
    object Movimentos1: TMenuItem
      Caption = 'Movimentos'
      object Estoque2: TMenuItem
        Caption = 'Estoque'
        object Entradas1: TMenuItem
          Caption = 'Entradas'
          OnClick = Entradas1Click
        end
        object Sadas1: TMenuItem
          Caption = 'Sa'#237'das'
        end
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Estoque1: TMenuItem
        Caption = 'Estoque'
        OnClick = Estoque1Click
      end
      object ListagemProdutos1: TMenuItem
        Caption = 'Listagem de Produtos'
        OnClick = ListagemProdutos1Click
      end
      object Vendas1: TMenuItem
        Caption = 'Vendas'
        OnClick = Vendas1Click
      end
    end
  end
end
