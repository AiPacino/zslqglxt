unit uPhotoSavePathSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, DBCtrlsEh, DBCtrls, Mask,
  ADODB;

type
  TPhotoSavePathSet = class(TForm)
    pnl1: TPanel;
    btn_Update: TBitBtn;
    btn_Exit: TBitBtn;
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lbledt_URL: TDBEditEh;
    lbledt_PATH: TDBEditEh;
    lbl1: TLabel;
    qry1: TADOQuery;
    btn_Reset: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PhotoSavePathSet: TPhotoSavePathSet;

implementation
uses uIIS,uDbConnect,Net;
{$R *.dfm}

procedure TPhotoSavePathSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TPhotoSavePathSet.btn_ResetClick(Sender: TObject);
var
  sIp:String;
begin
  if GetFirstWebSite='' then
  begin
    MessageBox(Handle,
      '服务器信息读取失败！请确定本机已安装好IIS 5.0/6.0！　　',
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    sIp := GetLocalIpStr;
  end else
  begin
    sIp := GetWebSiteIP(1);//第一个Web Site
    if sIp[Length(sIp)]=':' then
       sIp := Copy(sIp,1,Length(sIp)-1);
    if sIp[1]=':' then
       sIp := GetLocalIpStr+sIp;
  end;
  lbledt_URL.Text := 'http://'+sIp+'/'+'zslq/Srv/kszp';
  lbledt_Path.Text := ExtractFilePath(ParamStr(0))+'kszp\';
end;

procedure TPhotoSavePathSet.btn_UpdateClick(Sender: TObject);
begin
  qry1.Edit;
  qry1.FieldByName('sUrl').Value := lbledt_URL.Text;
  qry1.FieldByName('SavePath').Value := lbledt_PATH.Text;
  qry1.Post;
  Application.MessageBox('配置信息保存成功！', '系统提示', MB_OK + 
    MB_ICONINFORMATION + MB_TOPMOST);
end;

procedure TPhotoSavePathSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry1.Close;
  Action := caFree;
end;

procedure TPhotoSavePathSet.FormCreate(Sender: TObject);
begin
  qry1.Close;
  qry1.ConnectionString := uDbConnect.GetConnectString;
  qry1.SQL.Text := 'select * from 照片路径信息表';
  qry1.Open;
  lbledt_URL.Text := qry1.FieldByName('sUrl').AsString;
  lbledt_PATH.Text := qry1.FieldByName('SavePath').AsString;
end;

end.
