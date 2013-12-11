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
  if Application.MessageBox('���ҪΪ������ί����Ψһ���ǩ������', 'ϵͳ��ʾ', 
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if UpperCase(InputBox('����ȷ��','�����롾OK��ȷ�ϣ�',''))='OK' then
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
  if Application.MessageBox('���Ҫɾ����ǰ��¼��', 'ϵͳ��ʾ', MB_YESNO + 
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
  dm.PrintReport('��ίǩ�����ǩ.fr3',ClientDataSet1.XMLData,1);
end;

procedure TXkPwSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkPwSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from У����ί������',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkPwSet.cbb_yxChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkPwSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').Value := cbb_yx.Text;
end;

procedure TXkPwSet.CreateRandomPwd;
var
  i,iCount,iLen:Integer;
  lBase:LongInt;
  s:string;
  sList: TStringList;
begin
  iLen := 4;//4λ����
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
      ClientDataSet1.FieldByName('ǩ����').AsString := sList[i];
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
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
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
      //cbb_Yx.Items.Add('����Ժϵ');
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
      //sList.Add('����Ժϵ');
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
  sqlstr := 'select * from У����ί������ where �п�Ժϵ='+quotedstr(cbb_yx.Text);
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
