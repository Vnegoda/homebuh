program homeBuh;

uses
  Vcl.Forms,
  unMain in 'unMain.pas' {fmMain},
  unDM in 'unDM.pas' {dmOra: TDataModule},
  unLoginForm in 'unLoginForm.pas' {fmLogin},
  unSprValut in 'unSprValut.pas' {fmSprValut},
  unInsUpdSprValut in 'unInsUpdSprValut.pas' {fmInsUpdSprValut},
  unSprCounts in 'unSprCounts.pas' {fmSprCounts},
  unSprCountsInsUpd in 'unSprCountsInsUpd.pas' {fmSprCountsInsUpd},
  unSprCateg in 'unSprCateg.pas' {fmSprCateg},
  unSprCategInsUpd in 'unSprCategInsUpd.pas' {fmSprCategInsUpd};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TdmOra, dmOra);
  Application.CreateForm(TfmLogin, fmLogin);
  fmLogin.showmodal;
  if fmLogin.isConnected=false then
    begin
      Application.Terminate;
    end;


  Application.Run;
end.
