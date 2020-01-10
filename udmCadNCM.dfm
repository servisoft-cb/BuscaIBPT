object DMCadNCM: TDMCadNCM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 341
  Width = 510
  object qryConsultaNCM: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      
        'select N.*, I.COD_IPI, IBPT.CODIGO NCM_IBPT, IBPT.DT_FINAL DT_IB' +
        'PTFIM,'
      '       case'
      '         when IBPT.CODIGO is null then '#39'SEM IBPT'#39
      '         when IBPT.DT_INICIO is null then '#39'SEM IBPT'#39
      '         else '#39#39
      '       end ACHOU_IBPT,'
      '       (select count(1) CONTADOR'
      '        from PRODUTO P'
      '        where P.ID_NCM = N.ID) CONTADOR'
      'from TAB_NCM N'
      'left join TAB_CSTIPI I on N.ID_CSTIPI = I.ID'
      
        'left join TAB_IBPT IBPT on N.NCM = IBPT.CODIGO and COALESCE(IBPT' +
        '.EX,'#39#39') = '#39#39)
    Left = 32
    Top = 24
    object qryConsultaNCMID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaNCMNCM: TStringField
      FieldName = 'NCM'
      Origin = 'NCM'
      Size = 10
    end
    object qryConsultaNCMNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 250
    end
    object qryConsultaNCMPERC_RED_STRIB: TFloatField
      FieldName = 'PERC_RED_STRIB'
      Origin = 'PERC_RED_STRIB'
    end
    object qryConsultaNCMGERAR_ST: TStringField
      FieldName = 'GERAR_ST'
      Origin = 'GERAR_ST'
      FixedChar = True
      Size = 1
    end
    object qryConsultaNCMINATIVO: TStringField
      DisplayLabel = 'Inativo'
      FieldName = 'INATIVO'
      Origin = 'INATIVO'
      FixedChar = True
      Size = 1
    end
    object qryConsultaNCMTIPO_AS: TStringField
      FieldName = 'TIPO_AS'
      Origin = 'TIPO_AS'
      FixedChar = True
      Size = 1
    end
    object qryConsultaNCMCOD_PRINCIPAL: TStringField
      FieldName = 'COD_PRINCIPAL'
      Origin = 'COD_PRINCIPAL'
      Size = 2
    end
    object qryConsultaNCMUSAR_MVA_UF_DESTINO: TStringField
      FieldName = 'USAR_MVA_UF_DESTINO'
      Origin = 'USAR_MVA_UF_DESTINO'
      FixedChar = True
      Size = 1
    end
    object qryConsultaNCMCOD_CEST: TStringField
      DisplayLabel = 'C'#243'digo CEST'
      FieldName = 'COD_CEST'
      Origin = 'COD_CEST'
      Size = 7
    end
    object qryConsultaNCMUNIDADE_TRIB: TStringField
      FieldName = 'UNIDADE_TRIB'
      Origin = 'UNIDADE_TRIB'
      Size = 6
    end
    object qryConsultaNCMID_CFOP: TIntegerField
      FieldName = 'ID_CFOP'
      Origin = 'ID_CFOP'
    end
    object qryConsultaNCMID_PIS: TIntegerField
      FieldName = 'ID_PIS'
      Origin = 'ID_PIS'
    end
    object qryConsultaNCMID_COFINS: TIntegerField
      FieldName = 'ID_COFINS'
      Origin = 'ID_COFINS'
    end
    object qryConsultaNCMID_CST_ICMS: TIntegerField
      FieldName = 'ID_CST_ICMS'
      Origin = 'ID_CST_ICMS'
    end
    object qryConsultaNCMPERC_PIS: TFloatField
      FieldName = 'PERC_PIS'
      Origin = 'PERC_PIS'
    end
    object qryConsultaNCMPERC_COFINS: TFloatField
      FieldName = 'PERC_COFINS'
      Origin = 'PERC_COFINS'
    end
    object qryConsultaNCMPERC_BASE_ICMS: TFloatField
      FieldName = 'PERC_BASE_ICMS'
      Origin = 'PERC_BASE_ICMS'
    end
    object qryConsultaNCMID_OBS_LEI: TIntegerField
      FieldName = 'ID_OBS_LEI'
      Origin = 'ID_OBS_LEI'
    end
    object qryConsultaNCMPERC_ICMS: TFloatField
      FieldName = 'PERC_ICMS'
      Origin = 'PERC_ICMS'
    end
    object qryConsultaNCMPERC_IPI: TFloatField
      FieldName = 'PERC_IPI'
      Origin = 'PERC_IPI'
    end
    object qryConsultaNCMID_CSTIPI: TIntegerField
      FieldName = 'ID_CSTIPI'
      Origin = 'ID_CSTIPI'
    end
    object qryConsultaNCMTIPO_ESCALA: TStringField
      FieldName = 'TIPO_ESCALA'
      Origin = 'TIPO_ESCALA'
      FixedChar = True
      Size = 1
    end
    object qryConsultaNCMCALCULA_FCP: TStringField
      FieldName = 'CALCULA_FCP'
      Origin = 'CALCULA_FCP'
      FixedChar = True
      Size = 1
    end
    object qryConsultaNCMIBPT_INATIVO: TStringField
      DisplayLabel = 'IBPT Inativo'
      FieldName = 'IBPT_INATIVO'
      Origin = 'IBPT_INATIVO'
      Size = 1
    end
    object qryConsultaNCMCOD_IPI: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_IPI'
      Origin = 'COD_IPI'
      ProviderFlags = []
      ReadOnly = True
      Size = 2
    end
    object qryConsultaNCMNCM_IBPT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NCM_IBPT'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object qryConsultaNCMDT_IBPTFIM: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Final'
      FieldName = 'DT_IBPTFIM'
      Origin = 'DT_FINAL'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryConsultaNCMACHOU_IBPT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ACHOU_IBPT'
      Origin = 'ACHOU_IBPT'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 8
    end
    object qryConsultaNCMCONTADOR: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'CONTADOR'
      Origin = 'CONTADOR'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object dsConsultaNCM: TDataSource
    DataSet = qryConsultaNCM
    Left = 96
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
        ParamType = ptInput
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
    object mtIBPTVigenciaInicio: TDateField
      FieldName = 'VigenciaInicio'
    end
    object mtIBPTVigenciaFim: TDateField
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
