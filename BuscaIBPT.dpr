program BuscaIBPT;

uses
  Vcl.Forms,
  uConsultaIBPT in 'uConsultaIBPT.pas' {Form1},
  DmdConnection in 'DmdConnection.pas' {DMConection: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  udmCadNCM in 'udmCadNCM.pas' {DMCadNCM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConection, DMConection);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDMCadNCM, DMCadNCM);
  Application.Run;
end.
