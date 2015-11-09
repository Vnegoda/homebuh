unit unLoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,IniFiles;

type
  TfmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edLogin: TEdit;
    edPassword: TEdit;
    bnOk: TButton;
    bnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure bnOkClick(Sender: TObject);
    procedure edLoginKeyPress(Sender: TObject; var Key: Char);
    procedure edPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    cntLogin:byte;   // количество попыток подключения
    sLogin,sServeName:string;
    { Private declarations }
  public
  isConnected:Boolean;
     { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

{$R *.dfm}

uses unDm;

procedure TfmLogin.bnOkClick(Sender: TObject);
var
 Ini: Tinifile;

begin


  //Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Config.ini');
//  sLogin:=trim(Ini.ReadString('Server','Login',''));


 // Ini.Free;
//  Self.edLogin.Text:=sLogin;
//  sConnection:='Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Data Source=vova-pk;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=VOVA-PK;Use Encryption for Data=False;Tag with column collation when possible=False;';
//  sConnection:='Provider=SQLOLEDB.1;Persist Security Info=False;User ID='+sLogin+';Data Source='+sServeName+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;Tag with column collation when possible=False;';
  // sConnection:='Provider=SQLOLEDB.1;Password='+Self.edPassword.Text+';Persist Security Info=True;User ID='+self.edLogin.Text+';Data Source='+sServeName;


  //dmOra.OraSession.ConnectionString :=  sConnection;
   dmOra.OraSession.Server:=  trim(self.sServeName);
   dmOra.OraSession.Username:=  trim(self.edLogin.Text);
   dmOra.OraSession.Password:=trim(self.edPassword.Text);

 try
  if not dmOra.OraSession.Connected then
     dmOra.OraSession.Connected := true;
    Self.isConnected:=true;
 except
     if cntLogin<3 then
     begin
         ModalResult := mrNone;

     end;
     cntLogin:=cntLogin+1;
     application.MessageBox('Подключиться не удалось','',MB_OK+MB_ICONWARNING);

 end;
end;

procedure TfmLogin.edLoginKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
  begin
    Key := #0; //чтоб не было звука на нажатие ентер
    self.edPassword.SetFocus;
  end;
end;

procedure TfmLogin.edPasswordKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
   begin
    Key := #0; //чтоб не было звука на нажатие ентер
    self.bnOk.Click;
   end;
end;

procedure TfmLogin.FormCreate(Sender: TObject);
var
 Ini: Tinifile;

begin
  cntLogin:=1;
  SELF.isConnected:=FALSE;
  self.edLogin.Clear;
  self.edPassword.Clear;


  self.sLogin:='';
  self.sServeName:='';

   Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Config.ini');
   self.sLogin:=trim(Ini.ReadString('Server','Login',''));
     self.sServeName:= Trim( Ini.ReadString('Server','ServerName',''));

   self.edLogin.Text:=self.sLogin;
   self.edPassword.Text:='111'; //убрать после дебага

   Ini.Free;
end;

end.
