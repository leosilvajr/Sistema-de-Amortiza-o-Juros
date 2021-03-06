unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.ComCtrls, unitViewSimulador;

type
  TfrmPrincipal = class(TForm)
    pnlTopo: TPanel;
    Label1: TLabel;
    pnlMenu: TPanel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    timer: TTimer;
    statusBar: TStatusBar;
    procedure timerTimer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses unitSplash;


procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.BitBtn3Click(Sender: TObject);
begin
  Application.CreateForm(TfrmViewSimulador, frmViewSimulador);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmSplash := TfrmSplash.Create(nil);
  try
    frmSplash.ShowModal;
  finally
    FreeAndNil(frmSplash);
  end;
end;

procedure TfrmPrincipal.timerTimer(Sender: TObject);
begin
  statusBar.Panels.Items[1].Text :=TimeToStr(now);
  statusBar.Panels.Items[0].Text :=DateToStr(now);
end;

end.
