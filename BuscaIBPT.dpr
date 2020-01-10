program BuscaIBPT;

uses
  Vcl.Forms,
  uConsultaIBPT in 'uConsultaIBPT.pas' {frmBuscaIBPT},
  DmdConnection in 'DmdConnection.pas' {DMConection: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  udmCadNCM in 'udmCadNCM.pas' {DMCadNCM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.CreateForm(TDMConection, DMConection);
  Application.CreateForm(TfrmBuscaIBPT, frmBuscaIBPT);
  Application.CreateForm(TDMCadNCM, DMCadNCM);
  Application.Run;
end.
