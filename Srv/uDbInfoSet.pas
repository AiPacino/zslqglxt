unit uDbInfoSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,ActiveX,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ADODB,DB, pngimage, frxpngimage;

type
  TDbInfoSet = class(TForm)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label8: TLabel;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    DbComboBox: TComboBox;
    HostEdit: TEdit;
    saEdit: TEdit;
    sapwdEdit: TEdit;
    CheckBox1: TCheckBox;
    Test_Btn: TBitBtn;
    Exit_Btn: TBitBtn;
    ADOConnection1: TADOConnection;
    procedure ExitbtnClick(Sender: TObject);
    procedure Test_BtnClick(Sender: TObject);
    procedure Exit_BtnClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DbComboBoxDropDown(Sender: TObject);
  private
    { Private declarations }
    function Save_Connect_Set(const vHost,vDb,vSa,vPwd,vMode:string):Boolean;
    function Get_Connect_Set(var vHost,vDb,vSa,vPwd,vMode:string):string;
  public
    { Public declarations }
  end;

implementation
uses uDbConnect;

{$R *.dfm}
//procedure Listen_Process(const CB:TCommBlock);

procedure TDbInfoSet.ExitbtnClick(Sender: TObject);
begin
  Close;
end;

function TDbInfoSet.Save_Connect_Set(const vHost,vDb,vSa,vPwd,vMode:string):Boolean;
begin
  Result := WriteConnInfo(vHost,vDb,vSa,vPwd,vMode);
end;

procedure TDbInfoSet.Test_BtnClick(Sender: TObject);
var
  sConnStr:String;
  vHost,vSa,vPwd,vDb,vMode:String;
begin
  //CoInitialize(nil);
  Test_Btn.Enabled := False;
  try
    Screen.Cursor := crHourGlass;
    vHost := HostEdit.Text;
    vSa := saEdit.Text;
    vPwd := sapwdEdit.Text;
    vDb := DbComboBox.Text;
    if not CheckBox1.Checked then
      vMode := 'SQL'
    else
      vMode := 'WIN';

    Save_Connect_Set(vHost,vDb,vSa,vPwd,vMode);

    sConnStr := Get_Connect_Set(vHost,vDb,vSa,vPwd,vMode);
    ADOConnection1.Connected := False;
    ADOConnection1.ConnectionString := sConnStr;
    try
      ADOConnection1.Connected := True;
      Save_Connect_Set(vHost,vDb,vSa,vPwd,vMode);
      Application.MessageBox('服务器和数据库连接成功！！','连接成功',MB_OK+MB_ICONinformation);
    except
      Application.MessageBox('服务器和数据库连接失败！请检查设置是否正确！！','连接失败',MB_OK+MB_ICONERROR);
    end;
  finally
    //vobj.Free;
    ADOConnection1.Connected := False;
    Test_Btn.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TDbInfoSet.Exit_BtnClick(Sender: TObject);
begin
  Close;
  ModalResult := mrCancel;
end;

procedure TDbInfoSet.CheckBox1Click(Sender: TObject);
begin
  Label1.Enabled := not CheckBox1.Checked ;
  Label2.Enabled := Label1.Enabled;
  saEdit.Enabled := Label1.Enabled;
  sapwdEdit.Enabled := Label1.Enabled;
end;

procedure TDbInfoSet.FormCreate(Sender: TObject);
var
  vHost,vDb,vSa,vPwd,vMode:String;//OleVariant;
begin
  Get_Connect_Set(vHost,vDb,vsa,vpwd,vMode);
  HostEdit.Text := vHost;
  DbComboBox.Text := vDb;
  saEdit.Text := vSa;
  sapwdEdit.Text := vPwd;
  CheckBox1.Checked := UpperCase(vMode)='WIN';
end;

function TDbInfoSet.Get_Connect_Set(var vHost,vDb,vSa,vPwd,vMode:string): string;
begin
  Result := ReadConnInfo(vHost,vDb,vSa,vPwd,vMode);
end;

procedure TDbInfoSet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDbInfoSet.DbComboBoxDropDown(Sender: TObject);
var
  connect_str,vPwd,vSa,vHost :String;
  adoqry : TADOQuery;
  adoConn : TADOConnection;
begin
  vHost := HostEdit.Text;
  vSa := SaEdit.Text;
  vPwd := SaPwdEdit.Text;

  CoInitialize(nil);//要在Com+或NT Service中使用DB/ADO组件，必须先初始化线程
  adoConn := TADOConnection.Create(nil);
  adoqry := TADOQuery.Create(nil);
  try
    adoConn.ConnectionTimeout := 3;
    adoConn.CommandTimeout := 3;
    adoConn.LoginPrompt := False;
    adoqry.CommandTimeout := 3;
    adoqry.Connection := adoConn;
    if not CheckBox1.Checked then
    begin
      connect_str := 'Provider=SQLOLEDB.1;Password='+vPwd+';Persist Security Info=True;User ID='+vSa+';';
      connect_str := connect_str + 'Data Source='+vHost+';';
    end else
    begin
      connect_str := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Data Source='+vHost;
    end;
    try
      adoConn.ConnectionString := Connect_str;
      connect_str := quotedstr('master')+','+quotedstr('tempdb')+','+quotedstr('model')+','+quotedstr('msdb');
      adoqry.SQL.Text := 'select name from master.dbo.sysdatabases where name not in ('+connect_str+')';
      adoqry.Open;

      DbComboBox.Items.Clear;
      while not adoqry.eof do
      begin
        DbComboBox.Items.Add(adoqry.fieldbyname('name').AsString);
        adoqry.Next;
      end;
      adoqry.Close;
    Except
      //Close;
      MessageBox(Handle, '数据库服务器连接失败！请检查后重试！　　',
        '连接错误', MB_OK + MB_ICONSTOP);
      //Raise;
    end;
  finally
    adoConn.Free;
    adoqry.Free;
    CoUninitialize;
  end;
end;

end.
