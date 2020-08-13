object frmBuscaIBPT: TfrmBuscaIBPT
  Left = 244
  Top = 0
  Caption = 'Busca IBPT'
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 838
    Height = 54
    Align = alTop
    TabOrder = 0
    object btnConsultar: TBitBtn
      Left = 37
      Top = 4
      Width = 115
      Height = 44
      Caption = 'Consultar'
      TabOrder = 0
      OnClick = btnConsultarClick
    end
    object btnAtualizarIBPT: TBitBtn
      Left = 158
      Top = 4
      Width = 115
      Height = 44
      Caption = 'Atualizar IBPT'
      TabOrder = 1
      OnClick = btnAtualizarIBPTClick
    end
    object ckUsaProduto: TCheckBox
      Left = 304
      Top = 17
      Width = 241
      Height = 17
      Caption = 'Mostrar somente NCM usados nos Produtos'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
    end
  end
  object pnlPrincipal: TPanel
    Left = 0
    Top = 54
    Width = 838
    Height = 448
    Align = alClient
    TabOrder = 1
    object Memo1: TMemo
      Left = 1
      Top = 304
      Width = 836
      Height = 143
      Align = alBottom
      TabOrder = 0
    end
    object SMDBGrid1: TSMDBGrid
      Left = 1
      Top = 1
      Width = 836
      Height = 279
      Align = alClient
      DataSource = dsPadrao
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Flat = False
      BandsFont.Charset = DEFAULT_CHARSET
      BandsFont.Color = clWindowText
      BandsFont.Height = -11
      BandsFont.Name = 'Tahoma'
      BandsFont.Style = []
      Groupings = <>
      GridStyle.Style = gsSoftGray
      GridStyle.OddColor = 15000804
      GridStyle.EvenColor = 16119285
      TitleHeight.PixelCount = 24
      FooterColor = clBtnFace
      ExOptions = [eoENTERlikeTAB, eoKeepSelection, eoStandardPopup, eoBLOBEditor, eoTitleWordWrap, eoFilterAutoApply]
      RegistryKey = 'Software\Scalabium'
      RegistrySection = 'SMDBGrid'
      WidthOfIndicator = 11
      DefaultRowHeight = 17
      ScrollBars = ssHorizontal
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          ReadOnly = True
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACHOU_IBPT'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'IBPT'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NCM'
          ReadOnly = True
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 210
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INATIVO'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Inativo'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_CEST'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'COD CEST'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NCM_IBPT'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'NCM IBPT'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_IBPTFIM'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTADOR'
          Title.Caption = 'Qtd. de Produtos'
          Width = 100
          Visible = True
        end>
    end
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 280
      Width = 836
      Height = 24
      Align = alBottom
      TabOrder = 2
    end
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://apidoni.ibpt.org.br/api/v1/produtos'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 568
    Top = 8
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
    Top = 8
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 728
    Top = 8
  end
  object dsPadrao: TDataSource
    Left = 568
    Top = 112
  end
end
