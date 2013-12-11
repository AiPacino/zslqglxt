unit uXkPwSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, DBGridEhGrouping, Menus, dxGDIPlusClasses;

type
  TXkPwSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Save: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp1: TGroupBox;
    cbb_yx: TComboBox;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn1: TBitBtn;
    btn_Print: TBitBtn;
    MainMenu1: TMainMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure btn_DelClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure cbb_yxChange(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
    procedure CreateRandomPwd;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkPwSet: TXkPwSet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkPwSet.btn1Click(Sender: TObject);
begin
  if Application.MessageBox('真的要为所有评委生成唯一随机签到码吗？', '系统提示', 
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if UpperCase(InputBox('操作确认','请输入【OK】确认：',''))='OK' then
  begin
    CreateRandomPwd;
    btn_Save.Click;
  end;
end;

procedure TXkPwSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TXkPwSet.btn_DelClick(Sender: TObject);
begin
  if Application.MessageBox('真的要删除当前记录吗？', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_SaveClick(Self);
  end;
end;

procedure TXkPwSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkPwSet.btn_PrintClick(Sender: TObject);
begin
  dm.PrintReport('评委签到码便签.fr3',ClientDataSet1.XMLData,1);
end;

procedure TXkPwSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkPwSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 校考评委名单表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkPwSet.cbb_yxChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkPwSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('承考院系').Value := cbb_yx.Text;
end;

procedure TXkPwSet.CreateRandomPwd;
var
  i,iCount,iLen:Integer;
  lBase:LongInt;
  s:string;
  sList: TStringList;
begin
  iLen := 4;//4位长度
  lBase := 9999;
  iCount := ClientDataSet1.RecordCount;
  sList := TStringList.Create;
  try
    Randomize;
    i := 0;
    while i<iCount do
    begin
      s := Format('%.4d',[Random(lBase)]);
      if sList.IndexOf(s)=-1 then
      begin
        sList.Add(s);
        i := i+1;
      end;
    end;
    i := 0;
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('签到码').AsString := sList[i];
      ClientDataSet1.Next;
      i := i+1;
    end;
  finally
    sList.Free;
  end;
end;

procedure TXkPwSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkPwSet.FormCreate(Sender: TObject);
begin
  GetYxList;
  cbb_yx.Enabled := gb_Czy_Level='-1';
  if gb_Czy_Level<>'-1' then
    cbb_yx.Text := gb_Czy_Dept;
  Open_Table;
end;

procedure TXkPwSet.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      //dm.GetAllYxList(sList);
      //cbb_Yx.Items.Add('不限院系');
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
      //sList.Add('不限院系');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 1;
  finally
    sList.Free;
  end;
end;

procedure TXkPwSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考评委名单表 where 承考院系='+quotedstr(cbb_yx.Text);
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
