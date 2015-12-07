unit unSprCategInsUpd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxdbtrel, Data.DB, MemDS, DBAccess, Ora,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, Vcl.Menus, Vcl.ComCtrls, dxtree, dxdbtree,
  cxGroupBox, cxRadioGroup, cxLabel, cxButtons;

type
  TfmSprCategInsUpd = class(TForm)
    oraDSFillParent: TOraDataSource;
    oraQFillParent: TOraQuery;
    peParentCateg: TcxPopupEdit;
    dxDBTreeView1: TdxDBTreeView;
    cxLabel1: TcxLabel;
    edNameCateg: TcxTextEdit;
    cxLabel2: TcxLabel;
    rgTypeDvig: TcxRadioGroup;
    bnCancel: TcxButton;
    bnOk: TcxButton;
    oraSPSave: TOraStoredProc;
    oraDSFill: TOraDataSource;
    oraQFill: TOraQuery;
    procedure dxDBTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure dxDBTreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure dxDBTreeView1DblClick(Sender: TObject);
    procedure bnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id:integer;
    id_parent:integer;
    procedure fillform;

  end;

var
  fmSprCategInsUpd: TfmSprCategInsUpd;

implementation

{$R *.dfm}

uses unDM;

procedure TfmSprCategInsUpd.bnOkClick(Sender: TObject);
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
    oraSPSave.StoredProcName := 'hbuh.spr_category_ins';

    oraSPSave.Prepare;

    oraSPSave.ParamByName('v_id_parent').AsInteger :=  oraDSFillParent.DataSet.FieldByName('id').AsInteger ;
    oraSPSave.ParamByName('v_is_rashod').AsInteger := rgTypeDvig.ItemIndex;
    oraSPSave.ParamByName('v_name').AsString := edNameCateg.Text;

    oraSPSave.ParamByName('v_nout').AsInteger := 0;
    oraSPSave.ParamByName('v_sout').AsString := '';
    oraSPSave.ExecProc;

    lnResSp := oraSPSave.ParamByName('v_nout').AsInteger;
    lsResSp := oraSPSave.ParamByName('v_sout').AsString;

  end
  else
  begin
    // изменение
    oraSPSave.StoredProcName := 'hbuh.spr_category_upd';

    oraSPSave.Prepare;
     oraSPSave.ParamByName('v_id').AsInteger :=  self.id;
    oraSPSave.ParamByName('v_id_parent').AsInteger :=  oraDSFillParent.DataSet.FieldByName('id').AsInteger ;
    oraSPSave.ParamByName('v_is_rashod').AsInteger := rgTypeDvig.ItemIndex;
    oraSPSave.ParamByName('v_name').AsString := edNameCateg.Text;

    oraSPSave.ParamByName('v_nout').AsInteger := 0;
    oraSPSave.ParamByName('v_sout').AsString := '';
    oraSPSave.ExecProc;

    lnResSp := oraSPSave.ParamByName('v_nout').AsInteger;
    lsResSp := oraSPSave.ParamByName('v_sout').AsString;
    oraSPSave.ExecProc;

    lnResSp := oraSPSave.ParamByName('v_nout').AsInteger;
    lsResSp := oraSPSave.ParamByName('v_sout').AsString;
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
procedure TfmSprCategInsUpd.dxDBTreeView1Change(Sender: TObject;
  Node: TTreeNode);
begin
peParentCateg.Text:= Node.Text;
end;

procedure TfmSprCategInsUpd.dxDBTreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
peParentCateg.Text:= Node.Text;
end;

procedure TfmSprCategInsUpd.dxDBTreeView1DblClick(Sender: TObject);
begin
peParentCateg.PopupWindow.ClosePopup;
end;

procedure TfmSprCategInsUpd.fillform;
var id_parent:integer;
begin
    id_parent:=0;
      peParentCateg.Text:='';
    edNameCateg.Text:='';

     oraQFillParent.Active:=false;
     oraQFillParent.SQL.Clear;
     oraQFillParent.SQL.Text:='select * from hbuh.v_spr_category';
     oraQFillParent.Active:=true;

     if self.id<>0 then
     begin
     oraQFill.Active:=false;
     oraQFill.SQL.Clear;
     oraQFill.SQL.Text:='select * from V_SPR_CATEGORY where id=:nID';
     oraQFill.Prepare;
     oraQFill.ParamByName('nID').AsInteger:=self.id;
     oraQFill.Active:=true;

     id_parent:= oraQFill.FieldByName('id_parent').AsInteger;
     edNameCateg.Text:=oraQFill.FieldByName('name').AsString;
     rgTypeDvig.ItemIndex:=oraQFill.FieldByName('is_rashod').AsInteger;


     end;


     if self.id<>0 then
     begin
       oraDSFillParent.DataSet.Locate('id',id_parent,[loCaseInsensitive]);
     end
     else
     begin
       oraDSFillParent.DataSet.Locate('id',self.id_parent,[loCaseInsensitive]);
     end;



end;

end.
