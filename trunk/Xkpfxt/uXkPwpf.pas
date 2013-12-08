unit uXkPwpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IniFiles,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, RzBorder, DBCtrls, Mask,
  DBGridEhGrouping, GridsEh, DBGridEh, OleServer, SunVote_TLB, RzPanel, RzStatus;

type
  TXkPwpf = class(TForm)
    pnl_right: TPanel;
    pnl1: TPanel;
    led_Time: TRzLEDDisplay;
    lbl1: TLabel;
    pnl2: TPanel;
    bvl2: TBevel;
    pnl3: TPanel;
    btn_1: TBitBtn;
    btn_2: TBitBtn;
    cds_Cj: TClientDataSet;
    ds_Cj: TDataSource;
    cds_stu: TClientDataSet;
    ds_stu: TDataSource;
    cds_stuId: TAutoIncField;
    cds_stuStringField: TStringField;
    cds_stuStringField2: TStringField;
    cds_stuStringField3: TStringField;
    cds_stuStringField4: TStringField;
    cds_stuStringField5: TStringField;
    cds_stuStringField6: TStringField;
    cds_stuStringField7: TStringField;
    cds_stuStringField8: TStringField;
    cds_stuStringField9: TStringField;
    cds_stuStringField10: TStringField;
    cds_stuDateTimeField: TDateTimeField;
    cds_stuDateTimeField2: TDateTimeField;
    cds_stuFloatField: TFloatField;
    cds_stuStringField11: TStringField;
    cds_stuStringField12: TStringField;
    cds_stuStringField13: TStringField;
    cds_stuStringField14: TStringField;
    grp1: TGroupBox;
    lbl2: TLabel;
    dbedt1: TDBEdit;
    lbl3: TLabel;
    dbedt2: TDBEdit;
    lbl4: TLabel;
    dbedt3: TDBEdit;
    lbl5: TLabel;
    dbedt4: TDBEdit;
    lbl6: TLabel;
    dbedt5: TDBEdit;
    lbl7: TLabel;
    dbedt6: TDBEdit;
    lbl8: TLabel;
    dbedt7: TDBEdit;
    lbl9: TLabel;
    dbedt8: TDBEdit;
    lbl10: TLabel;
    dbedt9: TDBEdit;
    lbl11: TLabel;
    lbl12: TLabel;
    dbedt11: TDBEdit;
    dbmmo1: TDBMemo;
    btn_3: TBitBtn;
    tmr1: TTimer;
    lbl13: TLabel;
    dbedt_Rch: TDBEdit;
    pnl_cj: TPanel;
    lbl_Rch: TLabel;
    pnl_Bottom: TPanel;
    btn_5: TBitBtn;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    pnl4: TPanel;
    RzStatusPane2: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    pnl6: TPanel;
    Panel1: TPanel;
    DBGridEh2: TDBGridEh;
    Panel2: TPanel;
    lbl14: TLabel;
    lbl_Cj: TLabel;
    btn1: TBitBtn;
    procedure tmr1Timer(Sender: TObject);
    procedure btn_3Click(Sender: TObject);
    procedure btn_2Click(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure btn_5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
    aKsh:string;
    aRch:string;
    aYx,aSf,aKd,aZy,sqlWhere:string;
    LabelList:Array of TLabel;
    procedure InitKeySet;
    procedure CreateLabelList;
    procedure InitLabelList;
    procedure InitDownLoadKeyTable;
    function  DownloadKeyTable:Boolean;
    procedure DestroyLabelList;
    function  OpenStuTable:string;
    procedure OpenCjTable(const ksh:string);
    function  GetRch:string;
    procedure DeleteKscj(const ksh:string);
    procedure savecj;
    procedure ShowKmcj;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy:string);
    procedure UpdateKeyCjTable(const KeyId:Integer;const cj1,cj2:string;const IsPosted:Boolean);
  end;

var
  XkPwpf: TXkPwpf;

implementation
uses uDM, uXkPwQd,PublicVariable;
{$R *.dfm}

procedure TXkPwpf.btn_1Click(Sender: TObject);
//var
//  keyids,errorkeyids:string;
begin
  //keyids := '3,4';
  //dm.DownLoadKeyData(KeyIds,MsgItemInfo,ErrorKeyIds);
  //dm.DownLoadKeyData(KeyIds,MsgMultipleAssess,ErrorKeyIds);
  //Exit;

  with TXkPwqd.Create(nil) do
  begin
    SetParam(ayx,asf,akd,azy);
    if ShowModal=mrOk then
    begin
      if DownloadKeyTable then
      begin
        btn_1.Enabled := False;
        btn_2.Enabled := True;
        cds_Cj.Close;
      end;
    end;
  end;
  InitLabelList;

end;

procedure TXkPwpf.btn_2Click(Sender: TObject);
var
  ksh,sqlstr,swhere,yx,sf,kd,zy,pw,pfq,km:string;
  cds_km,cds_pw:TClientDataSet;
begin
  cds_km := TClientDataSet.Create(nil);
  cds_pw := TClientDataSet.Create(nil);
  try
    ksh := OpenStuTable;
    if ksh='' then Exit; //考生不存在
    aKsh := ksh;
    DeleteKscj(ksh);

    aRch := GetRch;
    dbedt_Rch.Text := aRch;
    lbl_Rch.Caption := '正在对入场号为【'+aRch+'】的考生进行评分：';

    sqlstr := 'select 考试科目 from 校考专业科目表 where 承考院系='+quotedstr(aYx)+
                                  ' and 专业='+quotedstr(aZy)+' order by 考试科目';
    cds_km.XMLData := dm.OpenData(sqlstr);
    sqlstr := 'select 评委,评分器 from 校考考点评委表 '+sqlWhere+
                                  ' and 专业='+quotedstr(aZy)+' order by 评分器';
    cds_pw.XMLData := dm.OpenData(sqlstr);
    while not cds_pw.eof do
    begin
      cds_km.First;
      while not cds_km.Eof do
      begin
        pw := cds_pw.FieldByName('评委').AsString;
        pfq := cds_pw.FieldByName('评分器').AsString;
        km := cds_km.FieldByName('考试科目').AsString;
        sqlstr := 'Insert into 校考科目现场评分表 (省份,考点名称,承考院系,考生号,进场号,评委,评分器,考试科目) '+
                                          ' Values('+quotedstr(aSf)+','+quotedstr(aKd)+','+quotedstr(aYx)+','+
                                          QuotedStr(ksh)+','+quotedstr(aRch)+','+quotedstr(pw)+','+quotedstr(pfq)+','+
                                          QuotedStr(km)+')';
        dm.ExecSql(sqlstr);

        cds_km.Next;
      end;
      cds_pw.Next;
    end;
    OpenCjTable(ksh);
    btn_3.Enabled := True;
    ShowKmcj;
  finally
    cds_km.Free;
    cds_pw.Free;
  end;
end;

procedure TXkPwpf.btn_3Click(Sender: TObject);
var
  state:string;
begin
  state := dm.MultipleAssess.Start;
  if state<>'0' then
  begin
    Application.MessageBox('评分器硬件启动失败！', '系统提示', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
  end else
  begin
    tmr1.Tag := 0;
    tmr1.Enabled := True;
    btn_2.Enabled := False;
    btn_5.Enabled := True;
    Speak('【'+aRch+'】号考生，请入场！');
  end;

end;

procedure TXkPwpf.btn_5Click(Sender: TObject);
begin
  dm.MultipleAssess.Stop;
  savecj;
  ShowKmcj;
  tmr1.Enabled := False;
  btn_2.Enabled := True;
  btn_3.Enabled := False;
  btn_5.Enabled := False;
  Speak('【'+aRch+'】号考生，请退场！');
end;

procedure TXkPwpf.CreateLabelList;
var
  sqlstr:string;
  iCount:Integer;
begin
  sqlstr := 'select count(*) from 校考考点评委表 '+sqlWhere;
  iCount := dm.GetRecordCountBySql(sqlstr);
  if iCount<5 then
    iCount := 5;
  SetLength(LabelList,iCount);
  InitLabelList;
end;

procedure TXkPwpf.DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if Column.FieldName = '成绩' then
  begin
    if cds_Cj.FieldByName('提交时间').IsNull then
      AFont.Color := clBlue
    else
      AFont.Color := clGray;
  end;

end;

procedure TXkPwpf.DeleteKscj(const ksh: string);
var
  sqlstr,sWhere :string;
begin
  swhere := ' where 承考院系='+quotedstr(ayx)+' and 省份='+quotedstr(aSf)+
            ' and 考点名称='+quotedstr(aKd);
  sqlstr := 'delete from 校考科目现场评分表 '+swhere+' and 考生号='+quotedstr(ksh);
  dm.ExecSql(sqlstr);
end;

procedure TXkPwpf.DestroyLabelList;
var
  i: Integer;
begin
  for i := 0 to High(LabelList) do
    FreeAndNil(LabelList[i]);
end;

function TXkPwpf.DownloadKeyTable: Boolean;
var
  cds_tmp:TClientDataSet;
  KeyIds,sqlstr,pw,ErrorKeyIds:string;
  i:integer;
begin
  InitDownLoadKeyTable;//初始化评分项目配置表
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select 评分器,评委,是否签到 from 校考考点评委表 '+sqlWhere+' and 是否签到=1'+' order by 评分器';
    cds_tmp.XMLData := dm.OpenData(sqlstr);
    while not cds_tmp.Eof do
    begin
      KeyIds := KeyIds+cds_tmp.FieldByName('评分器').AsString+',';
      cds_tmp.Next;
    end;
    //keyids := '3,4';
    if KeyIds='' then Exit;
    if KeyIds[Length(KeyIds)]=',' then
      KeyIds := Copy(KeyIds,1,Length(KeyIds)-1);
    Result := dm.DownLoadKeyData(KeyIds,MsgItemInfo,ErrorKeyIds); //下载评分指标，
    Result := dm.DownLoadKeyData(KeyIds,MsgMultipleAssess,ErrorKeyIds); // 综合测评规则，即我们的考试科目
                                              
    if not Result then
    begin
      Application.MessageBox(PChar(ErrorKeyIds+'号评分器评分项目和评分规则下载失败！'),
        '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TXkPwpf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.MultipleAssess.Stop;
  Action := caFree;
end;

procedure TXkPwpf.FormCreate(Sender: TObject);
begin
  dm.KeypadManage1.ShowKeyInfo(0,1);  //0:所有键盘，1：显示大字体
end;

procedure TXkPwpf.FormDestroy(Sender: TObject);
begin
  DestroyLabelList;
  InitKeySet;
end;

function TXkPwpf.GetRch: string;
var
  s,sqlstr,sWhere :string;
  cds_temp:TClientDataSet;
begin
  cds_temp := TClientDataSet.Create(nil);
  swhere := ' where 承考院系='+quotedstr(ayx)+' and 省份='+quotedstr(aSf)+
            ' and 考点名称='+quotedstr(aKd);
  sqlstr := 'select max(进场号) from 校考科目现场评分表 '+swhere;
  cds_temp.XMLData := DM.OpenData(sqlstr);
  s := cds_temp.Fields[0].AsString;
  Result := Format('%.3d',[StrToIntDef(s,0)+1]);
end;

procedure TXkPwpf.InitDownLoadKeyTable;
var
  sqlstr,fn,FileName:string;
  cds_km:TClientDataSet;
  myini:TInifile;
begin
  //FileName := 'MultipleAssessItem.ini';
  FileName := 'MultipleAssessRule.ini';
  fn := ExtractFilePath(ParamStr(0))+'DownloadData\'+FileName;
  cds_km := TClientDataSet.Create(nil);
  myini := TIniFile.Create(fn);
  try
    sqlstr := 'select 考试科目 from 校考专业科目表 where 承考院系='+quotedstr(aYx)+
                                  ' and 专业='+quotedstr(aZy)+' order by 考试科目';
    cds_km.XMLData := dm.OpenData(sqlstr);
    
    myini.WriteInteger('Info','ItemNum',cds_km.RecordCount);
    while not cds_km.Eof do
    begin
      myini.WriteString('Item'+IntTostr(cds_km.RecNo),'Text',cds_km.Fields[0].AsString);
      cds_km.Next;
    end;
  finally
    cds_km.Free;
    myini.Free;
  end;

end;

procedure TXkPwpf.InitKeySet;
begin
  dm.ExecSql('update 校考考点评委表 set 评分器=null,是否签到=0 '+sqlWhere);
end;

procedure TXkPwpf.InitLabelList;
var
  cds_tmp:TClientDataSet;
  sqlstr,pw:string;
  i:integer;
begin
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select 评分器,评委,是否签到 from 校考考点评委表 '+sqlWhere+' order by 评分器';
    cds_tmp.XMLData := dm.OpenData(sqlstr);

    for i:=0 to High(LabelList) do
    begin
      LabelList[i] := TLabel.Create(nil);
      LabelList[i].Parent := self.pnl_Bottom;
      LabelList[i].AutoSize := False;
      LabelList[i].Font.Color := clWhite;
      LabelList[i].Width := 64;
      LabelList[i].Height := 50;
      LabelList[i].Top := 8;
      LabelList[i].Left := 10+i*(LabelList[i].Width+5);
      LabelList[i].Transparent := False;
      LabelList[i].Alignment := taCenter;
      LabelList[i].Caption := Format('%.4d',[i+1])+#10+'未签到';
      LabelList[i].Color := clMaroon;

      if cds_tmp.Locate('评分器',i+1,[]) then
      begin
        if cds_tmp.FieldByName('是否签到').AsBoolean then
        begin
          LabelList[i].Color := clBlue;
          pw := cds_tmp.FieldByName('评委').AsString;
          LabelList[i].Caption := Format('%.4d',[i+1])+#10+pw;
        end;
      end;
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TXkPwpf.OpenCjTable(const ksh:string);
var
  sqlstr,sWhere :string;
begin
  swhere := ' where 承考院系='+quotedstr(ayx)+' and 省份='+quotedstr(aSf)+
            ' and 考点名称='+quotedstr(aKd);
  sqlstr := 'select * from 校考科目现场评分表 '+swhere+' and 考生号='+quotedstr(ksh)+' order by 评分器,评委,考试科目';
  cds_Cj.XMLData := DM.OpenData(sqlstr);
end;

function TXkPwpf.OpenStuTable:string;
var
  ksh,sqlstr:string;
begin
  ksh:=InputBox('请输入：','请输入考生信息(准考证号、考生号、身份证号)','');
  if ksh='' then Exit;

  sqlstr := 'select * from view_校考考生报考专业表 where 考点名称='+quotedstr(aKd)+
                                             ' and 专业='+quotedstr(aZy)+
                                             ' and (考生号='+quotedstr(ksh)+
                                             ' or 身份证号='+quotedstr(ksh)+
                                             ' or 准考证号='+quotedstr(ksh)+')';
  cds_stu.XMLData := dm.OpenData(sqlstr);
  if cds_stu.RecordCount=0 then
  begin
    Application.MessageBox('考生信息不存在，请检查后重新输入！  ', '系统提示',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end else
    Result := cds_stu.FieldByName('考生号').AsString;
end;

procedure TXkPwpf.savecj;
begin
  if IsModified(cds_Cj) then
  begin
    if dm.UpdateData('id','select top 0 * from 校考科目现场评分表',cds_Cj.Delta) then
    cds_Cj.MergeChangeLog;
  end;
end;

procedure TXkPwpf.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  sqlWhere := ' where 承考院系='+quotedstr(aYx)+
            ' and 省份='+quotedstr(aSf)+
            ' and 考点名称='+quotedstr(aKd)+
            ' and 专业='+quotedstr(aZy);
  InitKeySet;
  CreateLabelList;
end;

procedure TXkPwpf.ShowKmcj;
var
  sqlstr,km,cj :string;
  cds_tmp:TClientDataSet;
begin
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'SELECT 考试科目,avg(成绩) as 成绩 FROM 校考科目现场评分表'+
              ' where 进场号='+quotedstr(aRch)+' and 省份='+quotedstr(aSf)+
              ' and 考点名称='+quotedstr(aKd)+' group by 考试科目';
    cds_tmp.XMLData := dm.OpenData(sqlstr);
    lbl_Cj.Caption := '';
    while not cds_tmp.eof do
    begin
      km := cds_tmp.Fields[0].AsString;
      cj := Format('%.2f',[cds_tmp.Fields[1].AsFloat]);
      lbl_Cj.Caption := lbl_Cj.Caption+km+#13+cj+#13+#13;
      cds_tmp.Next;
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TXkPwpf.tmr1Timer(Sender: TObject);
var
  lt:integer;
begin
  led_Time.Tag := led_Time.Tag+1;
  lt := led_Time.Tag;
  led_Time.Caption := Format('%-.2d:%-.2d',[lt div 60,lt mod 60]);
end;

procedure TXkPwpf.UpdateKeyCjTable(const KeyId: Integer; const cj1, cj2: string;
  const IsPosted: Boolean);
var
  postTime:TDateTime;
  sqlstr,cjstr:string;
begin
  //cds_Cj.DisableControls;
  try
    if cj1='' then
      cjstr := 'null'
    else
      cjstr := cj1;
    sqlstr := 'update 校考现场评分表 set 成绩='+cjstr+sqlWhere+' and 评分器='+IntTostr(KeyId);

    DM.ExecSql(sqlstr);
    if cj2='' then
      cjstr := 'null'
    else
      cjstr := cj2;
    sqlstr := 'update 校考现场评分表 set 成绩='+cjstr+sqlWhere+' and 评分器='+IntTostr(KeyId);
    DM.ExecSql(sqlstr);
    OpenCjTable(aKsh);
{
    if cds_Cj.Locate('评分器',KeyID,[]) then
    begin
      if cj1<>'' then
      begin
        cds_Cj.Edit;
        cds_Cj.FieldByName('成绩').Value := StrToFloatDef(cj1,0.00);
        cds_Cj.Post;
      end;
      cds_Cj.Next;
      if cj2<>'' then
      begin
        cds_Cj.Edit;
        cds_Cj.FieldByName('成绩').Value := StrToFloatDef(cj2,0.00);
        cds_Cj.Post;
      end;
      if IsPosted then
      begin
        postTime := now;
        cds_Cj.Edit;
        cds_Cj.FieldByName('提交时间').AsDateTime := postTime;
        cds_Cj.Post;
        cds_Cj.Prior;
        cds_Cj.Edit;
        cds_Cj.FieldByName('提交时间').AsDateTime := postTime;
        cds_Cj.Post;
      end;
    end;
}
  finally
    //cds_Cj.EnableControls;;
  end;

end;

end.
