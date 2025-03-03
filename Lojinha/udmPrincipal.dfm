object dmPrincipal: TdmPrincipal
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 218
  Width = 300
  object fdConn: TFDConnection
    Params.Strings = (
      'Database=C:\projetos\Pivo\DB\PIVO.FDB'
      'Password=masterkey'
      'User_Name=sysdba'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 128
    Top = 80
  end
end
