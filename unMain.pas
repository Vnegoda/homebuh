unit unMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.StdActns;

type
  TfmMain = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    actExit: TAction;
    actOperatioin: TAction;
    actReportMonth: TAction;
    actSprCounts: TAction;
    actSprValut: TAction;
    actSprKateg: TAction;
    actOptions: TAction;
    actKursValut: TAction;
    actUser: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actExitExecute(Sender: TObject);
    procedure actSprValutExecute(Sender: TObject);
    procedure actSprCountsExecute(Sender: TObject);
    procedure actSprKategExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses unDM, unSprValut, unSprCounts, unSprCateg;

procedure TfmMain.actExitExecute(Sender: TObject);
begin
 dmOra.OraSession.Connected := false;
 Application.Terminate;
end;

procedure TfmMain.actSprCountsExecute(Sender: TObject);
begin
      if (not Assigned(fmSprValut)) then
    fmSprCounts := TfmSprCounts.Create(Application);
  fmSprCounts.fillForm;
  fmSprCounts.Show;
end;

procedure TfmMain.actSprKategExecute(Sender: TObject);
begin
      if (not Assigned(fmSprValut)) then
    fmSprCateg := TfmSprCateg.Create(Application);
//  fmSprCateg.fillForm;
  fmSprCateg.Show;
end;

procedure TfmMain.actSprValutExecute(Sender: TObject);
begin
  if (not Assigned(fmSprValut)) then
    fmSprValut := TfmSprValut.Create(Application);
  fmSprValut.fillForm;
  fmSprValut.Show;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmOra.OraSession.Connected := false;
end;

end.
