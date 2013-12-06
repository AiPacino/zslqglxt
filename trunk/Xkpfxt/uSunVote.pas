unit uSunVote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleServer, SunVote_TLB;

type
  TForm2 = class(TForm)
    BaseConnection1: TBaseConnection;
    mmo1: TMemo;
    btn1: TButton;
    BaseManage1: TBaseManage;
    btn2: TButton;
    KeypadManage1: TKeypadManage;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    SignIn1: TSignIn;
    btn6: TButton;
    Message1: TMessage;
    btn7: TButton;
    procedure BaseConnection1BaseOnLine(ASender: TObject; BaseID,
      BaseState: Integer);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure BaseManage1BaseConfig(ASender: TObject; BaseID, BaseChannel,
      KeyIDMin, KeyIDMax, RFPower: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure KeypadManage1KeyConfig(ASender: TObject; KeyID, OffTime: Integer);
    procedure btn4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure SignIn1KeyStatus(ASender: TObject; const BaseTag: WideString;
      KeyID, ValueType: Integer; const KeyValue: WideString);
    procedure SignIn1KeyStatusSN(ASender: TObject; const BaseTag, KeySN,
      KeyValue: WideString; KeyTime: Double);
    procedure SignIn1KeyAuthorizeSN(ASender: TObject; const BaseTag: WideString;
      KeyID: Integer; const HSerial: WideString; AuthMode: Integer);
    procedure SignIn1KeyAuthorize(ASender: TObject; const BaseTag: WideString;
      KeyID, AuthMode: Integer);
    procedure btn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BaseConnection1BaseOnLine(ASender: TObject; BaseID,
  BaseState: Integer);
begin
  mmo1.Lines.Add(Format('BaseID: %d,BaseState %d',[BaseID,BaseState]));
end;

procedure TForm2.BaseManage1BaseConfig(ASender: TObject; BaseID, BaseChannel,
  KeyIDMin, KeyIDMax, RFPower: Integer);
begin
  mmo1.Lines.Add(Format('BaseID %d',[BaseID]));
end;

procedure TForm2.btn1Click(Sender: TObject);
begin
  BaseConnection1.Open(1,'1');
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  BaseManage1.GetConfig(0);
end;

procedure TForm2.btn3Click(Sender: TObject);
begin
  KeypadManage1.GetConfig();
end;

procedure TForm2.btn4Click(Sender: TObject);
begin
  KeypadManage1.RemoteOff(0);
end;

procedure TForm2.btn5Click(Sender: TObject);
begin
  KeypadManage1.ShowKeyInfo(0,1);  //0:所有键盘，1：显示大字体
end;

procedure TForm2.btn6Click(Sender: TObject);
begin
  SignIn1.BaseConnection := BaseConnection1.DefaultInterface;
  //SignIn1.Stop();
  SignIn1.Mode := 1;
  SignIn1.StartMode := 1;
  SignIn1.Start();
end;

procedure TForm2.btn7Click(Sender: TObject);
var
  i: Integer;
begin
  Message1.BaseConnection := BaseConnection1.DefaultInterface;
  for i := 1 to 3 do
    Message1.Start('0',Format('%-.3d,请签到！',[i]));
  mmo1.Lines.Add(Message1.DownloadErrorKeyIDs);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  BaseConnection1.Open(1,'1');
  //baseConnection.ProtocolType := 2; // EVS 2
  BaseManage1.BaseConnection := BaseConnection1.DefaultInterface;
  KeypadManage1.BaseConnection := BaseConnection1.DefaultInterface;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  BaseConnection1.Close;
end;

procedure TForm2.KeypadManage1KeyConfig(ASender: TObject; KeyID,
  OffTime: Integer);
begin
  mmo1.Lines.Add(Format('KeyID:%d,OffTime:%d',[KeyID,OffTime]));
end;

procedure TForm2.SignIn1KeyAuthorize(ASender: TObject;
  const BaseTag: WideString; KeyID, AuthMode: Integer);
begin
  mmo1.Lines.Add(Format('BaseTag:%d,KeyID:%d,AuthMode:%d',[BaseTag,KeyID,AuthMode]));
end;

procedure TForm2.SignIn1KeyAuthorizeSN(ASender: TObject;
  const BaseTag: WideString; KeyID: Integer; const HSerial: WideString;
  AuthMode: Integer);
begin
  mmo1.Lines.Add(Format('BaseTag:%d,KeyID:%d,HSerial:%s,AuthMode:%d',[BaseTag,KeyID,HSerial,AuthMode]));
end;

procedure TForm2.SignIn1KeyStatus(ASender: TObject; const BaseTag: WideString;
  KeyID, ValueType: Integer; const KeyValue: WideString);
begin
  mmo1.Lines.Add(Format('KeyID:%d,ValueType:%d,KeyValue:%s',[KeyID,ValueType,KeyValue]));
  if (KeyID=3) and (ValueType=1) then
    if KeyValue<>'1234' then
    begin
      SignIn1.SetAuthorize(KeyID,2);
{      SignIn1.SetAuthorize(KeyID,3);
      SignIn1.Stop;
      SignIn1.StartMode := 1;
      SignIn1.Start();
}
    end
    else
      SignIn1.SetAuthorize(KeyID,1);
end;

procedure TForm2.SignIn1KeyStatusSN(ASender: TObject; const BaseTag, KeySN,
  KeyValue: WideString; KeyTime: Double);
begin
  mmo1.Lines.Add(Format('BaseTag:%s,KeySN:%s,KeyValue:%s,KeyTime:%f',[BaseTag,KeySN,KeyValue,KeyTime]));
end;

end.
