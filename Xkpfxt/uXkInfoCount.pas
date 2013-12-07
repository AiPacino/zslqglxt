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
  //DM.ExecSql('ALTER TABLE dbo.校考单科成绩表 ADD 成绩1_1 float, 成绩1_2 float, 成绩2_1 float, 成绩2_2 float, 成绩1比例 int, 成绩2比例 int, 成绩1是否提交 bit,成绩2是否提交 int');
  dm.ExecSql('ALTER VIEW [dbo].[View_校考单科成绩表] as '+
' SELECT     dbo.校考单科成绩表.Id, dbo.校考单科成绩表.承考院系, dbo.校考考生信息表.考生号, dbo.校考考生信息表.准考证号, dbo.校考考生信息表.身份证号,'+
'                      dbo.校考考生信息表.姓名, dbo.校考考生信息表.性别, dbo.校考考生信息表.省份, dbo.校考单科成绩表.考试科目, dbo.校考单科成绩表.成绩1,'+
'                      dbo.校考单科成绩表.操作员1, dbo.校考单科成绩表.成绩2, dbo.校考单科成绩表.操作员2, dbo.校考单科成绩表.最终成绩, dbo.校考单科成绩表.审核人,'+
'                      dbo.校考单科成绩表.比例, dbo.校考考生信息表.联系电话, dbo.校考考生信息表.邮政编码, dbo.校考考生信息表.通信地址,'+
'                      dbo.校考单科成绩表.成绩1_1, dbo.校考单科成绩表.成绩1_2,'+
'                      dbo.校考单科成绩表.成绩2_1, dbo.校考单科成绩表.成绩2_2, dbo.校考单科成绩表.成绩1_比例, dbo.校考单科成绩表.成绩2_比例,'+
'                      dbo.校考单科成绩表.成绩1是否提交, dbo.校考单科成绩表.成绩2是否提交'+
' FROM         dbo.校考单科成绩表 INNER JOIN '+
'                      dbo.校考考生信息表 ON dbo.校考单科成绩表.考生号 = dbo.校考考生信息表.考生号');
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
  PrintDBGridEH(dxgrd_1,Self,cds_Master.FieldByName('说明').AsString);
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
    Caption := '【'+gb_Czy_Dept+'】'+cds_Master.FieldByName('说明').AsString
  else
    Caption := cds_Master.FieldByName('说明').AsString;
  try
    sqlstr := cds_Master.FieldByName('sqlText').AsString;// LowerCase(sqlList.Strings[i]);
    if gb_Czy_Level='2' then
    begin
      ii := Pos(' group ',sqlstr);
      if ii>0 then
        sqlstr := Copy(sqlstr,1,ii)+' and 承考院系='+quotedstr(gb_Czy_Dept)+
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
        if Columns[i].FieldName = '报到率' then
        begin
          Columns[i].Width := 100;
          Columns[i].DisplayFormat := ',0.00%';
          //Columns[i].Footer.ValueType := fvtStaticText;// fvtAvg;
          Columns[i].Footer.FieldName := Columns[i].FieldName;
          Columns[i].Footer.ValueType := fvtAvg;
          Columns[i].Footer.DisplayFormat := '平均：,0.00%';
        end
        else if Pos('人数',Columns[i].FieldName)>0 then
        begin
          Columns[i].DisplayFormat := ',0';
          Columns[i].Footer.ValueType := fvtSum;
          Columns[i].Footer.FieldName := Columns[i].FieldName;
        end;
      end;
    end;
  except
    on e:Exception do
      MessageBox(Handle, PChar('SQL统计命令执行失败！请检查后重试！失败原因如下：　' +
        #13#10 + e.Message), '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
  end;
end;

procedure TXkInfoCount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkInfoCount.FormCreate(Sender: TObject);
begin
  if gb_Czy_Level='2' then
    Caption := '【'+gb_Czy_Dept+'】'+'校考专业报考情况统计';
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
  cds_Master.XMLData := dm.OpenData('select * from 统计项目表 where 模块='+quotedstr(gb_System_Mode)+' and 类别='+quotedstr('统计'));
end;

end.
