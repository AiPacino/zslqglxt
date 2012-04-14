unit uInputSaPwd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,ADODB;

type
  TInputSaPwd = class(TForm)
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    lbl_1: TLabel;
    lbl1: TLabel;
    bvl1: TBevel;
    edt_Pwd: TEdit;
    lbl2: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  InputSaPwd: TInputSaPwd;

implementation
uses uDbConnect,uSQLBackupRestore;
{$R *.dfm}

procedure TInputSaPwd.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TInputSaPwd.btn_OKClick(Sender: TObject);
var
  sConnStr,vHost,vDb,vSa,vPwd,vMode:string;
  adoConn:TAdoConnection;
begin
  ReadConnInfo(vHost,vDb,vSa,vPwd,vMode);
  vDb := 'master';
  vSa := 'sa';
  vPwd := edt_Pwd.Text;
  vMode := 'SQL';

  if UpperCase(vMode) <> 'WIN' then  //SQL连接模式
     sConnStr := 'Provider=SQLOLEDB.1;Password='+vPwd+';Persist Security Info=True;User ID='+vSa+';'+
               'Initial Catalog='+vDb+';Data Source='+vHost
  else  //Windows NT连接模式
     sConnStr := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;'+
               'Initial Catalog='+vDb+';Data Source='+vHost;
  adoConn := TADOConnection.Create(nil);
  try
    adoConn.ConnectionString := sConnStr;
    adoConn.ConnectionTimeout := 3;
    adoConn.LoginPrompt := False;
    try
      adoConn.Connected := True;
      sSaConnStr := sConnStr;
      Self.Close;
      //Application.MessageBox('服务器和数据库连接成功！！','连接成功',MB_OK+MB_ICONinformation);
    except
      sSaConnStr := '';
      Application.MessageBox('SA密码错误！请检查后重新输入！！　　','连接失败',MB_OK+MB_ICONERROR);
    end;
  finally
    adoConn.Free;
  end;
end;

procedure TInputSaPwd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
