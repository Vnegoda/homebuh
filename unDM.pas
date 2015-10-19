unit unDM;

interface

uses
  System.SysUtils, System.Classes, OraCall, Data.DB, DBAccess, Ora;

type
  TdmOra = class(TDataModule)
    OraSession: TOraSession;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmOra: TdmOra;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
