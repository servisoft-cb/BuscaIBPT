unit uConsultaIBPT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.Buttons, System.JSON,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, REST.Response.Adapter,
  udmCadNCM, Vcl.ExtCtrls, SMDBGrid, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls;

const
  UrlIBPT = 'https://apidoni.ibpt.org.br/api/v1/produtos';

type
  TfrmBuscaIBPT = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    dsPadrao: TDataSource;
    pnlTop: TPanel;
    pnlPrincipal: TPanel;
    Memo1: TMemo;
    btnConsultar: TBitBtn;
    btnAtualizarIBPT: TBitBtn;
    SMDBGrid1: TSMDBGrid;
    ProgressBar1: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarIBPTClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    vBaseURLPadrao : String;
    fDMCadNCM : TDMCadNCM;

    vIBPT_Token : String;
    vCNPJ : String;
    vIBPT_NCM : String;
    vIBPT_Descricao : String;
    vIBPT_UnidadeMedida : String;
    vIBPT_Tipo : String;
    vIBPT_Uf : String;
    vIBPT_Valor : String;
    vIBPT_VigenciaInicio : String;
    vIBPT_VigenciaFim : String;
    vIBPT_Ex : String;
    vIBPT_Gtin : String;
    vIBPT_Estadual : Real;
    vIBPT_Importado : Real;
    vIBPT_Municipal : Real;
    vIBPT_Nacional : Real;
    procedure JsonToDataset (aDataSet : TDataSet; aJson : string);
    procedure MontaBaseURL;
    procedure Consultar;
  public
    { Public declarations }
  end;

var
  frmBuscaIBPT: TfrmBuscaIBPT;

implementation

{$R *.dfm}

procedure TfrmBuscaIBPT.btnConsultarClick(Sender: TObject);
begin
  Consultar;
end;

procedure TfrmBuscaIBPT.btnAtualizarIBPTClick(Sender: TObject);
begin
  if vIBPT_Token = EmptyStr then
    Application.MessageBox('Token do IBPT não informado no parâmetro!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
  if fDMCadNCM.qryConsultaNCM.IsEmpty then
    Application.MessageBox('Não há nenhum IBPT para atualizar!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
  ProgressBar1.Min := 0;
  ProgressBar1.Max := fDMCadNCM.qryConsultaNCM.RecordCount;
  btnAtualizarIBPT.Enabled := False;
  try
    with fDMCadNCM do
    begin
      qryConsultaNCM.DisableControls;
      while not qryConsultaNCM.Eof do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        vIBPT_NCM := qryConsultaNCMNCM.AsString;
        vIBPT_Descricao := qryConsultaNCMNOME.AsString;
        vIBPT_Uf := 'RS';
        vIBPT_Ex := '0';
        vIBPT_UnidadeMedida := '';
        vIBPT_Valor := '0';
        vIBPT_Gtin := '';
        MontaBaseURL;
        qryConsultaNCM.Next;
      end;
    end;
  finally
    fDMCadNCM.qryConsultaNCM.EnableControls;
    btnAtualizarIBPT.Enabled := True;
  end;
end;

procedure TfrmBuscaIBPT.Consultar;
begin
  fDMCadNCM.qryConsultaNCM.Close;
  fDMCadNCM.qryConsultaNCM.SQL.Text := fDMCadNCM.ctComand
                                         + 'WHERE ((N.ibpt_inativo = ' +QuotedStr('N') + ') or (N.ibpt_inativo IS NULL)) '
                                         + '  AND ((N.inativo = ' +QuotedStr('N') + ') or (N.inativo IS NULL)) '
                                         + '  AND ((IBPT.DT_FINAL < :DATA) or (IBPT.DT_FINAL IS NULL))';
  fDMCadNCM.qryConsultaNCM.ParamByName('DATA').AsDate := Date;
  fDMCadNCM.qryConsultaNCM.Open;
end;

procedure TfrmBuscaIBPT.FormShow(Sender: TObject);
begin
  fDMCadNCM := TDMCadNCM.Create(Self);
  dsPadrao.DataSet := fDMCadNCM.qryConsultaNCM;

  fDMCadNCM.qryParametro_NFe.Open;
  vIBPT_Token := fDMCadNCM.qryParametro_NFeTOKEN_IBPT.AsString;
  vCNPJ := '09312127000110';

  Refresh;
  Sleep(1000);
  btnConsultarClick(Sender);
  if fDMCadNCM.qryConsultaNCM.RecordCount > 0 then
  begin
    btnAtualizarIBPTClick(Sender);
    btnAtualizarIBPTClick(Sender);
    if fDMCadNCM.qryConsultaNCM.RecordCount > 0 then
      MessageDlg('*** Verificar as NCMs que estão na consulta', mtWarning, [mbOk], 0);
  end;
end;

procedure TfrmBuscaIBPT.JsonToDataset(aDataSet: TDataSet; aJson: string);
var
  JObj: TJSONValue;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJson = EmptyStr) then
    Exit;
  JObj := TJSONObject.ParseJSONValue(aJSON);
  vConv := TCustomJSONDataSetAdapter.Create(nil);
  try
    vConv.Dataset := aDataSet;
    vConv.UpdateDataSet(JObj);
  finally
    if Assigned(vConv) then
      vConv.Free;
    if Assigned(JObj) then
      JObj.Free;
  end;
end;

procedure TfrmBuscaIBPT.MontaBaseURL;
var
  BaseUrl: string;
  JsonString: string;
begin
  BaseUrl := '?token=' + Trim(vIBPT_Token);
  BaseUrl := BaseUrl + '&cnpj=' + Trim(vCNPJ);
  BaseUrl := BaseUrl + '&codigo=' + Trim(vIBPT_NCM);
  BaseUrl := BaseUrl + '&uf=' + Trim(vIBPT_Uf);
  BaseUrl := BaseUrl + '&ex=' + Trim(vIBPT_Ex);
  BaseUrl := BaseUrl + '&descricao=' + Trim(vIBPT_Descricao);
  BaseUrl := BaseUrl + '&unidadeMedida=' + Trim(vIBPT_UnidadeMedida);
  BaseUrl := BaseUrl + '&valor=' + Trim(vIBPT_Valor);
  BaseUrl := BaseUrl + '&gtin=' + Trim(vIBPT_Gtin);
  RESTClient1.BaseURL := UrlIBPT + BaseUrl;
  RESTRequest1.Execute;
  JsonString := RESTResponse1.JSONValue.ToString;
  JsonToDataset(fDMCadNCM.mtIBPT, RESTResponse1.JSONValue.ToString);
  if RESTResponse1.StatusCode = 200 then
  begin
//    Memo1.Lines.Add(JsonString);
    if fDMCadNCM.mtIBPTCodigo.AsString <> EmptyStr then
      fDMCadNCM.Gravar_Retorno(vIBPT_NCM)
    else
      Memo1.Lines.Add(vIBPT_NCM + ' Ncm não encontrado!');
  end
  else
    Memo1.Lines.Add(vIBPT_NCM + 'Erro ao Atualizar');
end;

end.
