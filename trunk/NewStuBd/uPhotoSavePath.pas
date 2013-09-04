unit uPhotoSavePath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, DBCtrlsEh, DBCtrls, Mask;

type
  TPhotoSavePath = class(TForm)
    pnl1: TPanel;
    btn_Update: TBitBtn;
    btn_Exit: TBitBtn;
    cds_1: TClientDataSet;
    ds1: TDataSource;
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PhotoSavePath: TPhotoSavePath;

implementation
uses uDM;
{$R *.dfm}

procedure TPhotoSavePath.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TPhotoSavePath.btn_UpdateClick(Sender: TObject);
begin
  if DataSetNoSave(cds_1) then
    if dm.UpdateData('ID','select * from 照片路径信息表',cds_1.Delta) then
    begin
      cds_1.MergeChangeLog;
    end;
end;

procedure TPhotoSavePath.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPhotoSavePath.FormCreate(Sender: TObject);
begin
  cds_1.XMLData := DM.OpenData('select * from 照片路径信息表');
end;

end.
