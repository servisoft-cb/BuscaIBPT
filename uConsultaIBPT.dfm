object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 502
  ClientWidth = 838
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 141
    Top = 12
    Width = 29
    Height = 13
    Caption = 'Token'
  end
  object Label2: TLabel
    Left = 150
    Top = 39
    Width = 20
    Height = 13
    Caption = 'cnpj'
  end
  object Label3: TLabel
    Left = 139
    Top = 68
    Width = 31
    Height = 13
    Caption = 'codigo'
  end
  object Label4: TLabel
    Left = 160
    Top = 95
    Width = 10
    Height = 13
    Caption = 'uf'
  end
  object Label5: TLabel
    Left = 158
    Top = 122
    Width = 12
    Height = 13
    Caption = 'ex'
  end
  object Label6: TLabel
    Left = 125
    Top = 149
    Width = 45
    Height = 13
    Caption = 'descricao'
  end
  object Label7: TLabel
    Left = 98
    Top = 176
    Width = 72
    Height = 13
    Caption = 'unidadeMedida'
  end
  object Label8: TLabel
    Left = 146
    Top = 203
    Width = 24
    Height = 13
    Caption = 'valor'
  end
  object Label10: TLabel
    Left = 152
    Top = 226
    Width = 18
    Height = 13
    Caption = 'gtin'
  end
  object edtToken: TEdit
    Left = 176
    Top = 4
    Width = 385
    Height = 21
    TabOrder = 0
  end
  object edtCNPJ: TEdit
    Left = 176
    Top = 31
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtCodigo: TEdit
    Left = 176
    Top = 60
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtUF: TEdit
    Left = 176
    Top = 87
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtEX: TEdit
    Left = 176
    Top = 114
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object edtDescricao: TEdit
    Left = 176
    Top = 141
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object edtUnidadeMedida: TEdit
    Left = 176
    Top = 168
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object edtValor: TEdit
    Left = 176
    Top = 195
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object Memo1: TMemo
    Left = 303
    Top = 31
    Width = 258
    Height = 143
    TabOrder = 8
  end
  object edtGtin: TEdit
    Left = 176
    Top = 218
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object btnBuscar: TBitBtn
    Left = 303
    Top = 195
    Width = 82
    Height = 44
    Caption = 'Buscar'
    TabOrder = 10
    OnClick = btnBuscarClick
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 280
    Width = 806
    Height = 120
    DataSource = DataSource1
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://apidoni.ibpt.org.br/api/v1/produtos'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 656
    Top = 120
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'token'
        Options = [poAutoCreated]
        Value = '8bz6ceDhIVRvZcVrlNPcIH1k1P5V2Y8KdF-uQLMan7PTclkTIMc04GywEsodZ0T6'
      end
      item
        Kind = pkURLSEGMENT
        name = 'cnpj'
        Options = [poAutoCreated]
        Value = '09312127000110'
      end
      item
        Kind = pkURLSEGMENT
        name = 'codigo'
        Options = [poAutoCreated]
        Value = '02102000'
      end
      item
        Kind = pkURLSEGMENT
        name = 'uf'
        Options = [poAutoCreated]
        Value = 'RS'
      end
      item
        Kind = pkURLSEGMENT
        name = 'ex'
        Options = [poAutoCreated]
        Value = '0'
      end
      item
        Kind = pkURLSEGMENT
        name = 'codigoInterno'
        Options = [poAutoCreated]
        Value = '0'
      end
      item
        Kind = pkURLSEGMENT
        name = 'descricao'
        Options = [poAutoCreated]
        Value = 'FILE MIGNON'
      end
      item
        Kind = pkURLSEGMENT
        name = 'valor'
        Options = [poAutoCreated]
        Value = '37'
      end
      item
        Kind = pkURLSEGMENT
        name = 'gtin'
        Options = [poAutoCreated]
        Value = '0'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 656
    Top = 72
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 656
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 224
    Top = 424
  end
  object FDMemTable1: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 168
    Top = 424
    object FDMemTable1Codigo: TStringField
      FieldName = 'Codigo'
    end
    object FDMemTable1UF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object FDMemTable1EX: TStringField
      FieldName = 'EX'
      Size = 1
    end
    object FDMemTable1Descricao: TStringField
      FieldName = 'Descricao'
      Size = 150
    end
    object FDMemTable1Nacional: TFloatField
      FieldName = 'Nacional'
    end
    object FDMemTable1Estadual: TFloatField
      FieldName = 'Estadual'
    end
    object FDMemTable1Importado: TFloatField
      FieldName = 'Importado'
    end
    object FDMemTable1Municipal: TFloatField
      FieldName = 'Municipal'
    end
    object FDMemTable1Tipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
    object FDMemTable1VigenciaInicio: TDateField
      FieldName = 'VigenciaInicio'
    end
    object FDMemTable1VigenciaFim: TDateField
      FieldName = 'VigenciaFim'
    end
    object FDMemTable1Chave: TStringField
      FieldName = 'Chave'
    end
    object FDMemTable1Versao: TStringField
      FieldName = 'Versao'
    end
    object FDMemTable1Fonte: TStringField
      FieldName = 'Fonte'
      Size = 100
    end
    object FDMemTable1Valor: TFloatField
      FieldName = 'Valor'
    end
    object FDMemTable1ValorTributoNacional: TFloatField
      FieldName = 'ValorTributoNacional'
    end
    object FDMemTable1ValorTributoEstadual: TFloatField
      FieldName = 'ValorTributoEstadual'
    end
    object FDMemTable1ValorTributoImportado: TFloatField
      FieldName = 'ValorTributoImportado'
    end
    object FDMemTable1ValorTributoMunicipal: TFloatField
      FieldName = 'ValorTributoMunicipal'
    end
  end
end
