unit uXkPwQd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, DBClient, GridsEh, DBGridEh, StdCtrls,
  OleServer, SunVote_TLB;

type
  TXkPwqd = class(TForm)
    DBGridEh1: TDBGridEh;
    cds_pw: TClientDataSet;
    ds_pw: TDataSource;
    btn_End: TButton;
    btn_Start: TButton;
    chk1: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
  private
    { Private declarations }
    //SignIn1:TSignIn;
    sqlWhere,aYx,aSf,aKd,aZy:string;
    function  GetPwByKeyCode(const KeyCode:string):string;
    procedure SetPwByKeyCode(const pw:string;const KeyId:integer);
    procedure CheckKeyAuthorize;
    procedure StartSign_xxx;
    procedure EndSign_xxx;
    function  AllSigned_xxx:Boolean;
    procedure InitPWSignCodeList;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy:string);
    procedure UpdatePwQdTable(const pw:string;const KeyId:integer);
    procedure Open_Table;
  end;

var
  XkPwqd: TXkPwqd;

implementation
uses uDM;
{$R *.dfm}

function TXkPwqd.AllSigned_xxx: Boolean;
begin
  cds_pw.First;
  while not cds_pw.Eof do
  begin
    if not cds_pw.FieldByName('是否签到').AsBoolean then
    begin
      Result := False;
      Exit;
    end;
    cds_pw.Next;
  end;
  Result := True;
end;

procedure TXkPwqd.btn_EndClick(Sender: TObject);
begin
  if (not chk1.Checked) and (not AllSigned_xxx) then
  begin
    Application.MessageBox('在不允许评委缺额的情况下，还有评委没有签到，' + 
      #13#10 + '不能结束签到！', '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end else
  begin
    btn_start.Enabled := True;
    btn_End.Enabled := False;
    EndSign_xxx;
    Close;
    Self.ModalResult := mrOk;
  end;
end;

procedure TXkPwqd.btn_StartClick(Sender: TObject);
begin
  btn_start.Enabled := False;
  btn_End.Enabled := True;
  StartSign_xxx;
end;

procedure TXkPwqd.CheckKeyAuthorize;
begin
end;

procedure TXkPwqd.EndSign_xxx;
begin
  dm.SignIn1.StopBackgroundSignIn;
  dm.SignIn1.Stop;
  Speak('签到结束！');
end;

procedure TXkPwqd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkPwqd.FormCreate(Sender: TObject);
begin
  dm.KeypadManage1.ShowKeyInfo(0,1);  //0:所有键盘，1：显示大字体
end;

function TXkPwqd.GetPwByKeyCode(const KeyCode: string): string;
var
  sqlstr,swhere:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sWhere := ' where 承考院系='+quotedstr(ayx)+' and 省份='+quotedstr(asf)+' and 考点名称='+quotedstr(akd)+
              ' and 专业='+quotedstr(azy)+' and 签到码='+quotedstr(KeyCode);//+' and 科目='+quotedstr(km);
    sqlstr := 'select 评委 from 校考考点评委表 '+swhere;

    cds_Temp.XMLData := dm.OpenData(sqlstr);
    Result := cds_Temp.Fields[0].AsString;
  finally
    cds_Temp.Free;
  end;
end;

procedure TXkPwqd.InitPWSignCodeList;
var
  sqlstr,swhere:string;
  cds_Temp:TClientDataSet;
begin
  gb_PwCodeList.Clear;
  cds_Temp := TClientDataSet.Create(nil);
  try
    sWhere := ' where 承考院系='+quotedstr(ayx)+' and 省份='+quotedstr(asf)+' and 考点名称='+quotedstr(akd)+
              ' and 专业='+quotedstr(azy);//+' and 签到码='+quotedstr(KeyCode);//+' and 科目='+quotedstr(km);
    sqlstr := 'select 评委,签到码 from 校考考点评委表 '+swhere;

    cds_Temp.XMLData := dm.OpenData(sqlstr);
    while not cds_Temp.eof do
    begin
      gb_PwCodeList.Add(cds_Temp.Fields[0].AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TXkPwqd.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考考点评委表 '+sqlWhere;
  cds_pw.XMLData := dm.OpenData(sqlstr);
end;

procedure TXkPwqd.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  sqlWhere := ' where 承考院系='+quotedstr(aYx)+
                                          ' and 省份='+quotedstr(aSf)+
                                          ' and 考点名称='+quotedstr(aKd)+
                                          ' and 专业='+quotedstr(aZy);
  dm.ExecSql('update 校考考点评委表 set 评分器=null,是否签到=0 '+sqlWhere);
  Open_Table;
  btn_StartClick(Self);
end;

procedure TXkPwqd.SetPwByKeyCode(const pw: string; const KeyId: integer);
begin

end;

procedure TXkPwqd.StartSign_xxx;
begin
  ClearKeysListValue;
  InitPWSignCodeList;

  with dm do
  begin
    //SignIn1.Stop();
    SignIn1.Mode := 1; //签到码签到
    SignIn1.BackgroundSignIn := True; //后台签到模式
    SignIn1.StartMode := 1;
    SignIn1.Start();
  end;
  Speak('请各位评委签到！');
end;

procedure TXkPwqd.UpdatePwQdTable(const pw:string;const KeyId:integer);
var
  sqlstr:string;
begin
  if pw='' then
    sqlstr := 'update 校考考点评委表 set 评分器=null,是否签到=0 '+sqlWhere+' and 评分器='+IntToStr(KeyId)
  else
    sqlstr := 'update 校考考点评委表 set 评分器='+IntToStr(KeyId)+',是否签到=1 '+sqlWhere+' and 评委='+quotedstr(pw);
  showmessage(sqlstr);
  dm.ExecSql(sqlstr);

  Open_Table;
end;

end.
