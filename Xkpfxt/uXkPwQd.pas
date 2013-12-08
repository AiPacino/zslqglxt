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
    if not cds_pw.FieldByName('�Ƿ�ǩ��').AsBoolean then
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
  dm.SignIn1.StopBackgroundSignIn;
  dm.SignIn1.Stop;
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
    sWhere := ' where �п�Ժϵ='+quotedstr(ayx)+' and ʡ��='+quotedstr(asf)+' and ��������='+quotedstr(akd)+
              ' and רҵ='+quotedstr(azy)+' and ǩ����='+quotedstr(KeyCode);//+' and ��Ŀ='+quotedstr(km);
    sqlstr := 'select ��ί from У��������ί�� '+swhere;

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
    sWhere := ' where �п�Ժϵ='+quotedstr(ayx)+' and ʡ��='+quotedstr(asf)+' and ��������='+quotedstr(akd)+
              ' and רҵ='+quotedstr(azy);//+' and ǩ����='+quotedstr(KeyCode);//+' and ��Ŀ='+quotedstr(km);
    sqlstr := 'select ��ί,ǩ���� from У��������ί�� '+swhere;

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
  sqlstr := 'select * from У��������ί�� '+sqlWhere;
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
  dm.ExecSql('update У��������ί�� set ������=null,�Ƿ�ǩ��=0 '+sqlWhere);
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
