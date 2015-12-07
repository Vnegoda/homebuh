unit unInsUpdSprValut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxLabel, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, Data.DB, MemDS, DBAccess, Ora;

type
  TfmInsUpdSprValut = class(TForm)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxedAbbr: TcxTextEdit;
    cxedShortName: TcxTextEdit;
    cxedName: TcxTextEdit;
    bnCancel: TcxButton;
    bnSave: TcxButton;
    oraQFill: TOraQuery;
    OraSP: TOraStoredProc;
    procedure bnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxedAbbrKeyPress(Sender: TObject; var Key: Char);
    procedure cxedShortNameKeyPress(Sender: TObject; var Key: Char);
    procedure cxedNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    id: integer;
    { Public declarations }
    procedure fillform;

  end;

var
  fmInsUpdSprValut: TfmInsUpdSprValut;

implementation

{$R *.dfm}

uses unDM;

procedure TfmInsUpdSprValut.bnSaveClick(Sender: TObject);
var
  lnResSp: integer;
  lsResSp: String;
   lcMessWide: PWideChar;
begin
  if not dmOra.OraSession.Connected then
  begin
    dmOra.OraSession.Connected := true;
  end;
  if self.id = 0 then
  begin
    // добавление
    OraSP.StoredProcName := 'hbuh.spr_valut_ins';

    OraSP.Prepare;

    OraSP.ParamByName('v_cod').AsString := cxedAbbr.Text;
    OraSP.ParamByName('v_short_name').AsString := cxedShortName.Text;
    OraSP.ParamByName('v_name').AsString := cxedName.Text;

    OraSP.ParamByName('v_nout').AsInteger := 0;
    OraSP.ParamByName('v_sout').AsString := '';
    OraSP.ExecProc;

    lnResSp := OraSP.ParamByName('v_nout').AsInteger;
    lsResSp := OraSP.ParamByName('v_sout').AsString;

  end
  else
  begin
    // изменение
    OraSP.StoredProcName := 'hbuh.spr_valut_upd';

    OraSP.Prepare;
    OraSP.ParamByName('v_id').AsInteger := self.id;
    OraSP.ParamByName('v_cod').AsString := cxedAbbr.Text;
    OraSP.ParamByName('v_short_name').AsString := cxedShortName.Text;
    OraSP.ParamByName('v_name').AsString := cxedName.Text;

    OraSP.ParamByName('v_nout').AsInteger := 0;
    OraSP.ParamByName('v_sout').AsString := '';
    OraSP.ExecProc;

    lnResSp := OraSP.ParamByName('v_nout').AsInteger;
    lsResSp := OraSP.ParamByName('v_sout').AsString;
  end;
       if lnResSp = 1 then
    begin
      ModalResult := mrOk;
    end
  else
    begin
      lsResSp := 'При выполнении сохранения произошла ошибка: № ' +
        inttostr(lnResSp) + ' - ' + lsResSp;

      lcMessWide := addr(lsResSp[1]);
      Application.MessageBox(lcMessWide, '', MB_OK + MB_ICONWARNING);
      ModalResult := mrNone;
    end;
end;

procedure TfmInsUpdSprValut.cxedAbbrKeyPress(Sender: TObject; var Key: Char);
begin
 if (key=#13) then
  begin
    key:=#0;
    self.cxedShortName.SetFocus;
  end;
end;

procedure TfmInsUpdSprValut.cxedNameKeyPress(Sender: TObject; var Key: Char);
begin
 if (key=#13) then
  begin
    key:=#0;
    self.bnSave.SetFocus;
  end;
end;

procedure TfmInsUpdSprValut.cxedShortNameKeyPress(Sender: TObject;
  var Key: Char);
begin
 if (key=#13) then
  begin
    key:=#0;
    self.cxedName.SetFocus;
  end;
end;

procedure TfmInsUpdSprValut.fillform;
begin
  self.cxedAbbr.Clear;
  self.cxedShortName.Clear;
  self.cxedName.Clear;
  if self.id <> 0 then
  begin
    // fill form for id record
    if not dmOra.OraSession.Connected then
    begin
      dmOra.OraSession.Connected := true;
    end;
    oraQFill.SQL.Clear;
    oraQFill.SQL.Text := 'select * from hbuh.spr_valut where id=:id';
    oraQFill.ParamByName('id').Value := self.id;
    oraQFill.Active := true;

    cxedAbbr.Text := oraQFill.FieldByName('cod').AsString;
    cxedShortName.Text := oraQFill.FieldByName('short_name').AsString;
    cxedName.Text := oraQFill.FieldByName('name').AsString;

  end;



end;

procedure TfmInsUpdSprValut.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

end.
