unit unitControllerSimulador;

interface

type
   TRegistro = record
     Periodo : string;
     Juros : real;
     Amort : real;
     Pag : real;
     Saldo : real;
   end;

  TListaRegistros = array of TRegistro;

  TControllerSimulador = class

  class function SimularAmortizacao(rCapital, rTaxa: real; iNumPeriodos: integer): TListaRegistros;
  end;

implementation

uses
  unitModelSimulador;

  { TControllerSimulador }

class function TControllerSimulador.SimularAmortizacao(rCapital, rTaxa: real; iNumPeriodos: integer): TListaRegistros;
var
  Simulador : TSimulador;
begin
  Simulador := TSimulador.Create;
  try

    Simulador.Capital := rCapital;
    Simulador.Taxa := rTaxa;
    Simulador.NumPeriodos := iNumPeriodos;
    Result := Simulador.SimularAmortizacao;
  finally
    Simulador.Free;
  end;
end;

end.


