program homeBuh;

uses
  Vcl.Forms,
  unMain in 'unMain.pas' {fmMain},
  unDM in 'unDM.pas' {dmOra: TDataModule},
  unLoginForm in 'unLoginForm.pas' {fmLogin},
  unSprValut in 'unSprValut.pas' {fmSprValut},
  unInsUpdSprValut in 'unInsUpdSprValut.pas' {fmInsUpdSprValut};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TdmOra, dmOra);
  Application.CreateForm(TfmLogin, fmLogin);
  Application.CreateForm(TfmInsUpdSprValut, fmInsUpdSprValut);
  fmLogin.showmodal;
  if fmLogin.isConnected=false then
    begin
      Application.Terminate;
    end;


  Application.Run;
end.
