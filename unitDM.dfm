object DM: TDM
  OldCreateOrder = False
  Height = 461
  Width = 613
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=dbcadclientes'
      'User_Name=root'
      'Password=p@ssw0rd'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 80
  end
  object QryClientes: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'select * from clientes')
    Left = 40
    Top = 160
    object QryClientescodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object QryClientesnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 100
    end
    object QryClientesendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 100
    end
    object QryClientesbairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Required = True
      Size = 100
    end
    object QryClientescidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Required = True
      Size = 100
    end
    object QryClientesuf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      FixedChar = True
      Size = 2
    end
    object QryClientestelefone: TStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
      Size = 14
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Adriano Santos\Documents\Projetos Delphi\ERPSimples\lib' +
      'mySQL.dll'
    Left = 512
    Top = 40
  end
  object dsClientes: TDataSource
    DataSet = QryClientes
    Left = 112
    Top = 160
  end
end
