object DMCadNCM: TDMCadNCM
  OnCreate = DataModuleCreate
  Height = 341
  Width = 510
  object qryConsultaNCM: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      'with A'
      'as (select distinct P.ID_NCM'
      '    from PRODUTO P'
      '    where P.INATIVO = '#39'N'#39')'
      'select N.NCM, N.NOME, IBPT.DT_FINAL DT_IBPTFIM'
      'from A'
      'inner join TAB_NCM N on A.ID_NCM = N.ID'
      
        'left join TAB_IBPT IBPT on N.NCM = IBPT.CODIGO and coalesce(IBPT' +
        '.EX, '#39#39') = '#39#39
      'where IBPT.DT_FINAL is null or (IBPT.DT_FINAL < :DATA)    ')
    Left = 32
    Top = 24
    ParamData = <
      item
        Name = 'DATA'
        DataType = ftDate
        ParamType = ptInput
      end>
    object qryConsultaNCMNCM: TStringField
      FieldName = 'NCM'
      Origin = 'NCM'
      Size = 10
    end
    object qryConsultaNCMDT_IBPTFIM: TDateField
      DisplayLabel = 'Data validade do c'#225'lculo'
      FieldName = 'DT_IBPTFIM'
      Origin = 'DT_IBPTFIM'
    end
    object qryConsultaNCMNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 250
    end
  end
  object dsConsultaNCM: TDataSource
    DataSet = qryConsultaNCM
    Left = 120
    Top = 24
  end
  object qryParametro_NFe: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      'select pn.token_ibpt from parametros_nfe pn')
    Left = 264
    Top = 24
    object qryParametro_NFeTOKEN_IBPT: TStringField
      FieldName = 'TOKEN_IBPT'
      Origin = 'TOKEN_IBPT'
      Size = 130
    end
  end
  object qryTab_IBPT: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      'select * from tab_IBPT'
      'where CODIGO = :NCM and COALESCE(EX,'#39#39') = :EX')
    Left = 32
    Top = 88
    ParamData = <
      item
        Name = 'NCM'
        DataType = ftString
        ParamType = ptInput
        Size = 10
        Value = Null
      end
      item
        Name = 'EX'
        DataType = ftString
        ParamType = ptInput
        Size = 2
      end>
  end
  object mtIBPT: TFDMemTable
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
    Left = 30
    Top = 168
    object mtIBPTCodigo: TStringField
      FieldName = 'Codigo'
    end
    object mtIBPTUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object mtIBPTEX: TStringField
      FieldName = 'EX'
      Size = 1
    end
    object mtIBPTDescricao: TStringField
      FieldName = 'Descricao'
      Size = 150
    end
    object mtIBPTNacional: TFloatField
      FieldName = 'Nacional'
    end
    object mtIBPTEstadual: TFloatField
      FieldName = 'Estadual'
    end
    object mtIBPTImportado: TFloatField
      FieldName = 'Importado'
    end
    object mtIBPTMunicipal: TFloatField
      FieldName = 'Municipal'
    end
    object mtIBPTTipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
    object mtIBPTVigenciaInicio: TDateTimeField
      FieldName = 'VigenciaInicio'
    end
    object mtIBPTVigenciaFim: TDateTimeField
      FieldName = 'VigenciaFim'
    end
    object mtIBPTChave: TStringField
      FieldName = 'Chave'
    end
    object mtIBPTVersao: TStringField
      FieldName = 'Versao'
    end
    object mtIBPTFonte: TStringField
      FieldName = 'Fonte'
      Size = 100
    end
    object mtIBPTValor: TFloatField
      FieldName = 'Valor'
    end
    object mtIBPTValorTributoNacional: TFloatField
      FieldName = 'ValorTributoNacional'
    end
    object mtIBPTValorTributoEstadual: TFloatField
      FieldName = 'ValorTributoEstadual'
    end
    object mtIBPTValorTributoImportado: TFloatField
      FieldName = 'ValorTributoImportado'
    end
    object mtIBPTValorTributoMunicipal: TFloatField
      FieldName = 'ValorTributoMunicipal'
    end
  end
end
