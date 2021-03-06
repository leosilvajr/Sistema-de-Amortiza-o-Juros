unit unitViewSimulador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.ComCtrls, Math, Vcl.Mask;

type

  TfrmViewSimulador = class(TForm)
    pnlTopo: TPanel;
    lblCapital: TLabel;
    lblJuros: TLabel;
    lblPeriodos: TLabel;
    editTaxa: TEdit;
    btnSimular: TBitBtn;
    lvDetalles: TListView;
    editCapital: TEdit;
    editPeriodo: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EnterKeyPress(Sender: TObject; var Key: Char);
    procedure MudancaDeFoco(Sender:TObject);
    procedure btnSimularClick(Sender: TObject);

  private

  public

  end;

var
  frmViewSimulador: TfrmViewSimulador;

implementation

{$R *.dfm}

uses unitPrincipal;

{ TfrmSimulador }

procedure TfrmViewSimulador.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewSimulador.btnSimularClick(Sender: TObject);
var
  I: Integer;
  Periodos : Integer;
  Capital, Taxa, Amort,Juros,JurosAcumulado, Pag,CapitalAtualizado, JurosAtualizado : Real;
  Function formataValor(valor :real):String;
    Begin
      Result := FormatFloat('#,###,##0.00',valor);
    End;
Begin
  lvDetalles.Items.Clear;

  Capital := StrToFloatDef(editCapital.Text, 0);
  Taxa := StrToFloatDef(editTaxa.Text, 0)/100;
  Periodos := StrToIntDef(editPeriodo.Text, 0);

  Juros := 0;
  Amort := 0;
  Pag   := 0;
  CapitalAtualizado  := Capital;



    with lvDetalles.Items.Add() do //Inicial
    begin
      GroupID := 0;
      Caption := IntToStr(I);
      SubItems.Add(formataValor(Juros));
      SubItems.Add(formataValor(Amort));
      SubItems.Add(formataValor(Pag));
      SubItems.Add(formataValor(CapitalAtualizado));
    end;

  for I := 1 to Periodos do
  begin

    with lvDetalles.Items.Add() do //Periodos
    begin

      JurosAtualizado     := RoundTo(CapitalAtualizado * Taxa,-2);
      JurosAcumulado      := JurosAcumulado + JurosAtualizado;

      if I = Periodos then //Ultima Linha dos Periodos
      Begin
        Pag := RoundTo(CapitalAtualizado+JurosAtualizado,-2);
        CapitalAtualizado   := 0;
        Amort := Capital;
      End
      else
      begin
        JurosAtualizado     := RoundTo(CapitalAtualizado * Taxa,-2);
        CapitalAtualizado   := RoundTo(CapitalAtualizado + JurosAtualizado,-2);
      end;

      GroupID := 1;
      Caption := IntToStr(I);
      SubItems.Add(formataValor(JurosAtualizado));
      SubItems.Add(formataValor(Amort));
      SubItems.Add(formataValor(Pag));
      SubItems.Add(formataValor(CapitalAtualizado));
    end;
  end;

  with lvDetalles.Items.Add() do //Totais
  begin
      GroupID := 2;
      Caption := 'Totais';
      SubItems.Add(formataValor(JurosAcumulado));
      SubItems.Add(formataValor(Amort));
      SubItems.Add(formataValor(Pag));
      SubItems.Add(formataValor(CapitalAtualizado));
  end;
End;

procedure TfrmViewSimulador.EnterKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmViewSimulador.FormActivate(Sender: TObject);
begin
  MudancaDeFoco(nil);
end;


procedure TfrmViewSimulador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfrmViewSimulador.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
end;

procedure TfrmViewSimulador.FormCreate(Sender: TObject);
var
  I: Integer;

begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 7;
  Top := (GetSystemMetrics(SM_CYSCREEN) -  Height) div 10;

  for I := 0 to ComponentCount-1 do
    if Components[I] iS TEdit then
      (Components[I] as TEdit).OnEnter := MudancaDeFoco;
end;

procedure TfrmViewSimulador.MudancaDeFoco(Sender: TObject);
var
  I:Integer;
  Ed: TEdit;
begin
  for I := 0 to ComponentCount-1 do
  begin
    if Components[I] iS TEdit then
    Begin
      Ed:= Components[I] as TEdit;
      if Ed.Focused then
        Ed.Color := clYellow
      else
        Ed.Color :=clWhite;
    End;
  end;
end;

end.
