unit DmdConnection;

interface

uses
  System.SysUtils, System.Classes, IdCoderMIME, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, Data.SqlExpr;

type
  TDMConection = class(TDataModule)
    FDConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ProximaSequencia(NomeTabela: string; Filial: Integer; SerieCupom : String = '0'): Integer;
  end;

var
  DMConection: TDMConection;

implementation

uses
  System.IniFiles, Vcl.Forms, Vcl.Dialogs, uUtilPadrao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMConection.DataModuleCreate(Sender: TObject);
var
  ArquivoIni, BancoDados, DriverName, UserName, PassWord : String;
  LocalServer : Integer;
  Configuracoes : TIniFile;
  Decoder64: TIdDecoderMIME;
  Encoder64: TIdEncoderMIME;
begin
  Decoder64 := TIdDecoderMIME.Create(nil);
  ArquivoIni := ExtractFilePath(Application.ExeName) + '\Config.ini';
  if not FileExists(ArquivoIni) then
  begin
    MessageDlg('Arquivo config.ini não encontrado!', mtInformation,[mbOK],0);
    Exit;
  end;
  Configuracoes := TIniFile.Create(ArquivoINI);
  try
     BancoDados := Configuracoes.ReadString('SSFacil', 'DATABASE', DriverName);
     DriverName := Configuracoes.ReadString('SSFacil', 'DriverName', DriverName);
     UserName   := Configuracoes.ReadString('SSFacil', 'UserName',   UserName);
     PassWord   := Decoder64.DecodeString(Configuracoes.ReadString('SSFacil', 'PASSWORD', ''));
  finally
    Configuracoes.Free;
    Decoder64.Free;
  end;

  try
    FDConnection.Connected := False;
    FDConnection.Params.Clear;
    FDConnection.DriverName := 'FB';
    FDConnection.Params.Values['DriveId'] := 'FB';
    FDConnection.Params.Values['DataBase'] := BancoDados;
    FDConnection.Params.Values['User_Name'] := UserName;
    FDConnection.Params.Values['Password'] := PassWord;
    FDConnection.Connected := True;
    uUtilPadrao.vCaminhoBanco := BancoDados;
  except
    on E : Exception do
    begin
      raise Exception.Create('Erro ao conectar o Banco de dados ' + #13 +
                             'Mensagem: ' + e.Message + #13 +
                             'Classe: ' + e.ClassName + #13 +
                             'Banco de Dados: ' + BancoDados + #13 +
                             'Usuário: ' + UserName);
    end;
  end;
end;

function TDMConection.ProximaSequencia(NomeTabela: string; Filial: Integer;
  SerieCupom: String): Integer;
var
  sds: TSQLDataSet;
  qry : TFDQuery;
  iSeq: Integer;
  ID: TTransactionDesc;
  Flag: Boolean;
begin
  Result := 0;
  iSeq   := 0;

 qry := TFDQuery.Create(nil);
  try
    ID.TransactionID  := 999;
    ID.IsolationLevel := xilREADCOMMITTED;

    DMConection.FDConnection.StartTransaction;
    try
      qry.Connection := DMConection.FDConnection;
      qry.SQL.Text := 'SELECT NUMREGISTRO FROM SEQUENCIAL WHERE TABELA = :TABELA AND FILIAL = :FILIAL AND SERIE = :SERIE';
      qry.ParamByName('SERIE').AsInteger  := StrToInt(SerieCupom);
      qry.ParamByName('TABELA').AsString  := NomeTabela;
      qry.ParamByName('FILIAL').AsInteger := Filial;
      qry.Open;

      qry.Connection :=  DMConection.FDConnection;
      qry.SQL.Text := 'SELECT NUMREGISTRO FROM SEQUENCIAL WHERE TABELA = :TABELA AND FILIAL = :FILIAL AND SERIE = :SERIE';
      qry.ParamByName('SERIE').AsInteger  := StrToInt(SerieCupom);
      qry.ParamByName('TABELA').AsString  := NomeTabela;
      qry.ParamByName('FILIAL').AsInteger := Filial;
      qry.Open;

      iSeq := qry.FieldByName('NUMREGISTRO').AsInteger;

      if (iSeq = 0) and (qry.IsEmpty) then
        FDConnection.ExecSQL('INSERT INTO SEQUENCIAL(TABELA,FILIAL,NUMREGISTRO,SERIE) VALUES(' + QuotedStr(NomeTabela) + ',' +
                                QuotedStr(IntToStr(Filial)) + ',' + QuotedStr(IntToStr(0)) + ',' + QuotedStr(SerieCupom) + ')');
      FDConnection.Commit;
    except
      FDConnection.Rollback;
      raise;
    end;
  finally
    FreeAndNil(qry);
  end;

  qry := TFDQuery.Create(nil);
  try
    ID.TransactionID  := 999;
    ID.IsolationLevel := xilREADCOMMITTED;

    DMConection.FDConnection.StartTransaction;
    try //--
      qry.Connection := FDConnection;
      qry.SQL.Text := 'UPDATE SEQUENCIAL SET NUMREGISTRO = (SELECT MAX(COALESCE(NUMREGISTRO,0)) + 1 ' +
                      'FROM SEQUENCIAL ' +
                      'WHERE TABELA = :TABELA' +
                      ' AND FILIAL = :FILIAL AND SERIE = :SERIE) ' +
                      'WHERE TABELA = :TABELA' +
                      ' AND FILIAL = :FILIAL AND SERIE = :SERIE';

      qry.ParamByName('TABELA').AsString  := NomeTabela;
      qry.ParamByName('FILIAL').AsInteger := Filial;
      qry.ParamByName('SERIE').AsInteger := StrToInt(SerieCupom);

      Flag := False;
      while not Flag do
      begin
        try
          qry.Close;
          qry.ExecSQL;
          Flag := True;
        except
          on E: Exception do
            Flag := False;
        end;
      end;

      qry.Close;
      qry.SQL.Text := 'SELECT MAX(COALESCE(NUMREGISTRO,0)) NUMREGISTRO  ' +
                      'FROM SEQUENCIAL ' +
                      'WHERE TABELA = :TABELA ' +
                      'AND FILIAL = :FILIAL ' +
                      'AND SERIE = :SERIE';
      qry.ParamByName('TABELA').AsString  := NomeTabela;
      qry.ParamByName('FILIAL').AsInteger := Filial;
      qry.ParamByName('SERIE').AsInteger := StrToInt(SerieCupom);
      sds.Open;
      iSeq := sds.FieldByName('NUMREGISTRO').AsInteger;

      DMConection.FDConnection.Commit;
      Result := iSeq;
    except
      DMConection.FDConnection.Rollback;
      raise;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

end.
