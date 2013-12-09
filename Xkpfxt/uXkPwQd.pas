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
    SignIn1: TSignIn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
    procedure SignIn1KeyStatus(ASender: TObject; const BaseTag: WideString;
      KeyID, ValueType: Integer; const KeyValue: WideString);
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
    procedure InitPWSignTable;
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
    if cds_pw.FieldByName('������').IsNull then
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
    Application.MessageBox('�ڲ�������ίȱ�������£�������ίû��ǩ����' + 
      #13#10 + '���ܽ���ǩ����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
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
  SignIn1.StopBackgroundSignIn;
  SignIn1.Stop;
  Speak('ǩ��������');
end;

procedure TXkPwqd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkPwqd.FormCreate(Sender: TObject);
begin
  dm.KeypadManage1.ShowKeyInfo(0,1);  //0:���м��̣�1����ʾ������
end;

function TXkPwqd.GetPwByKeyCode(const KeyCode: string): string;
var
  sqlstr,swhere:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sWhere := sqlWhere+' and ǩ����='+quotedstr(KeyCode);
    sqlstr := 'select ��ί from У���ֳ����ֱ� '+swhere;

    cds_Temp.XMLData := dm.OpenData(sqlstr);
    Result := cds_Temp.Fields[0].AsString;
  finally
    cds_Temp.Free;
  end;
end;

procedure TXkPwqd.InitPWSignCodeList;
var
  sqlstr:string;
  cds_Temp:TClientDataSet;
begin
  gb_PwCodeList.Clear;
  cds_Temp := TClientDataSet.Create(nil);
  try
    sqlstr := 'delete from У���ֳ����ֱ�';
    dm.ExecSql(sqlstr);
    sqlstr := 'insert into У���ֳ����ֱ� (�п�Ժϵ,ʡ��,��������,רҵ,��ί,ǩ����) ';
    sqlstr := sqlstr+'select �п�Ժϵ,ʡ��,��������,רҵ,��ί,ǩ���� from У��������ί�� '+sqlWhere+' order by ��ί';
    dm.ExecSql(sqlstr);

    sqlstr := 'select * from У���ֳ����ֱ�';
    cds_Temp.XMLData := dm.OpenData(sqlstr);
    while not cds_Temp.eof do
    begin
      gb_PwCodeList.Add(cds_Temp.FieldByName('��ί').AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TXkPwqd.InitPWSignTable;
var
  sqlstr:string;
begin
  sqlstr := 'delete from У���ֳ����ֱ�';
  dm.ExecSql(sqlstr);
  sqlstr := 'insert into У���ֳ����ֱ� (�п�Ժϵ,ʡ��,��������,רҵ,��ί,ǩ����) ';
  sqlstr := sqlstr+'select �п�Ժϵ,ʡ��,��������,רҵ,��ί,ǩ���� from У��������ί�� '+sqlWhere+' order by ��ί';
  dm.ExecSql(sqlstr);
end;

procedure TXkPwqd.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У���ֳ����ֱ� '+sqlWhere;
  cds_pw.XMLData := dm.OpenData(sqlstr);
end;

procedure TXkPwqd.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  sqlWhere := ' where �п�Ժϵ='+quotedstr(aYx)+
              ' and ʡ��='+quotedstr(aSf)+
              ' and ��������='+quotedstr(aKd)+
              ' and רҵ='+quotedstr(aZy);
  InitPWSignTable;
  Open_Table;
  btn_StartClick(Self);
end;

procedure TXkPwqd.SetPwByKeyCode(const pw: string; const KeyId: integer);
begin

end;

procedure TXkPwqd.SignIn1KeyStatus(ASender: TObject; const BaseTag: WideString;
  KeyID, ValueType: Integer; const KeyValue: WideString);
var
  pw:string;
  sqlstr:string;
begin
  if ValueType=1 then //ǩ����ǩ��
  begin
    pw := GetPwByKeyCode(KeyValue);
    if pw='' then
    begin
      SignIn1.SetAuthorize(KeyID,2); //�ܾ���Ȩ
      gb_KeyPwList.Values[IntToStr(KeyID)] := '';
    end
    else
    begin
      SignIn1.SetAuthorize(KeyID,1); //ͬ����Ȩ
      gb_KeyPwList.Values[IntToStr(KeyID)] := pw;
    end;
  end else
  begin
    SignIn1.SetAuthorize(KeyID,1);
    gb_KeyPwList.Values[IntToStr(KeyID)] := pw;
  end;
  //XkPwqd.UpdatePwQdTable(pw,KeyID);
  if pw='' then
    sqlstr := 'update У���ֳ����ֱ� set ������=null where ������='+IntToStr(KeyId)
  else
    sqlstr := 'update У���ֳ����ֱ� set ������='+IntToStr(KeyId)+' where ��ί='+quotedstr(pw);
  dm.ExecSql(sqlstr);

  DBGridEh1.SaveBookmark;
  Open_Table;
  DBGridEh1.RestoreBookmark;
end;

procedure TXkPwqd.StartSign_xxx;
begin
  ClearKeysListValue;
  InitPWSignCodeList;

  with Self do
  begin
    SignIn1.BaseConnection := dm.BaseConnection1.DefaultInterface;
    //SignIn1.Stop();
    SignIn1.Mode := 1; //ǩ����ǩ��
    SignIn1.BackgroundSignIn := True; //��̨ǩ��ģʽ
    SignIn1.StartMode := 1;
    SignIn1.Start();
  end;
  Speak('���λ��ίǩ����');
end;

procedure TXkPwqd.UpdatePwQdTable(const pw:string;const KeyId:integer);
var
  sqlstr:string;
begin
  if pw='' then
    sqlstr := 'update У��������ί�� set ������=null,�Ƿ�ǩ��=0 '+sqlWhere+' and ������='+IntToStr(KeyId)
  else
    sqlstr := 'update У��������ί�� set ������='+IntToStr(KeyId)+',�Ƿ�ǩ��=1 '+sqlWhere+' and ��ί='+quotedstr(pw);
  showmessage(sqlstr);
  dm.ExecSql(sqlstr);

  Open_Table;
end;

end.
