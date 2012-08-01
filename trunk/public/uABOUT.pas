unit uABOUT;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, CnAAFont, CnAACtrls,ShellAPI, dxGDIPlusClasses, pngimage,
  frxpngimage;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    btn_Reg: TButton;
    albl_Title: TCnAALabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SrvCode: TLabel;
    ProgramIcon: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_RegClick(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation
uses uDM,Net;
{$R *.dfm}

procedure TAboutBox.btn_RegClick(Sender: TObject);
var
  fn :string;
begin
  fn := ExtractFilePath(ParamStr(0))+'SysReg.exe';
  if FileExists(fn) then
  begin
    //ShellExecute(Application.Handle,'open',PChar(fn),nil,nil,SW_SHOW)
    RunAndWait(fn,SW_SHOW);
    //Self.Close;
  end else
    MessageBox(Handle, '系统注册工具：SysReg.exe 未找到！　　', '系统提示',
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  if ParamCount>0 then
    Version.Caption := 'Ver '+ParamStr(1)
  else
  begin
    Version.Caption := 'Ver '+Get_Version;
    if Application.Title<>'About' then
      albl_Title.Caption := Application.Title;
  end;
    
  Screen.Cursor := crHourGlass;
  try                       
    Comments.Caption := vobj.GetUserInfo;
    SrvCode.Caption := vobj.GetMacInfo;
    if vobj.RegIsOK then
      Comments.Caption := vobj.GetUserInfo+'[已注册版本]'
    else
      Comments.Caption := vobj.GetUserInfo+'[未注册版本]'
  finally
    //vobj := nil;
    Screen.Cursor := crDefault;
  end;
end;

procedure TAboutBox.Label2Click(Sender: TObject);
begin
  ShellExecute(0,'open',PChar(TLabel(Sender).Caption),nil,nil,SW_SHOW);
end;

procedure TAboutBox.Label2MouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Font.Style := [fsUnderline];
end;

procedure TAboutBox.Label2MouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlack;
  TLabel(Sender).Font.Style := [];
end;

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  Close;
end;

end.
 
