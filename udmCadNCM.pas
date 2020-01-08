unit udmCadNCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DmdConnection;

type
  TDMCadNCM = class(TDataModule)
    fdtCadNCM: TFDMemTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCadNCM: TDMCadNCM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
