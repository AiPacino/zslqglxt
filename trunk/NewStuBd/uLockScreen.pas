unit uLockScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TLockScreen = class(TForm)
    lbl_Msg: TLabel;
    edt_Pwd: TEdit;
    btn_Check: TBitBtn;
    btn_Exit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btn_CheckClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure edt_PwdChange(Sender: TObject);
  private
    { Private declarations }
    gb_CanClose:Boolean;
  public
    { Public declarations }
  end;

var
  LockScreen: TLockScreen;

implementation
uses uDM,uMain,Net;
{$R *.dfm}

procedure TLockScreen.btn_CheckClick(Sender: TObject);
var
  i:Integer;
  sMsg:string;
begin
  Screen.Cursor := crHourGlass;
  try
    if not vobj.CzyLogin(gb_Czy_ID,edt_Pwd.Text,Get_Version,sMsg) then
    begin
      Application.MessageBox(PChar(sMsg+'请检查后重输！　　'),
        '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      edt_Pwd.SetFocus;
      Exit;
    end;

    for i := Main.AlphaBlendValue to 255 do
      Main.AlphaBlendValue := Main.AlphaBlendValue+i;
    Main.AlphaBlend := False;
    gb_CanClose := True;
    Self.Close;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TLockScreen.btn_ExitClick(Sender: TObject);
begin
  Main.Close;
  Self.BringToFront;
  //gb_CanClose := True;
end;

procedure TLockScreen.edt_PwdChange(Sender: TObject);
begin
  btn_Check.Enabled := edt_Pwd.Text<>'';
end;

procedure TLockScreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TLockScreen.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := gb_CanClose;
end;

procedure TLockScreen.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  gb_CanClose := False;
  Main.AlphaBlend := False;//True;
  for i := 0 to 255 do
  begin
    Main.AlphaBlendValue := 255-i;
    //Sleep(50);
    //Application.ProcessMessages;
  end;
end;

end.
