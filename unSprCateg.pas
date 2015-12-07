unit unSprCateg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxTLData, cxDBTL, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Data.DB, DBAccess, Ora, MemDS, cxMaskEdit, Vcl.ComCtrls, dxtree, dxdbtree,
  Vcl.ImgList, Vcl.Menus, dxdbtrel;

type
  TfmSprCateg = class(TForm)
    ActionManager1: TActionManager;
    actREfresh: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    oraQTree: TOraQuery;
    OraDSTree: TOraDataSource;
    dxDBTreeCateg: TdxDBTreeView;
    PopupMenu1: TPopupMenu;
    actEdit: TAction;
    N1: TMenuItem;
    actAdd: TAction;
    N2: TMenuItem;
    actDel: TAction;
    oraSPDel: TOraStoredProc;
    N3: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actREfreshExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSprCateg: TfmSprCateg;

implementation

{$R *.dfm}

uses unSprCategInsUpd, unDM;

procedure TfmSprCateg.actAddExecute(Sender: TObject);
var idNode:integer;
begin

idNode:= OraDSTree.DataSet.FieldByName('id').AsInteger;


 fmSprCategInsUpd := TfmSprCategInsUpd.Create(nil); // создание Формы)

  fmSprCategInsUpd.id_parent := idNode;
    fmSprCategInsUpd.id := 0;
  fmSprCategInsUpd.fillForm;

  fmSprCategInsUpd.ShowModal;
  if fmSprCategInsUpd.ModalResult = idok then
    actREfresh.Execute;
  fmSprCategInsUpd.Free;

end;
procedure TfmSprCateg.actDelExecute(Sender: TObject);
var
  lnResSp: integer;
  lsResSp: WideString;
  lcMessWide: PWideChar;
  var idNode:integer;
begin
if OraDSTree.DataSet.RecordCount=0 then
  begin
       Application.MessageBox('Нет данных для удаления',
                 'Удаление позиции',  MB_ICONINFORMATION);
       exit;
  end;
  if Application.MessageBox('Вы уверены что нужно удалить значение?',
    'Удаление позиции', MB_YESNO + MB_ICONQUESTION) = IDNO then
    exit;

  idNode:= OraDSTree.DataSet.FieldByName('id').AsInteger;
  if not dmOra.OraSession.Connected then
  begin
    dmOra.OraSession.Connected := true;
  end;

   oraSPDel.StoredProcName := 'hbuh.spr_category_del';

    oraSPDel.Prepare;
    oraSPDel.ParamByName('v_id').AsInteger :=  idNode;

    oraSPDel.ParamByName('v_nout').AsInteger := 0;
    oraSPDel.ParamByName('v_sout').AsString := '';
    oraSPDel.ExecProc;

    lnResSp := oraSPDel.ParamByName('v_nout').AsInteger;
    lsResSp := oraSPDel.ParamByName('v_sout').AsString;

  if lnResSp = 1 then
  begin
    actREfresh.Execute;
  end
  else
  begin
    lsResSp := 'При выполнении удаления произошла ошибка: № ' +
      inttostr(lnResSp) + ' - ' + lsResSp;
    // StringToWideChar(lcResSp,lcMessWide, Length(lcResSp));
    lcMessWide := addr(lsResSp[1]);
    Application.MessageBox(lcMessWide, '', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TfmSprCateg.actEditExecute(Sender: TObject);
var idNode:integer;
begin

idNode:= OraDSTree.DataSet.FieldByName('id').AsInteger;


 fmSprCategInsUpd := TfmSprCategInsUpd.Create(nil); // создание Формы)
//  fmSprCategInsUpd.id := 0;
     fmSprCategInsUpd.id := idNode;
  fmSprCategInsUpd.fillForm;

  fmSprCategInsUpd.ShowModal;
  if fmSprCategInsUpd.ModalResult = idok then
    actREfresh.Execute;
  fmSprCategInsUpd.Free;

end;

procedure TfmSprCateg.actREfreshExecute(Sender: TObject);
begin
oraQTree.Active:=false;
oraQTree.sql.Clear;
oraQTree.sql.Text:='select * from hbuh.v_spr_category';
oraQTree.Active:=true;
{OraDSTree.Edit;
OraDSTree.DataSet.Append;
OraDSTree.DataSet.FieldByName('id').AsInteger:=0;
OraDSTree.DataSet.FieldByName('id_parent').AsInteger:=-1;
OraDSTree.DataSet.FieldByName('is_rashod').AsInteger:=-1;
OraDSTree.DataSet.FieldByName('Name').AsString:='ВСЕ КАТЕГОРИИ';
oraQTree.Post;
dxDBTreeCateg.Refresh;
}
end;

procedure TfmSprCateg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=caFree;

end;

procedure TfmSprCateg.FormCreate(Sender: TObject);
begin
  actREfresh.Execute;
end;

end.
