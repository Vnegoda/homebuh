unit unSprCounts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, Ora, DBAccess, MemDS, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls,
  Vcl.ActnMenus, Vcl.Grids, Vcl.DBGrids;

type
  TfmSprCounts = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager1: TActionManager;
    actIns: TAction;
    actEDit: TAction;
    actDel: TAction;
    actREfresh: TAction;
    oqSprCount: TOraQuery;
    oradssprcount: TOraDataSource;
    OraSP: TOraStoredProc;
    grSprCountDBTableView1: TcxGridDBTableView;
    grSprCountLevel1: TcxGridLevel;
    grSprCount: TcxGrid;
    grSprCountDBTableView1Column1: TcxGridDBColumn;
    grSprCountDBTableView1Column2: TcxGridDBColumn;
    grSprCountDBTableView1Column3: TcxGridDBColumn;
    grSprCountDBTableView1Column4: TcxGridDBColumn;
    procedure actREfreshExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actInsExecute(Sender: TObject);
    procedure actEDitExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
  private
    { Private declarations }
  public
  procedure fillform;
    { Public declarations }
  end;

var
  fmSprCounts: TfmSprCounts;

implementation

{$R *.dfm}

uses unDM, unSprCountsInsUpd;

procedure TfmSprCounts.actDelExecute(Sender: TObject);
var
  lnResSp: integer;
  lsResSp: WideString;
  lcMessWide: PWideChar;
begin


      if oradssprcount.DataSet.RecordCount=0 then
  begin
       Application.MessageBox('Нет данных для удаления',
                 'Удаление позиции',  MB_ICONINFORMATION);
       exit;
  end;

  if Application.MessageBox('Вы уверены что нужно удалить значение?',
    'Удаление позиции', MB_YESNO + MB_ICONQUESTION) = IDNO then
    exit;

   if not dmOra.OraSession.Connected then
     dmOra.OraSession.Connected := true;
     OraSP.StoredProcName := 'hbuh.spr_counts_del';

    OraSP.Prepare;
    OraSP.ParamByName('v_id').AsInteger :=  oqSprCount.FieldByName('id').AsInteger;

    OraSP.ParamByName('v_nout').AsInteger := 0;
    OraSP.ParamByName('v_sout').AsString := '';
    OraSP.ExecProc;

    lnResSp := OraSP.ParamByName('v_nout').AsInteger;
    lsResSp := OraSP.ParamByName('v_sout').AsString;

  if lnResSp = 1 then
  begin
    self.fillform;
  end
  else
  begin
    lsResSp := 'При выполнении удаления произошла ошибка: № ' +
      inttostr(lnResSp) + ' - ' + lsResSp;
    lcMessWide := addr(lsResSp[1]);
    Application.MessageBox(lcMessWide, '', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TfmSprCounts.actEDitExecute(Sender: TObject);
begin
 fmSprCountsInsUpd := TfmSprCountsInsUpd.Create(nil); // создание Формы)
  fmSprCountsInsUpd.id := oradssprcount.DataSet.FieldByName('id').AsInteger ;
  fmSprCountsInsUpd.fillForm;

  fmSprCountsInsUpd.ShowModal;
  if fmSprCountsInsUpd.ModalResult = idok then
    self.fillform;
  fmSprCountsInsUpd.Free;
end;

procedure TfmSprCounts.actInsExecute(Sender: TObject);
begin
 fmSprCountsInsUpd := TfmSprCountsInsUpd.Create(nil); // создание Формы)
  fmSprCountsInsUpd.id := 0;
  fmSprCountsInsUpd.fillForm;

  fmSprCountsInsUpd.ShowModal;
  if fmSprCountsInsUpd.ModalResult = idok then
    self.fillform;
  fmSprCountsInsUpd.Free;

end;

procedure TfmSprCounts.actREfreshExecute(Sender: TObject);
begin
  self.fillform;
end;

procedure TfmSprCounts.fillform;
begin
  oqSprCount.SQL.Clear;
   if not dmOra.OraSession.Connected then
     dmOra.OraSession.Connected := true;
   self.oqSprCount.SQL.Text:='select * from hbuh.v_spr_count';
   self.oqSprCount.Active:=true;
   self.Refresh;

end;

procedure TfmSprCounts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
end;

end.
