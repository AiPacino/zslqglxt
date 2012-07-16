unit uChangeZy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, DBCtrls, StdCtrls, DB, ADODB, ExtCtrls, ComCtrls, Mask,
  DBCtrlsEh, DBClient;

type
  TChangeZy = class(TForm)
    Panel1: TPanel;
    cbb_Field: TDBComboBoxEh;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    pgc1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    pgc2: TPageControl;
    ts1: TTabSheet;
    bvl1: TBevel;
    DataSource1: TDataSource;
    lbl1: TLabel;
    edt_Xm: TDBEdit;
    lbl2: TLabel;
    edt_Ksh: TDBEdit;
    lbl3: TLabel;
    edt_Sf: TDBEdit;
    Label1: TLabel;
    edt_OldZy: TDBEdit;
    Label2: TLabel;
    edt_OldYx: TDBEdit;
    lbl4: TLabel;
    edt_OldXq: TDBEdit;
    pnl1: TPanel;
    btn1: TSpeedButton;
    lbl5: TLabel;
    edt_NewZy: TDBComboBoxEh;
    lbl6: TLabel;
    edt_NewYx: TEdit;
    lbl7: TLabel;
    edt_NewXq: TEdit;
    lbl8: TLabel;
    edt_Kl: TDBEdit;
    btn_OK: TBitBtn;
    btn_Close: TBitBtn;
    btn_History: TBitBtn;
    lbl9: TLabel;
    edt_OldXlcc: TDBEdit;
    lbl10: TLabel;
    dbedt10: TDBEdit;
    lbl11: TLabel;
    ClientDataSet1: TClientDataSet;
    cds_Temp: TClientDataSet;
    lbl12: TLabel;
    btn_Design: TBitBtn;
    Image1: TImage;
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_NewZyChange(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValueChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_DesignClick(Sender: TObject);
  private
    { Private declarations }
    procedure PrintZyConfirmRep(const iType:Integer=0);
  public
    { Public declarations }
  end;

var
  ChangeZy: TChangeZy;

implementation
uses uDM;
{$R *.dfm}

procedure TChangeZy.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TChangeZy.btn_DesignClick(Sender: TObject);
begin
  PrintZyConfirmRep(2);
end;

procedure TChangeZy.btn_OKClick(Sender: TObject);
var
  sksh,ksh,sqlstr:string;
  old_zy,old_yx,old_xlcc,new_zy,new_yx,new_xlcc,new_xq,sError:string;
begin
  ksh := edt_Ksh.Text;
  old_zy := edt_OldZy.Text;
  old_yx := edt_OldYx.Text;
  old_xlcc := edt_OldXlcc.Text;
  new_zy := edt_NewZy.Text;
  new_yx := edt_NewYx.Text;
  new_xlcc := old_xlcc;
  new_xq := edt_NewXq.Text;

  if MessageBox(Handle, PAnsiChar('真的要为【'+edt_xm.Text+'】更换新的专业吗？　'), '系统提示', MB_YESNO 
    + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  //sqlstr := 'Insert Into 更换专业记录表 (考生号,原专业,原院系,新专业,新院系,操作员,操作时间) '+
  //          'values('+ksh+','+old_zy+','+old_yx+','+new_zy+','+new_yx+','+quotedstr(gb_Czy_Id)+',date())';
  //UpdateStuZy(const sKsh,xlcc,oldzy,oldyx,newzy,newyx,newxq,czyId:string;out sError:string):Boolean; stdcall;
  if not vobj.UpdateStuZy(ksh,old_xlcc,old_zy,old_yx,new_zy,new_yx,new_xq,gb_Czy_ID,sError) then
  //if not vobj.ExecSql(sqlstr,sError) then
  begin
    MessageBox(Handle, PAnsiChar('更换专业失败！请重试！原因为：　' + #13#10 + sError),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;
  MessageBox(Handle, '更换专业成功！请以新专业的身份进行报到！　',
    '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  if Application.MessageBox('要现在打印更换专业审核表吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION) = IDYES then
  begin
    sqlstr := 'select * from view_更换专业记录表 where 考生号='+quotedstr(edt_Ksh.Text)+' and 原录取专业='+quotedstr(edt_OldZy.Text);
    dm.PrintReport('更换专业审核表.fr3',dm.OpenData(sqlstr),1);
  end;

  //PrintZyConfirmRep(1);
  btn_OK.Enabled := False;
  Close;
end;

procedure TChangeZy.btn_SearchClick(Sender: TObject);
var
  sState,sqlstr,xlcc,zykl:string;
  sField,sValue:string;
begin
  sField := cbb_Field.KeyItems[cbb_Field.ItemIndex];
  sValue := edt_Value.Text;
  sqlstr := 'select * from 录取信息表 where '+sField+'='+quotedstr(sValue);
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
  if ClientDataSet1.RecordCount=0 then
  begin
    MessageBox(Handle, PAnsiChar(cbb_Field.Text+'为【'+sValue+'】的新生信息不存在！　'+#13+'请核对后重新查询！　'), '系统提示',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_Value.SetFocus;
    Exit;
  end;
  xlcc := ClientDataSet1.FieldByName('学历层次').AsString;
  zykl := ClientDataSet1.FieldByName('类别').AsString;
  edt_NewZy.Items.Clear;
  dm.SetZyComboBox(xlcc,zykl,edt_NewZy);
  edt_NewZy.Text := '';
  edt_NewZy.SetFocus;
  btn_OK.Enabled := False;
end;

procedure TChangeZy.edt_NewZyChange(Sender: TObject);
var
  sqlstr,xlcc,zy:string;
begin
  if edt_NewZy.Text='' then
  begin
    btn_OK.Enabled := False;
    edt_NewYx.Text := '';
    edt_NewXq.Text := '';
    Exit;
  end;

  xlcc := ClientDataSet1.FieldByName('学历层次').AsString;
  zy := edt_NewZy.Text;
  sqlstr := 'select 院系,校区 from view_院系专业表 where 专业='+quotedstr(zy)+' and 学历层次='+quotedstr(xlcc);
  cds_Temp.XMLData := dm.OpenData(sqlstr);
  edt_NewYx.Text := cds_Temp.Fields[0].AsString;
  edt_NewXq.Text := cds_Temp.Fields[1].AsString;
  cds_Temp.Close;
  btn_OK.Enabled := (edt_NewZy.Text<>'') and (edt_NewZy.Text<>edt_OldZy.Text);
end;


procedure TChangeZy.edt_ValueChange(Sender: TObject);
begin
  lbl12.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TChangeZy.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TChangeZy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClientDataSet1.Close;
  Action := caFree;
end;

procedure TChangeZy.FormCreate(Sender: TObject);
begin
  btn_Design.Enabled := gb_Czy_Level='-1';
end;

procedure TChangeZy.PrintZyConfirmRep(const iType:Integer=0);
var
  fn,sqlstr:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'Rep\更换专业审核表.fr3';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('打印更换专业审核表失败！报表文件未找到！　' + #13#10 +
      '文件为：'+fn), '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 +
      MB_TOPMOST);
      Exit;
  end;
  sqlstr := 'select * from view_更换专业记录表 where 考生号='+quotedstr(edt_Ksh.Text)+' and 原专业='+quotedstr(edt_OldZy.Text);
  dm.cds_Master.XMLData := DM.OpenData(sqlstr);
  with dm.frxReport1 do
  begin
    LoadFromFile(fn);
    case iType of
      0:
      begin
        PrintOptions.ShowDialog := False;
        PrepareReport;
        Print;
      end;
      1:
      begin
        ShowReport;
      end;
      2:
      begin
        DesignReport;
      end;
    end;
  end;
end;

end.

