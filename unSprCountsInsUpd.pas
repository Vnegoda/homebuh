unit unSprCountsInsUpd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, Data.DB, DBAccess, Ora, MemDS, Vcl.Grids,
  Vcl.DBGrids;

type
  TfmSprCountsInsUpd = class(TForm)
    cbUserName: TcxLookupComboBox;
    cbValuta: TcxLookupComboBox;
    edComment: TcxTextEdit;
    edName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    bnSave: TcxButton;
    bnCancel: TcxButton;
    OraQUser: TOraQuery;
    OraDSUser: TOraDataSource;
    OraQValuta: TOraQuery;
    OraDSValuta: TOraDataSource;
    OraSP: TOraStoredProc;
    oraQFill: TOraQuery;
    OraDSFill: TOraDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    id: integer;
    procedure fillForm;
    { Public declarations }
  end;

var
  fmSprCountsInsUpd: TfmSprCountsInsUpd;

implementation

{$R *.dfm}

uses unDM;
{ TfmSprCountsInsUpd }

procedure TfmSprCountsInsUpd.bnSaveClick(Sender: TObject);
var
  lnResSp: integer;
  lsResSp: String;
  lcMessWide: PWideChar;
  lbOkCheck:boolean;
begin
  lbOkCheck:=true;
  if cbUserName.EditValue=null then
    begin
      application.MessageBox('Не указан владелец счета','',MB_ICONERROR);
      lbOkCheck:=false;
      ModalResult := mrNone;
      exit;
    end;
  if cbValuta.EditValue=null then
    begin
      application.MessageBox('Не указана валюта счета','',MB_ICONERROR);
      lbOkCheck:=false;
      ModalResult := mrNone;
      exit;
    end;

  if not dmOra.OraSession.Connected then
  begin
    dmOra.OraSession.Connected := true;
  end;
  if self.id = 0 then
  begin
    // добавление
    OraSP.StoredProcName := 'hbuh.spr_counts_ins';

    OraSP.Prepare;

    OraSP.ParamByName('v_id_user').AsInteger := cbUserName.EditValue;
    OraSP.ParamByName('v_name').AsString := edName.Text;
    OraSP.ParamByName('v_id_valut').AsInteger := cbValuta.EditValue;
    OraSP.ParamByName('v_comment').AsString := edComment.Text;

    OraSP.ParamByName('v_nout').AsInteger := 0;
    OraSP.ParamByName('v_sout').AsString := '';
    OraSP.ExecProc;

    lnResSp := OraSP.ParamByName('v_nout').AsInteger;
    lsResSp := OraSP.ParamByName('v_sout').AsString;

  end
  else
  begin
    // изменение
    OraSP.StoredProcName := 'hbuh.spr_counts_upd';

    OraSP.Prepare;
    OraSP.ParamByName('v_id').AsInteger := self.id;
    OraSP.ParamByName('v_id_user').AsInteger := cbUserName.EditValue;
    OraSP.ParamByName('v_name').AsString := edName.Text;
    OraSP.ParamByName('v_id_valut').AsInteger := cbValuta.EditValue;
    OraSP.ParamByName('v_comment').AsString := edComment.Text;

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
      application.MessageBox(lcMessWide, '', MB_OK + MB_ICONWARNING);
      ModalResult := mrNone;
    end;


end;

procedure TfmSprCountsInsUpd.fillForm;
begin
  edName.Clear;
  edComment.Clear;
  cbUserName.Clear;
  cbValuta.Clear;
  // заполнить списки с валютой и пользователями
  if not dmOra.OraSession.Connected then
  begin
    dmOra.OraSession.Connected := true;
  end;
  OraQUser.Active := false;
  OraQUser.SQL.Clear;
  OraQUser.SQL.Text := 'select * from hbuh.v_spr_user';
  OraQUser.Active := true;

  OraQValuta.Active := false;
  OraQValuta.SQL.Clear;
  OraQValuta.SQL.Text := 'select id,full_name from hbuh.v_spr_valut';
  OraQValuta.Active := true;

  if self.id <> 0 then
  begin
    oraQFill.Active := false;
    oraQFill.SQL.Clear;
    oraQFill.SQL.Text := 'select * from hbuh.v_spr_count where id=:v_id';
    oraQFill.Prepare;
    oraQFill.ParamByName('v_id').value := self.id;
    oraQFill.Active := true;

    if OraDSFill.DataSet.RecordCount > 0 then
    begin
      cbUserName.EditValue := oraQFill.FieldByName('id_user').AsInteger;
      edName.Text := oraQFill.FieldByName('name').AsString;
      edComment.Text := oraQFill.FieldByName('comm').AsString;
      cbValuta.EditValue := oraQFill.FieldByName('id_valut').AsInteger;
    end;

  end;
end;

procedure TfmSprCountsInsUpd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
