unit uCountXkCjInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls, DB,
  DBClient, GridsEh, DBGridEh, RzPanel, RzRadGrp, Menus, DBGridEhImpExp,
  Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TCountXkCjInfo = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Excel: TBitBtn;
    btn_Refresh: TBitBtn;
    GroupBox1: TGroupBox;
    dxgrd_1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    N1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    mi_Export: TMenuItem;
    btn_RefreshBdl: TBitBtn;
    mi_RefreshBdl: TMenuItem;
    btn_Print: TBitBtn;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    RzRadioGroup1: TRzRadioGroup;
    cbb_Yx: TDBComboBoxEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzRadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);
    procedure mi_RefreshBdlClick(Sender: TObject);
    procedure btn_RefreshBdlClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
  private
    { Private declarations }
    sqlList:TStrings;
    procedure GetYxList;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  CountXkCjInfo: TCountXkCjInfo;

implementation
uses uDM;
{$R *.dfm}

procedure TCountXkCjInfo.BitBtn1Click(Sender: TObject);
begin
  //DM.ExecSql('ALTER TABLE dbo.У�����Ƴɼ��� ADD �ɼ�1_1 float, �ɼ�1_2 float, �ɼ�2_1 float, �ɼ�2_2 float, �ɼ�1���� int, �ɼ�2���� int, �ɼ�1�Ƿ��ύ bit,�ɼ�2�Ƿ��ύ int');
  dm.ExecSql('ALTER VIEW [dbo].[View_У�����Ƴɼ���] as '+
' SELECT     dbo.У�����Ƴɼ���.Id, dbo.У�����Ƴɼ���.�п�Ժϵ, dbo.У��������Ϣ��.������, dbo.У��������Ϣ��.׼��֤��, dbo.У��������Ϣ��.���֤��,'+
'                      dbo.У��������Ϣ��.����, dbo.У��������Ϣ��.�Ա�, dbo.У��������Ϣ��.ʡ��, dbo.У�����Ƴɼ���.���Կ�Ŀ, dbo.У�����Ƴɼ���.�ɼ�1,'+
'                      dbo.У�����Ƴɼ���.����Ա1, dbo.У�����Ƴɼ���.�ɼ�2, dbo.У�����Ƴɼ���.����Ա2, dbo.У�����Ƴɼ���.���ճɼ�, dbo.У�����Ƴɼ���.�����,'+
'                      dbo.У�����Ƴɼ���.����, dbo.У��������Ϣ��.��ϵ�绰, dbo.У��������Ϣ��.��������, dbo.У��������Ϣ��.ͨ�ŵ�ַ,'+
'                      dbo.У�����Ƴɼ���.�ɼ�1_1, dbo.У�����Ƴɼ���.�ɼ�1_2,'+
'                      dbo.У�����Ƴɼ���.�ɼ�2_1, dbo.У�����Ƴɼ���.�ɼ�2_2, dbo.У�����Ƴɼ���.�ɼ�1_����, dbo.У�����Ƴɼ���.�ɼ�2_����,'+
'                      dbo.У�����Ƴɼ���.�ɼ�1�Ƿ��ύ, dbo.У�����Ƴɼ���.�ɼ�2�Ƿ��ύ'+
' FROM         dbo.У�����Ƴɼ��� INNER JOIN '+
'                      dbo.У��������Ϣ�� ON dbo.У�����Ƴɼ���.������ = dbo.У��������Ϣ��.������');
end;

procedure TCountXkCjInfo.btn_ExcelClick(Sender: TObject);
begin
  dm.ExportDBEditEH(dxgrd_1);
end;

procedure TCountXkCjInfo.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCountXkCjInfo.btn_PrintClick(Sender: TObject);
begin
  PrintDBGridEH(dxgrd_1,Self,RzRadioGroup1.Items[RzRadioGroup1.ItemIndex]);
end;

procedure TCountXkCjInfo.btn_RefreshBdlClick(Sender: TObject);
begin
  mi_RefreshBdl.Click;
end;

procedure TCountXkCjInfo.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCountXkCjInfo.cbb_YxChange(Sender: TObject);
begin
  if Self.Showing then
  begin
    btn_RefreshBdl.Click;
    dxgrd_1.SetFocus;
  end;
end;

procedure TCountXkCjInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCountXkCjInfo.FormCreate(Sender: TObject);
begin
  sqlList := TStringList.Create;
  RzRadioGroup1.Items.Clear;
  GetYxList;
  Open_Table;
end;

procedure TCountXkCjInfo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sqlList);
end;

procedure TCountXkCjInfo.FormShow(Sender: TObject);
begin
  if RzRadioGroup1.Items.Count>0 then
    RzRadioGroup1.ItemIndex := 0;
end;

procedure TCountXkCjInfo.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      sList.Add('����ѧԺ');
      sList.Add('�������ѧԺ');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TCountXkCjInfo.mi_RefreshBdlClick(Sender: TObject);
begin
  RzRadioGroup1.OnClick(Self);
end;

procedure TCountXkCjInfo.Open_Table;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from ͳ����Ŀ�� where ����='+quotedstr('�ɼ�'));
    RzRadioGroup1.Items.Clear;
    sqlList.Clear;
    while not cds_Temp.Eof do
    begin
      RzRadioGroup1.Items.Add(cds_Temp.Fields[1].AsString);
      //RzRadioGroup1.Items[i].Hint := cds_Temp.Fields[2].AsString;
      sqlList.Add(cds_Temp.Fields[2].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TCountXkCjInfo.RzRadioGroup1Click(Sender: TObject);
var
  i,ii,iTotal,iBaoDao: Integer;
  sqlstr:string;
begin
  i := RzRadioGroup1.ItemIndex;
  if i = -1 then Exit;
  Caption := '��'+cbb_Yx.Text+'��'+RzRadioGroup1.Items[RzRadioGroup1.ItemIndex];

  try
    sqlstr := LowerCase(sqlList.Strings[i]);

    //ii := Pos(' group ',sqlstr);
    //if ii>0 then
    //  sqlstr := Copy(sqlstr,1,ii)+' and �п�Ժϵ='+quotedstr(cbb_Yx.Text)+
    //            Copy(sqlstr,ii,Length(sqlstr));
    sqlstr := sqlstr+' and �п�Ժϵ='+quotedstr(cbb_Yx.Text);

    ClientDataSet1.XMLData := dm.OpenData(sqlstr);
    with dxgrd_1 do
    begin
      for i := 0 to Columns.Count - 1 do
      begin
        Columns[i].Title.TitleButton := True;
        if Columns[i].Width>150 then
          Columns[i].Width := 150
        else
        begin
          if i=0 then
            Columns[i].Width := 120
          else
          begin
            Columns[i].Width := 70;
            Columns[i].Alignment := taCenter;
            Columns[i].Title.Alignment := taCenter;
          end;
        end;
        if Columns[i].FieldName = '������' then
        begin
          Columns[i].Width := 100;
          Columns[i].DisplayFormat := ',0.00%';
          //Columns[i].Footer.ValueType := fvtStaticText;// fvtAvg;
          Columns[i].Footer.FieldName := Columns[i].FieldName;
          Columns[i].Footer.ValueType := fvtAvg;
          Columns[i].Footer.DisplayFormat := 'ƽ����,0.00%';
        end
        else if Pos('����',Columns[i].FieldName)>0 then
        begin
          Columns[i].DisplayFormat := ',0';
          Columns[i].Footer.ValueType := fvtSum;
          Columns[i].Footer.FieldName := Columns[i].FieldName;
        end;
      end;
    end;
  except
    on e:Exception do
      MessageBox(Handle, PChar('SQLͳ������ִ��ʧ�ܣ���������ԣ�ʧ��ԭ�����£���' +
        #13#10 + e.Message), 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
  end;
end;

end.
