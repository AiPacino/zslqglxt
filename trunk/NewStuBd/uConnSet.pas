unit uConnSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TConnSet = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    btn_Test: TBitBtn;
    btn_Close: TBitBtn;
    Label1: TLabel;
    chk1: TCheckBox;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure chk1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConnSet: TConnSet;

implementation
uses uDM;
{$R *.dfm}

procedure TConnSet.btn_TestClick(Sender: TObject);
begin
  dm.SetConnInfo(Edit1.Text);
  dm.GetConnInfo;
  if AppSrvIsOK then
    MessageBox(Application.Handle,PChar('应用系统服务器连接成功！　'),pchar('连接成功'),MB_OK+MB_ICONINFORMATION)
  else
    MessageBox(Application.Handle,PChar('应用系统服务器连接失败！　'),pchar('连接失败'),MB_OK+MB_ICONERROR);

end;

procedure TConnSet.chk1Click(Sender: TObject);
begin
  Edit1.Enabled := chk1.Checked;
end;

procedure TConnSet.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure TConnSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TConnSet.FormCreate(Sender: TObject);
begin
  Edit1.Text := DM.GetConnInfo;
end;

end.
