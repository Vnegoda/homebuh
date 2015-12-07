unit unSprValut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus, MemDS, DBAccess, Ora;

type
  TfmSprValut = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager1: TActionManager;
    actIns: TAction;
    actEDit: TAction;
    actDel: TAction;
    actREfresh: TAction;
    GridSprValut: TcxGrid;
    oqSprValut: TOraQuery;
    oradssprvalut: TOraDataSource;
    GridSprValutDBTableView1: TcxGridDBTableView;
    GridSprValutLevel2: TcxGridLevel;
    GridSprValutDBTableView1COD: TcxGridDBColumn;
    GridSprValutDBTableView1SHORT_NAME: TcxGridDBColumn;
    GridSprValutDBTableView1NAME: TcxGridDBColumn;
    GridSprValutDBTableView1ID: TcxGridDBColumn;
    OraSP: TOraStoredProc;
    procedure actREfreshExecute(Sender: TObject);
    procedure actInsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actEDitExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
  private
    { Private declarations }

  public
    procedure fillForm;
    { Public declarations }
  end;

var
  fmSprValut: TfmSprValut;

implementation

{$R *.dfm}

uses unDM, unInsUpdSprValut;

{ TfmSprValut }

procedure TfmSprValut.actDelExecute(Sender: TObject);
var
  lnResSp: integer;
  lsResSp: WideString;
  lcMessWide: PWideChar;
begin
if oradssprvalut.DataSet.RecordCount=0 then
  begin
       Application.MessageBox('Нет данных для удаления',
                 'Удаление позиции',  MB_ICONINFORMATION);
       exit;
  end;
  if Application.MessageBox('Вы уверены что нужно удалить значение?',
    'Удаление позиции', MB_YESNO + MB_ICONQUESTION) = IDNO then
    exit;

  if not dmOra.OraSession.Connected then
  begin
    dmOra.OraSession.Connected := true;
  end;

   OraSP.StoredProcName := 'hbuh.spr_valut_del';

    OraSP.Prepare;
    OraSP.ParamByName('v_id').AsInteger :=  oqSprValut.FieldByName('id').AsInteger;

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
    // StringToWideChar(lcResSp,lcMessWide, Length(lcResSp));
    lcMessWide := addr(lsResSp[1]);
    Application.MessageBox(lcMessWide, '', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TfmSprValut.actEDitExecute(Sender: TObject);
begin
 fmInsUpdSprValut := TfmInsUpdSprValut.Create(nil); // создание Формы)
  fmInsUpdSprValut.id := oradssprvalut.DataSet.FieldByName('id').AsInteger ;
  fmInsUpdSprValut.fillForm;

  fmInsUpdSprValut.ShowModal;
  if fmInsUpdSprValut.ModalResult = idok then
    self.fillform;
  fmInsUpdSprValut.Free;
end;

procedure TfmSprValut.actInsExecute(Sender: TObject);
begin
 fmInsUpdSprValut := TfmInsUpdSprValut.Create(nil); // создание Формы)
  fmInsUpdSprValut.id := 0;
  fmInsUpdSprValut.fillForm;

  fmInsUpdSprValut.ShowModal;
  if fmInsUpdSprValut.ModalResult = idok then
    self.fillform;
  fmInsUpdSprValut.Free;

end;

procedure TfmSprValut.actREfreshExecute(Sender: TObject);
begin
  self.fillForm;
end;

procedure TfmSprValut.fillForm;
begin
  oqSprValut.SQL.Clear;
   if not dmOra.OraSession.Connected then
     dmOra.OraSession.Connected := true;
   self.oqSprValut.SQL.Text:='select * from hbuh.v_spr_valut';
   self.oqSprValut.Active:=true;
   self.Refresh;


end;

procedure TfmSprValut.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

end.
