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
  SignIn1.BackgroundSignIn := True; //��̨ǩ��ģʽ
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
      keyid := FieldByName('������').AsInteger;
      if (not FieldByName('�Ƿ�ǩ��').AsBoolean) and (keyid<>0) then
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
  dm.KeypadManage1.ShowKeyInfo(0,1);  //0:���м��̣�1����ʾ������
end;

function TPwqd.GetPwByKeyCode(const KeyCode: string): string;
var
  sqlstr,swhere:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sWhere := ' where �п�Ժϵ='+quotedstr(ayx)+' and ʡ��='+quotedstr(asf)+' and ��������='+quotedstr(akd)+
              ' and רҵ='+quotedstr(azy)+' and ǩ����='+quotedstr(KeyCode);//+' and ��Ŀ='+quotedstr(km);
    sqlstr := 'select ��ί from У��������ί�� '+swhere;

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
  sqlstr := 'select * from У��������ί�� '+aWhere;
  cds_pw.XMLData := dm.OpenData(sqlstr);
end;

procedure TPwqd.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  aWhere := ' where �п�Ժϵ='+quotedstr(aYx)+
                                          ' and ʡ��='+quotedstr(aSf)+
                                          ' and ��������='+quotedstr(aKd)+
                                          ' and רҵ='+quotedstr(aZy);
  dm.ExecSql('update У��������ί�� set ������=null,�Ƿ�ǩ��=0 '+aWhere);
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
    dm.ExecSql('update У��������ί�� set ������=null,�Ƿ�ǩ��=0 where ������='+IntTostr(KeyID));
    pw := GetPwByKeyCode(KeyValue);
    if pw='' then
    begin
      SignIn1.SetAuthorize(KeyID,2);
      if cds_pw.Locate('������',KeyID,[]) then
      begin
        cds_pw.Edit;
        cds_pw.FieldByName('������').Clear;
        cds_pw.FieldByName('�Ƿ�ǩ��').AsBoolean := False;
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
      dm.ExecSql('update У��������ί�� set ������='+IntTostr(KeyId)+',�Ƿ�ǩ��=1 '+aWhere+' and ��ί='+quotedstr(pw));
      if cds_pw.Locate('ǩ����',KeyValue,[]) then
      begin
        cds_pw.Edit;
        cds_pw.FieldByName('������').Value := KeyID;
        cds_pw.FieldByName('�Ƿ�ǩ��').AsBoolean := True;
        cds_pw.Post;
      end;
    end;
  end else
  begin
    SignIn1.SetAuthorize(KeyID,1);
    if cds_pw.Locate('������',KeyID,[]) then
    begin
      cds_pw.Edit;
      cds_pw.FieldByName('�Ƿ�ǩ��').AsBoolean := True;
      cds_pw.Post;
    end;
  end;
end;

end.
