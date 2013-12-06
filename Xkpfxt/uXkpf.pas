unit uXkpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, RzBorder, DBCtrls, Mask,
  DBGridEhGrouping, GridsEh, DBGridEh, OleServer, SunVote_TLB, RzPanel, RzStatus;

type
  TXkpf = class(TForm)
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
    btn_4: TBitBtn;
    tmr1: TTimer;
    lbl13: TLabel;
    dbedt_Rch: TDBEdit;
    pnl_cj: TPanel;
    lbl_Rch: TLabel;
    pnl_Bottom: TPanel;
    MultipleAssess: TMultipleAssess;
    Message1: TMessage;
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
    procedure tmr1Timer(Sender: TObject);
    procedure btn_3Click(Sender: TObject);
    procedure btn_4Click(Sender: TObject);
    procedure btn_2Click(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure btn_5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MultipleAssessDataDownload(ASender: TObject; KeyID,
      DownloadStatus: Integer; const DownloadInfo: WideString);
    procedure MultipleAssessKeyStatus(ASender: TObject;
      const BaseTag: WideString; KeyID, CommitOK: Integer;
      const KeyValue: WideString);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    aKsh:string;
    aRch:string;
    aYx,aSf,aKd,aZy:string;
    LabelList:Array of TLabel;
    procedure InitKeySet;
    procedure CreateLabelList;
    procedure InitLabelList;
    procedure DestroyLabelList;
    procedure savecj;
    procedure ShowKmcj;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy:string);
  end;

var
  Xkpf: TXkpf;

implementation
uses uDM, uPwqd;
{$R *.dfm}

procedure TXkpf.btn_1Click(Sender: TObject);
begin
  with TPwqd.Create(nil) do
  begin
    SetParam(ayx,asf,akd,azy);
    if ShowModal=mrOk then
    begin
      btn_1.Enabled := False;
      btn_2.Enabled := True;
      cds_Cj.Close;
    end;
  end;
  InitLabelList;
end;

procedure TXkpf.btn_2Click(Sender: TObject);
var
  ksh,sqlstr,swhere,yx,sf,kd,zy,pw,pfq,km:string;
  cds_km,cds_pw:TClientDataSet;
begin
  cds_km := TClientDataSet.Create(nil);
  cds_pw := TClientDataSet.Create(nil);
  try
    ksh:=InputBox('请输入：','请输入考生信息(准考证号、考生号、身份证号)','');
    if ksh<>'' then
    begin
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
      end;
      aRch := Format('%.4d',[StrToIntDef(aRch,0)+1]);
      dbedt_Rch.Text := aRch;
      lbl_Rch.Caption := '正在对入场号为【'+aRch+'】的考生进行评分：';
      swhere := ' where 承考院系='+quotedstr(ayx)+' and 省份='+quotedstr(aSf)+
                ' and 考点名称='+quotedstr(aKd);
      sqlstr := 'delete from 校考科目现场评分表'+swhere;
      dm.ExecSql(sqlstr);
      cds_km.XMLData := dm.OpenData('select 考试科目 from 校考专业科目表 where 专业='+quotedstr(aZy));
      cds_pw.XMLData := dm.OpenData('select 评委,评分器 from 校考考点评委表 '+swhere+' and 专业='+quotedstr(aZy)+' order by 评分器');
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

{
          cds_Cj.Append;
          cds_Cj.FieldByName('省份').Value := aSf;
          cds_Cj.FieldByName('考点名称').Value := akd;
          cds_Cj.FieldByName('承考院系').Value := ayx;
          cds_Cj.FieldByName('考生号').Value := ksh;
          cds_Cj.FieldByName('进场号').Value := aRch;
          cds_Cj.FieldByName('评委').Value := cds_pw.FieldByName('评委').Value;
          cds_Cj.FieldByName('评分器').Value := cds_pw.FieldByName('评分器').Value;
          cds_Cj.FieldByName('考试科目').Value := cds_km.FieldByName('考试科目').AsString;
          cds_Cj.Post;
}
          cds_km.Next;
        end;
        cds_pw.Next;
      end;
      sqlstr := 'select * from 校考科目现场评分表 '+swhere+' and 考生号='+quotedstr(ksh)+' order by 评分器,评委,考试科目';
      cds_Cj.XMLData := DM.OpenData(sqlstr);
      btn_3.Enabled := True;
      ShowKmcj;
    end;
  finally
    cds_km.Free;
    cds_pw.Free;
  end;
end;

procedure TXkpf.btn_3Click(Sender: TObject);
var
  state:string;
begin
//  Message1.BaseConnection := dm.BaseConnection1.DefaultInterface;
//  Message1.Start('0',Format('请为【%s】考生打分',[dbedt_Rch.Text]));
//  Sleep(3000);

  tmr1.Tag := 0;
  tmr1.Enabled := True;
  btn_2.Enabled := False;
  btn_4.Enabled := True;
  btn_5.Enabled := True;

  MultipleAssess.baseConnection := dm.baseConnection1.DefaultInterface;
  MultipleAssess.Mode := 0;
  MultipleAssess.DisplayFormat := 0;

  MultipleAssess.NumberBegin := 1;
  MultipleAssess.NumberEnd := 2;
  MultipleAssess.RuleBegin := 1;
  MultipleAssess.RuleEnd := 1;

  MultipleAssess.LessMode := 1; //迫选模式
  MultipleAssess.EnterMove := 1;
  MultipleAssess.ColWidthFirst := 18;
  MultipleAssess.ColWidthOther := 8;
  MultipleAssess.StartMode := 1; //清空重新开始模式

  MultipleAssess.SecrecyMode:=0;
  MultipleAssess.ModifyMode:=0;
  MultipleAssess.AvoidMode:=0;
  state := MultipleAssess.Start;
  if state<>'0' then
  begin
    Application.MessageBox('评分器硬件启动失败！', '系统提示', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
  end;

end;

procedure TXkpf.btn_4Click(Sender: TObject);
begin
  tmr1.Enabled := False;
  btn_2.Enabled := False;
  btn_3.Enabled := False;
  btn_4.Enabled := False;
  btn_5.Enabled := True;
end;

procedure TXkpf.btn_5Click(Sender: TObject);
begin
  MultipleAssess.Stop;
  savecj;
  ShowKmcj;
  tmr1.Enabled := False;
  btn_2.Enabled := True;
  btn_3.Enabled := False;
  btn_4.Enabled := False;
  btn_5.Enabled := False;
end;

procedure TXkpf.CreateLabelList;
var
  sqlstr:string;
  iCount:Integer;
begin
  sqlstr := 'select count(*) from 校考考点评委表 where 承考院系='+quotedstr(aYx)+
                                          ' and 省份='+quotedstr(aSf)+
                                          ' and 考点名称='+quotedstr(aKd)+
                                          ' and 专业='+quotedstr(aZy);
  iCount := dm.GetRecordCountBySql(sqlstr);
  if iCount<5 then
    iCount := 5;
  SetLength(LabelList,iCount);
  InitLabelList;
end;

procedure TXkpf.DestroyLabelList;
var
  i: Integer;
begin
  for i := 0 to High(LabelList) do
    FreeAndNil(LabelList[i]);
end;

procedure TXkpf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MultipleAssess.Stop;
  Action := caFree;
end;

procedure TXkpf.FormCreate(Sender: TObject);
begin
  dm.KeypadManage1.ShowKeyInfo(0,1);  //0:所有键盘，1：显示大字体
end;

procedure TXkpf.FormDestroy(Sender: TObject);
begin
  DestroyLabelList;
  InitKeySet;
end;

procedure TXkpf.InitKeySet;
var
  aWhere :string;
begin
  aWhere := ' where 承考院系='+quotedstr(aYx)+
                                          ' and 省份='+quotedstr(aSf)+
                                          ' and 考点名称='+quotedstr(aKd)+
                                          ' and 专业='+quotedstr(aZy);
  dm.ExecSql('update 校考考点评委表 set 评分器=null,是否签到=0 '+aWhere);

end;

procedure TXkpf.InitLabelList;
var
  cds_tmp:TClientDataSet;
  sqlstr,pw:string;
  i:integer;
begin
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select 评分器,评委,是否签到 from 校考考点评委表 where 承考院系='+quotedstr(aYx)+
                                            ' and 省份='+quotedstr(aSf)+
                                            ' and 考点名称='+quotedstr(aKd)+
                                            ' and 专业='+quotedstr(aZy)+' order by 评分器';
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

procedure TXkpf.MultipleAssessDataDownload(ASender: TObject; KeyID,
  DownloadStatus: Integer; const DownloadInfo: WideString);
var
  lDownloadSuccessKeyIDs, lDownloadErrorKeyIDs: string;
Begin
  If (KeyID = 0) And (DownloadStatus = 0) Then
  Begin
    lDownloadSuccessKeyIDs := MultipleAssess.DownloadSuccessKeyIDs;
    lDownloadErrorKeyIDs := MultipleAssess.DownloadErrorKeyIDs;
  End;
  //ShowDownInfo('MultipleAssess', KeyID, DownloadStatus, DownloadInfo,
  //  lDownloadSuccessKeyIDs, lDownloadErrorKeyIDs);
end;

procedure TXkpf.MultipleAssessKeyStatus(ASender: TObject;
  const BaseTag: WideString; KeyID, CommitOK: Integer;
  const KeyValue: WideString);
var
  s,cj1,cj2:string;
  i,ii:Integer;
  time:TDateTime;
begin
  //KeyValue //1_1=89,2_1=56.5
  s := KeyValue;
  i := Pos('1_1=',s);
  ii := Pos(',',s);
  if i>0 then
  begin
    if ii=0 then ii:=10;
      cj1 := Copy(s,i+4,ii-5);
  end;

  i := Pos('2_1=',s);
  ii := Pos(',',s);
  if i>0 then
  begin
    if ii=0 then ii:=10;
      cj2 := Copy(s,i+4,ii-5);
  end;
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
    if CommitOK=1 then
    begin
      time := now;
      cds_Cj.Edit;
      cds_Cj.FieldByName('提交时间').AsDateTime := time;
      cds_Cj.Post;
      cds_Cj.Prior;
      cds_Cj.Edit;
      cds_Cj.FieldByName('提交时间').AsDateTime := time;
      cds_Cj.Post;
    end;
  end;
end;

procedure TXkpf.savecj;
begin
  if IsModified(cds_Cj) then
  begin
    if dm.UpdateData('id','select top 0 * from 校考科目现场评分表',cds_Cj.Delta) then
    cds_Cj.MergeChangeLog;
  end;
end;

procedure TXkpf.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  InitKeySet;
  CreateLabelList;
end;

procedure TXkpf.ShowKmcj;
var
  sqlstr,km,cj :string;
  cds_tmp:TClientDataSet;
begin
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'SELECT 考试科目,avg(成绩) as 成绩 FROM 校考科目现场评分表'+
              ' where 进场号='+quotedstr(aRch)+' group by [考试科目]';
    cds_tmp.XMLData := dm.OpenData(sqlstr);
    lbl_Cj.Caption := '';
    while not cds_tmp.eof do
    begin
      km := cds_tmp.Fields[0].AsString;
      cj := Format('%.3f',[cds_tmp.Fields[1].AsFloat]);
      lbl_Cj.Caption := lbl_Cj.Caption+km+#13+cj+#13+#13;
      cds_tmp.Next;
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TXkpf.tmr1Timer(Sender: TObject);
var
  lt:integer;
begin
  led_Time.Tag := led_Time.Tag+1;
  lt := led_Time.Tag;
  led_Time.Caption := Format('%-.2d:%-.2d',[lt div 60,lt mod 60]);
end;

end.
