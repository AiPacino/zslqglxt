unit uOnlineUpdateSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, Mask, DBCtrlsEh,
  ExtCtrls, pngimage, frxpngimage;

type
  TOnlineUpdateSet = class(TForm)
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Panel1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    grp1: TGroupBox;
    DBEdit1: TDBEditEh;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl_Hint: TLabel;
    DBEdit2: TDBEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  OnlineUpdateSet: TOnlineUpdateSet;

implementation
uses uDM;
{$R *.dfm}

procedure TOnlineUpdateSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TOnlineUpdateSet.btn_SaveClick(Sender: TObject);
begin
  if ClientDataSet1.State in [dsInsert,dsEdit] then
    ClientDataSet1.Post;
  if ClientDataSet1.ChangeCount>0 then
    if dm.UpdateData('ID','select * from 自动更新地址表',ClientDataSet1.Delta) then
      Application.MessageBox('自动更新配置信息设置成功！　　', '操作提示', MB_OK
        + MB_ICONINFORMATION);
end;

procedure TOnlineUpdateSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TOnlineUpdateSet.FormCreate(Sender: TObject);
begin
  ClientDataSet1.XMLData := dm.OpenData('select * from 自动更新地址表');
end;

end.
