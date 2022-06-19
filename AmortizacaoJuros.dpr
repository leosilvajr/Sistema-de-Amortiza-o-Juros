program AmortizacaoJuros;

uses
  Vcl.Forms,
  unitPrincipal in 'unitPrincipal.pas' {frmPrincipal},
  unitViewSimulador in 'View\unitViewSimulador.pas' {frmViewSimulador},
  unitSplash in 'unitSplash.pas' {frmSplash};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
