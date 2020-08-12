unit udmCadNCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt, DmdConnection;

type
  TDMCadNCM = class(TDataModule)
    qryConsultaNCM: TFDQuery;
    dsConsultaNCM: TDataSource;
    qryConsultaNCMID: TIntegerField;
    qryConsultaNCMNCM: TStringField;
    qryConsultaNCMNOME: TStringField;
    qryConsultaNCMPERC_RED_STRIB: TFloatField;
    qryConsultaNCMGERAR_ST: TStringField;
    qryConsultaNCMINATIVO: TStringField;
    qryConsultaNCMTIPO_AS: TStringField;
    qryConsultaNCMCOD_PRINCIPAL: TStringField;
    qryConsultaNCMUSAR_MVA_UF_DESTINO: TStringField;
    qryConsultaNCMCOD_CEST: TStringField;
    qryConsultaNCMUNIDADE_TRIB: TStringField;
    qryConsultaNCMID_CFOP: TIntegerField;
    qryConsultaNCMID_PIS: TIntegerField;
    qryConsultaNCMID_COFINS: TIntegerField;
    qryConsultaNCMID_CST_ICMS: TIntegerField;
    qryConsultaNCMPERC_PIS: TFloatField;
    qryConsultaNCMPERC_COFINS: TFloatField;
    qryConsultaNCMPERC_BASE_ICMS: TFloatField;
    qryConsultaNCMID_OBS_LEI: TIntegerField;
    qryConsultaNCMPERC_ICMS: TFloatField;
    qryConsultaNCMPERC_IPI: TFloatField;
    qryConsultaNCMID_CSTIPI: TIntegerField;
    qryConsultaNCMTIPO_ESCALA: TStringField;
    qryConsultaNCMCALCULA_FCP: TStringField;
    qryConsultaNCMIBPT_INATIVO: TStringField;
    qryConsultaNCMCOD_IPI: TStringField;
    qryConsultaNCMNCM_IBPT: TStringField;
    qryConsultaNCMDT_IBPTFIM: TDateField;
    qryConsultaNCMACHOU_IBPT: TStringField;
    qryConsultaNCMCONTADOR: TIntegerField;
    qryParametro_NFe: TFDQuery;
    qryParametro_NFeTOKEN_IBPT: TStringField;
    qryTab_IBPT: TFDQuery;
    mtIBPT: TFDMemTable;
    mtIBPTCodigo: TStringField;
    mtIBPTUF: TStringField;
    mtIBPTEX: TStringField;
    mtIBPTDescricao: TStringField;
    mtIBPTNacional: TFloatField;
    mtIBPTEstadual: TFloatField;
    mtIBPTImportado: TFloatField;
    mtIBPTMunicipal: TFloatField;
    mtIBPTTipo: TStringField;
    mtIBPTChave: TStringField;
    mtIBPTVersao: TStringField;
    mtIBPTFonte: TStringField;
    mtIBPTValor: TFloatField;
    mtIBPTValorTributoNacional: TFloatField;
    mtIBPTValorTributoEstadual: TFloatField;
    mtIBPTValorTributoImportado: TFloatField;
    mtIBPTValorTributoMunicipal: TFloatField;
    mtIBPTVigenciaInicio: TDateTimeField;
    mtIBPTVigenciaFim: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ctComand : String;
    procedure Abrir_TAB_IBPT(aValue : String);
    procedure Gravar_Retorno(aValue : String);
    procedure Inserir_Tab_IBPT;
  end;

var
  DMCadNCM: TDMCadNCM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadNCM.Abrir_TAB_IBPT(aValue : String);
begin
  qryTab_IBPT.Close;
  qryTab_IBPT.ParamByName('NCM').AsString := aValue;
  qryTab_IBPT.ParamByName('EX').AsString := '';
  qryTab_IBPT.Open;
end;

procedure TDMCadNCM.DataModuleCreate(Sender: TObject);
begin
  ctComand := qryConsultaNCM.SQL.Text;
end;

procedure TDMCadNCM.Gravar_Retorno(aValue : String);
begin
  if mtIBPT.Locate('Codigo',qryConsultaNCMNCM.AsString,[loCaseInsensitive]) then
  begin
    Abrir_TAB_IBPT(qryConsultaNCMNCM.AsString);
    if not qryTab_IBPT.IsEmpty then
      qryTab_IBPT.Edit
    else
      Inserir_Tab_IBPT;
    qryTab_IBPT.FieldByName('PERC_NACIONAL').AsFloat := mtIBPTNacional.AsFloat;
    qryTab_IBPT.FieldByName('PERC_IMPORTACAO').AsFloat := mtIBPTImportado.AsFloat;
    qryTab_IBPT.FieldByName('PERC_ESTADUAL').AsFloat := mtIBPTEstadual.AsFloat;
    qryTab_IBPT.FieldByName('PERC_MUNICIPAL').AsFloat := mtIBPTMunicipal.AsFloat;
    qryTab_IBPT.FieldByName('DT_INICIO').AsDateTime := mtIBPTVigenciaInicio.AsDateTime;
    qryTab_IBPT.FieldByName('DT_FINAL').AsDateTime := mtIBPTVigenciaFim.AsDateTime;
    qryTab_IBPT.FieldByName('CHAVE').AsString := mtIBPTChave.AsString;
    qryTab_IBPT.FieldByName('VERSAO').AsString := mtIBPTVersao.AsString;
    qryTab_IBPT.FieldByName('FONTE').AsString := mtIBPTFonte.AsString;
    qryTab_IBPT.FieldByName('TABELA').AsString := mtIBPTFonte.AsString;
    if StrToIntDef(mtIBPTEX.AsString,0) = 0 then
      qryTab_IBPT.FieldByName('EX').AsString := ''
    else
      qryTab_IBPT.FieldByName('EX').AsString := mtIBPTEX.AsString;
    qryTab_IBPT.FieldByName('NOME').AsString := mtIBPTDescricao.AsString;
    qryTab_IBPT.FieldByName('TABELA').AsString := '0';
    qryTab_IBPT.Post;
    qryTab_IBPT.UpdateTransaction;
  end;
end;

procedure TDMCadNCM.Inserir_Tab_IBPT;
var
  iSequencia : Integer;
begin
  if not qryTab_IBPT.Active then
    Abrir_TAB_IBPT('');
  iSequencia := DMConection.ProximaSequencia('TAB_IBPT',0);
  qryTab_IBPT.Insert;
  qryTab_IBPT.FieldByName('ID').AsInteger := iSequencia;
end;

end.
