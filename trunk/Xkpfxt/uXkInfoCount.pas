unit uXkInfoCount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls, DB,
  DBClient, GridsEh, DBGridEh, RzPanel, RzRadGrp, Menus, DBGridEhImpExp,
  DBGridEhGrouping;

type
  TXkInfoCount = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Excel: TBitBtn;
    btn_Refresh: TBitBtn;
    GroupBox1: TGroupBox;
    dxgrd_1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    mniLocate: TMenuItem;
    N1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    mniDataExport: TMenuItem;
    btn_RefreshBdl: TBitBtn;
    mi_RefreshBdl: TMenuItem;
    btn_Print: TBitBtn;
    BitBtn1: TBitBtn;
    grp1: TGroupBox;
    DBGridEh1: TDBGridEh;
    cds_Master: TClientDataSet;
    ds_Master: TDataSource;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);
    procedure mi_RefreshBdlClick(Sender: TObject);
    procedure btn_RefreshBdlClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ds_MasterDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    sqlList:TStrings;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  XkInfoCount: TXkInfoCount;

implementation
uses uDM;
{$R *.dfm}

procedure TXkInfoCount.BitBtn1Click(Sender: TObject);
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

procedure TXkInfoCount.btn_ExcelClick(Sender: TObject);
begin
  dm.ExportDBEditEH(dxgrd_1);
end;

procedure TXkInfoCount.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkInfoCount.btn_PrintClick(Sender: TObject);
begin
  PrintDBGridEH(dxgrd_1,Self,cds_Master.FieldByName('˵��').AsString);
end;

procedure TXkInfoCount.btn_RefreshBdlClick(Sender: TObject);
begin
  mi_RefreshBdl.Click;
end;

procedure TXkInfoCount.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoCount.ds_MasterDataChange(Sender: TObject; Field: TField);
var
  i,ii,iTotal,iBaoDao: Integer;
  sqlstr:string;
begin
  if gb_Czy_Level='2' then
    Caption := '��'+gb_Czy_Dept+'��'+cds_Master.FieldByName('˵��').AsString
  else
    Caption := cds_Master.FieldByName('˵��').AsString;
  try
    sqlstr := cds_Master.FieldByName('sqlText').AsString;// LowerCase(sqlList.Strings[i]);
    if gb_Czy_Level='2' then
    begin
      ii := Pos(' group ',sqlstr);
      if ii>0 then
        sqlstr := Copy(sqlstr,1,ii)+' and �п�Ժϵ='+quotedstr(gb_Czy_Dept)+
                  Copy(sqlstr,ii,Length(sqlstr));
    end;
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

procedure TXkInfoCount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkInfoCount.FormCreate(Sender: TObject);
begin
  if gb_Czy_Level='2' then
    Caption := '��'+gb_Czy_Dept+'��'+'У��רҵ�������ͳ��';
  sqlList := TStringList.Create;
  Open_Table;
end;

procedure TXkInfoCount.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sqlList);
end;

procedure TXkInfoCount.mi_RefreshBdlClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoCount.Open_Table;
begin
  cds_Master.XMLData := dm.OpenData('select * from ͳ����Ŀ�� where ģ��='+quotedstr(gb_System_Mode)+' and ���='+quotedstr('ͳ��'));
end;

end.
