unit uPwqd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, DBClient, GridsEh, DBGridEh, StdCtrls,
  OleServer, SunVote_TLB;

type
  TPwqd = class(TForm)
    DBGridEh1: TDBGridEh;
    cds_pw: TClientDataSet;
    ds_pw: TDataSource;
    btn_End: TButton;
    btn_Start: TButton;
    SignIn1: TSignIn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SignIn1KeyStatus(ASender: TObject; const BaseTag: WideString;
      KeyID, ValueType: Integer; const KeyValue: WideString);
    procedure btn_StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
  private
    { Private declarations }
    //SignIn1:TSignIn;
    aWhere,aYx,aSf,aKd,aZy:string;
    procedure Open_Table;
    function  GetPwByKeyCode(const KeyCode:string):string;
    procedure SetPwByKeyCode(const pw:string;const KeyId:integer);
    procedure CheckKeyAuthorize;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy:string);
  end;

var
  Pwqd: TPwqd;

implementation
uses uDM;
{$R *.dfm}

procedure TPwqd.btn_EndClick(Sender: TObject);
begin
  btn_start.Enabled := True;
  btn_End.Enabled := False;
  SignIn1.StopBackgroundSignIn;
  SignIn1.Stop;
end;

procedure TPwqd.btn_StartClick(Sender: TObject);
begin
  btn_start.Enabled := False;
  btn_End.Enabled := True;
  SignIn1.BaseConnection := dm.BaseConnection1.DefaultInterface;
  //SignIn1.Stop();
  SignIn1.Mode := 1; //
  SignIn1.BackgroundSignIn := True; //后台签到模式
  SignIn1.StartMode := 1;
  SignIn1.Start();
end;

procedure TPwqd.CheckKeyAuthorize;
var
  keyid:integer;
begin
  with cds_pw do
  begin
    First;
    while not Eof do
    begin
      keyid := FieldByName('评分器').AsInteger;
      if (not FieldByName('是否签到').AsBoolean) and (keyid<>0) then
        SignIn1.SetAuthorize(KeyID,3);
      next;
    end;
  end;
end;

procedure TPwqd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPwqd.FormCreate(Sender: TObject);
begin
  dm.KeypadManage1.ShowKeyInfo(0,1);  //0:所有键盘，1：显示大字体
end;

function TPwqd.GetPwByKeyCode(const KeyCode: string): string;
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

procedure TPwqd.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考考点评委表 '+aWhere;
  cds_pw.XMLData := dm.OpenData(sqlstr);
end;

procedure TPwqd.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  aWhere := ' where 承考院系='+quotedstr(aYx)+
                                          ' and 省份='+quotedstr(aSf)+
                                          ' and 考点名称='+quotedstr(aKd)+
                                          ' and 专业='+quotedstr(aZy);
  dm.ExecSql('update 校考考点评委表 set 评分器=null,是否签到=0 '+aWhere);
  Open_Table;
end;

procedure TPwqd.SetPwByKeyCode(const pw: string; const KeyId: integer);
begin

end;

procedure TPwqd.SignIn1KeyStatus(ASender: TObject; const BaseTag: WideString;
  KeyID, ValueType: Integer; const KeyValue: WideString);
var
  pw:string;
begin
  if ValueType=1 then
  begin
    dm.ExecSql('update 校考考点评委表 set 评分器=null,是否签到=0 where 评分器='+IntTostr(KeyID));
    pw := GetPwByKeyCode(KeyValue);
    if pw='' then
    begin
      SignIn1.SetAuthorize(KeyID,2);
      if cds_pw.Locate('评分器',KeyID,[]) then
      begin
        cds_pw.Edit;
        cds_pw.FieldByName('评分器').Clear;
        cds_pw.FieldByName('是否签到').AsBoolean := False;
        cds_pw.Post;
      end;
{
      SignIn1.SetAuthorize(KeyID,3);
      SignIn1.Stop;
      SignIn1.StartMode := 1;
      SignIn1.Start();
}
    end
    else
    begin
      SignIn1.SetAuthorize(KeyID,1);
      dm.ExecSql('update 校考考点评委表 set 评分器='+IntTostr(KeyId)+',是否签到=1 '+aWhere+' and 评委='+quotedstr(pw));
      if cds_pw.Locate('签到码',KeyValue,[]) then
      begin
        cds_pw.Edit;
        cds_pw.FieldByName('评分器').Value := KeyID;
        cds_pw.FieldByName('是否签到').AsBoolean := True;
        cds_pw.Post;
      end;
    end;
  end else
  begin
    SignIn1.SetAuthorize(KeyID,1);
    if cds_pw.Locate('评分器',KeyID,[]) then
    begin
      cds_pw.Edit;
      cds_pw.FieldByName('是否签到').AsBoolean := True;
      cds_pw.Post;
    end;
  end;
end;

end.
