unit uConsultaIBPT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.Buttons, System.JSON,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, REST.Response.Adapter;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    edtToken: TEdit;
    edtCNPJ: TEdit;
    edtCodigo: TEdit;
    edtUF: TEdit;
    edtEX: TEdit;
    edtDescricao: TEdit;
    edtUnidadeMedida: TEdit;
    edtValor: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    edtGtin: TEdit;
    btnBuscar: TBitBtn;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDMemTable1: TFDMemTable;
    FDMemTable1Codigo: TStringField;
    FDMemTable1UF: TStringField;
    FDMemTable1EX: TStringField;
    FDMemTable1Descricao: TStringField;
    FDMemTable1Nacional: TFloatField;
    FDMemTable1Estadual: TFloatField;
    FDMemTable1Importado: TFloatField;
    FDMemTable1Municipal: TFloatField;
    FDMemTable1Tipo: TStringField;
    FDMemTable1VigenciaInicio: TDateField;
    FDMemTable1VigenciaFim: TDateField;
    FDMemTable1Chave: TStringField;
    FDMemTable1Versao: TStringField;
    FDMemTable1Fonte: TStringField;
    FDMemTable1Valor: TFloatField;
    FDMemTable1ValorTributoNacional: TFloatField;
    FDMemTable1ValorTributoEstadual: TFloatField;
    FDMemTable1ValorTributoImportado: TFloatField;
    FDMemTable1ValorTributoMunicipal: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    { Private declarations }
    vBaseURLPadrao : String;
    procedure JsonToDataset (aDataSet : TDataSet; aJson : string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnBuscarClick(Sender: TObject);
var
  BaseUrl : string;
  JsonString : String;
begin
  BaseUrl := '?token=' + Trim(edtToken.Text);
  BaseUrl := BaseUrl + '&cnpj=' + Trim(edtCNPJ.Text);
  BaseUrl := BaseUrl + '&codigo='+ Trim(edtCodigo.Text);
  BaseUrl := BaseUrl + '&uf='+ Trim(edtUF.Text);
  BaseUrl := BaseUrl + '&ex='+ Trim(edtEX.Text);
  BaseUrl := BaseUrl + '&descricao=' + Trim(edtDescricao.Text);
  BaseUrl := BaseUrl + '&unidadeMedida=' + Trim(edtUnidadeMedida.Text);
  BaseUrl := BaseUrl + '&valor=' + Trim(edtValor.Text);
  BaseUrl := BaseUrl + '&gtin='+ Trim(edtGtin.Text);
  RESTClient1.BaseURL := vBaseURLPadrao + BaseUrl;
  RESTRequest1.Execute;
  JsonToDataset(FDMemTable1,RESTResponse1.JSONValue.ToString);
  JsonString := RESTResponse1.JSONValue.ToString;
  if RESTResponse1.StatusCode = 200 then
    Memo1.Lines.Add(JsonString)
  else
    Memo1.Lines.Add('Erro no processo');


end;

procedure TForm1.FormShow(Sender: TObject);
begin
  edtToken.Text := '8bz6ceDhIVRvZcVrlNPcIH1k1P5V2Y8KdF-uQLMan7PTclkTIMc04GywEsodZ0T6';
  edtCNPJ.Text := '09312127000110';
  edtCodigo.Text := '02102000';
  edtUF.Text := 'RS';
  edtEX.Text := '0';
  edtDescricao.Text := 'FILE';
  edtUnidadeMedida.Text := 'KG';
  edtValor.Text := '37';
  edtGtin.Text := '0';
  vBaseURLPadrao := RESTClient1.BaseURL;
end;

procedure TForm1.JsonToDataset(aDataSet: TDataSet; aJson: string);
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
    vConv.Free;
    JObj.Free;
  end;
end;

end.
