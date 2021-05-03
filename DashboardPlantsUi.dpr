program DashboardPlantsUi;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {frmPrincipal},
  UnitFramePlants in 'UnitFramePlants.pas' {frmFramePlants: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
