unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, DBClient, ExtCtrls, auAutoUpgrader,
  CnAAFont, CnAACtrls, auHTTP, pngimage, frxpngimage, jpeg, Mask, DBCtrlsEh;

type
  TLogin = class(TForm)
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    ClientDataSet1: TClientDataSet;
    Edit2: TDBEditEh;
    AALabel2: TCnAALabel;
    Bevel1: TBevel;
    AALabel3: TCnAALabel;
    Panel1: TPanel;
    Image1: TImage;
    btn_Test: TSpeedButton;
    lbl_ver: TCnAALabel;
    auAutoUpgrader1: TauAutoUpgrader;
    img1: TImage;
    albl1: TCnAALabel;
    Edit1: TDBComboBoxEh;
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure auAutoUpgrader1DoOwnCloseAppMethod(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iCount : Integer;
    function ConnectAppSrvIsOK:Boolean;
    procedure GetUserList;
    procedure SaveUserList;
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation
uses uDM,Net,uConnSet,IniFiles;

{$R *.dfm}

function TLogin.ConnectAppSrvIsOK:Boolean;
begin
  Result := AppSrvIsOK;
  if not Result then
  begin
    MessageBox(Application.Handle,PChar('新生报到系统服务器连接失败！　'),pchar('服务器或网络连接失败'),MB_OK+MB_ICONERROR);
  end;
end;

procedure TLogin.btn_OKClick(Sender: TObject);
var
  sMsg:string;
begin
  if not ConnectAppSrvIsOK then  //连接服务器失败
     Exit;

  try
    while iCount<=3 do
    begin
      inc(iCount);
      //=============考生是否合法==============//
      if vobj.CzyLogin(Edit1.Text,Edit2.Text,Get_Version,sMsg) = False then
      begin
        gbIsOK := false;
        Application.MessageBox(pchar(sMsg),'登录失败',MB_OK+MB_ICONERROR);
        Edit1.SetFocus;
        Exit;
      end
      else
      begin
        SaveUserList;
        gb_Czy_ID := Edit1.Text;
        gb_Czy_NAME := vobj.GetCzyName(gb_Czy_ID);
        gb_Czy_Level := vobj.GetCzyLevel(gb_Czy_ID);
        gb_czy_Dept := vobj.GetCzyDept(gb_Czy_Id);
        gbIsOK := True;
{
        if (gb_Czy_Level<>'-1') and (not vobj.IsValidIp) then
        begin
          MessageBox(Handle,
                     pchar('登录被拒绝！非法的IP接入地址！如有疑问，请与系统管理员　'+#13+
                           '或应用系统管理部门联系！　　'+#13),
                     '系统提示',
                     MB_OK + MB_ICONWARNING + MB_TOPMOST);
          gbIsOK := False;
        end
        else if (gb_Czy_Level<>'-1') and (not vobj.SrvIsOpen) then
        begin
          MessageBox(Handle,
                     pchar('登录被拒绝！新生报到系统服务器已关闭！如有疑问，　'+#13+
                           '请与系统管理员或应用系统管理部门联系！　　'+#13),
                     '系统提示',
                     MB_OK + MB_ICONWARNING + MB_TOPMOST);
          gbIsOK := False;
        end else
        begin
          gbIsOK := True;
        end;
}
        Break;
      end;
    end; //end while ....
  finally
    if gbIsOK or (iCount>3) then
      Self.Close;
    //vobj := nil;
  end;
end;

procedure TLogin.btn_TestClick(Sender: TObject);
begin
  with TConnSet.Create(nil) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TLogin.FormCreate(Sender: TObject);
begin
  Self.Caption := Application.Title+'登录';
  gbIsOK := False;
  lbl_ver.Caption := 'Ver: '+Get_Version;
  iCount := 1;

  //if not DM.RegIsOK then //没有注册的话，就不会自动升级
  //  Exit;

  GetUserList;

  with Self do
  begin
    auAutoUpgrader1.AutoCheck := False;
    auAutoUpgrader1.VersionNumber := Get_Version;
    auAutoUpgrader1.InfoFileURL := DM.GetClientAutoUpdateUrl;
    auAutoUpgrader1.ShowMessages := [mAskUpgrade];
    auAutoUpgrader1.CheckUpdate;
  end;
end;

procedure TLogin.FormShow(Sender: TObject);
begin
  if Edit1.Text='' then
    Edit1.SetFocus
  else
    Edit2.SetFocus;
end;

procedure TLogin.GetUserList;
var
  fn,str:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    str := ReadString('LoginSet','UserList','');
    Edit1.Items.Delimiter := '|';
    Edit1.Items.StrictDelimiter := True;
    Edit1.Items.DelimitedText := str;
    Edit1.Text := ReadString('LoginSet','LastUser','');
  end;
end;

procedure TLogin.SaveUserList;
var
  fn,str:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  try
    if Edit1.Items.IndexOf(Edit1.Text)=-1 then
      Edit1.Items.Add(Edit1.Text);

    Edit1.Items.Delimiter := '|';
    Edit1.Items.StrictDelimiter := True;
    str := Edit1.Items.DelimitedText;
    WriteString('LoginSet','UserList',str);
    WriteString('LoginSet','LastUser',Edit1.Text);
  finally
    Free;
  end;
end;

procedure TLogin.auAutoUpgrader1DoOwnCloseAppMethod(Sender: TObject);
begin
  gbIsOK := False;
  gbCanClose := True;
  Close;
end;

procedure TLogin.btn_ExitClick(Sender: TObject);
begin
  gbIsOK := False;
  Close;
end;

procedure TLogin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TLogin.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Edit2.SetFocus;
end;

procedure TLogin.Edit2Change(Sender: TObject);
begin
  btn_OK.Enabled := (Edit1.Text<>'') and (Edit2.Text<>'');
end;

procedure TLogin.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13  then
  begin
    if btn_OK.CanFocus then
       btn_OK.SetFocus;
    btn_OK.Click;
  end;
end;

procedure TLogin.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btn_OK.SetFocus;
end;

procedure TLogin.Edit1Change(Sender: TObject);
begin
  btn_OK.Enabled := (Edit1.Text<>'') and (Edit2.Text<>'');
end;

end.
