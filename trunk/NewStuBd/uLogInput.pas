unit uLogInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBCtrls, uWorkInput,
  MyDBNavigator, StdCtrls, Buttons, pngimage, ExtCtrls,DBGridEhImpExp,
  frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh, RzLstBox;

type
  TLogInput = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    pnl2: TPanel;
    DBMemo1: TDBMemo;
    DBEditEh1: TDBEditEh;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure cbb_XlccChange(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
  private
    { Private declarations }
    aForm :TWorkInput;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  LogInput: TLogInput;

implementation
uses uDM,uMain;
{$R *.dfm}

procedure TLogInput.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TLogInput.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TLogInput.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��¼�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TLogInput.btn_EditClick(Sender: TObject);
begin
  ClientDataSet1.Edit;
end;

procedure TLogInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TLogInput.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from ¼��Ա������־��',ClientDataSet1.Delta) then
    begin
      ClientDataSet1.MergeChangeLog;
      //Main.act_Win_WorkHintExecute(Self);
    end;
end;

procedure TLogInput.cbb_XlccChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TLogInput.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('����ʱ��').Value := FormatDateTime('yyyy-mm-dd',now);
  DataSet.FieldByName('����Ա').Value := gb_Czy_ID;
end;

procedure TLogInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TLogInput.FormCreate(Sender: TObject);
begin
  Open_Table;
end;

procedure TLogInput.Open_Table;
var
  sqlstr,sWhere :string;
begin
  sWhere := 'where ����Ա='+quotedstr(gb_Czy_ID)+
            ' and ����ʱ��='+quotedstr(FormatDateTime('yyyy-mm-dd',now));
  sqlstr := 'select * from ¼��Ա������־�� '+sWhere;
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
