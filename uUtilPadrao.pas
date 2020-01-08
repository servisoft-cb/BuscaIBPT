unit uUtilPadrao;

interface

uses
 Classes,   FireDAC.Comp.Client, DmdConnection, Vcl.Printers, Datasnap.DBClient;

  function  SQLLocate(Tabela, CampoProcura, CampoRetorno, ValorFind: string): string ;
  function GetDefaultPrinterName: string;
  procedure CopiarDataSet(Origem, Destino : TClientDataSet);

var
 vCaminhoBanco: String;

implementation

uses
  System.SysUtils, Winapi.CommDlg;


function SQLLocate(Tabela, CampoProcura, CampoRetorno, ValorFind: string): string ;
var
  MyQuery: TFDQuery;
begin
  if ValorFind <> '' then
  begin
    MyQuery := TFDQuery.Create(DMConection);
    MyQuery.Connection := DMConection.FDConnection;
    MyQuery.Close;
    MyQuery.SQL.Clear ;
    MyQuery.SQL.Add('select ' + CampoRetorno + ' from ' + Tabela) ;
    MyQuery.SQL.Add('where  ' + CampoProcura + ' = ' + QuotedStr(ValorFind));
    MyQuery.Open ;
    if not MyQuery.EOF then
      SQLLocate := MyQuery.FieldByName(CampoRetorno).AsString
    else
      SQLLocate := '' ;
    MyQuery.Destroy ;
  end
  else
    ValorFind := '' ;
end;

function GetDefaultPrinterName: string;
begin
  if (Printer.PrinterIndex >= 0) then
  begin
    Result := Printer.Printers[Printer.PrinterIndex];
  end
  else
  begin
    Result := 'Nenhuma impressora padrão foi detectada.';
  end;
end;

procedure CopiarDataSet(Origem, Destino : TClientDataSet);
begin
  Destino.Data := Origem.Data;
end;

end.
