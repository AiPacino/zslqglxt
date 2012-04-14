unit uFormatKL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrlsEh, ExtCtrls, DB, DBClient;

type
  TFormatKL = class(TForm)
    lbledt_sf: TEdit;
    lbledt_pc: TEdit;
    lbledt_KL: TEdit;
    cbb_NewKL: TDBComboBoxEh;
    lbl_NewKl: TLabel;
    btn_OK: TBitBtn;
    btn_Cancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    lbl1: TLabel;
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_NewKLChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
  private
    { Private declarations }
    aDataSet:TClientDataSet;
    procedure SaveData;
  public
    { Public declarations }
    procedure FillData(const vSf,vPc,vKl:string;cds_Source:TclientDataSet);
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TFormatKL.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormatKL.btn_OKClick(Sender: TObject);
begin
  SaveData;
end;

procedure TFormatKL.cbb_NewKLChange(Sender: TObject);
begin
  btn_OK.Enabled := cbb_NewKL.Text<>'';
end;

procedure TFormatKL.FillData(const vSf, vPc, vKl: string;
  cds_Source: TClientDataSet);
begin
  lbledt_sf.Text := vSf;
  lbledt_pc.Text := vPc;
  lbledt_KL.Text := vKl;
  aDataSet := cds_Source;
end;

procedure TFormatKL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormatKL.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetKLList(sList);
    cbb_NewKL.Items.Assign(sList);
  finally
    sList.Free;
  end;
end;

procedure TFormatKL.SaveData;
var
  sf,pc,kl,sqlstr,sWhere:string;
  iResult :Integer;
begin
  sf := QuotedStr(lbledt_sf.Text);
  pc := QuotedStr(lbledt_pc.Text);
  kl := QuotedStr(lbledt_KL.Text);
  sWhere := ' where 省份='+sf+' and 批次='+pc+' and 科类名称='+kl;
  sqlstr := 'update 录取信息表 set 科类='+quotedstr(cbb_NewKL.Text)+sWhere;

  sqlstr := 'select count(*) from 录取信息表 '+sWhere;
  dm.ExecSql(sqlstr);
  iResult := vobj.GetRecordCountBySql(sqlstr);
  MessageBox(Handle, PChar('操作完成！共有'+IntToStr(iResult)+'条记录被更新！　'), '系统提示',
    MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
end;

end.
