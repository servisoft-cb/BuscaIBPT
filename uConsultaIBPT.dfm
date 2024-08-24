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
  Position = poDesigned
  OnShow = FormShow
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 838
    Height = 54
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 836
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
    ExplicitWidth = 836
    ExplicitHeight = 444
    object Memo1: TMemo
      Left = 1
      Top = 304
      Width = 836
      Height = 143
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 300
      ExplicitWidth = 834
    end
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 280
      Width = 836
      Height = 24
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 276
      ExplicitWidth = 834
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 836
      Height = 279
      Align = alClient
      DataSource = dsPadrao
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://apidoni.ibpt.org.br/api/v1/produtos'
    ContentType = 'application/json'
    Params = <>
    RaiseExceptionOn500 = False
    SynchronizedEvents = False
    Left = 536
    Top = 64
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'token'
        Options = [poAutoCreated]
        Value = '8bz6ceDhIVRvZcVrlNPcIH1k1P5V2Y8KdF-uQLMan7PTclkTIMc04GywEsodZ0T6'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'cnpj'
        Options = [poAutoCreated]
        Value = '09312127000110'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'codigo'
        Options = [poAutoCreated]
        Value = '02102000'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'uf'
        Options = [poAutoCreated]
        Value = 'RS'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'ex'
        Options = [poAutoCreated]
        Value = '0'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'codigoInterno'
        Options = [poAutoCreated]
        Value = '0'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'descricao'
        Options = [poAutoCreated]
        Value = 'FILE MIGNON'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'valor'
        Options = [poAutoCreated]
        Value = '37'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'gtin'
        Options = [poAutoCreated]
        Value = '0'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 656
    Top = 48
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 712
    Top = 128
  end
  object dsPadrao: TDataSource
    Left = 568
    Top = 112
  end
end
