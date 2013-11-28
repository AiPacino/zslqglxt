unit uSelectZyKmPw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzLstBox, RzChkLst, ComCtrls, RzTreeVw,
  DB, DBClient;

type
  TSelectZyKmPw = class(TForm)
    GroupBox2: TGroupBox;
    RzCheckList1: TRzCheckList;
    Panel1: TPanel;
    Bevel1: TBevel;
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    cds_Temp: TClientDataSet;
    cds_Delta: TClientDataSet;
    cds_Master: TClientDataSet;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    aYx,aSf,aKd,aZy,aKm:string;
    procedure InitZyKmCheckList;
    procedure InitPwCheckList;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy,km:string);
  end;

var
  SelectZyKmPw: TSelectZyKmPw;

implementation
uses uDM;
{$R *.dfm}

procedure TSelectZyKmPw.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSelectZyKmPw.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSelectZyKmPw.InitPwCheckList;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select 评委 from 校考评委名单表 where 承考院系='+quotedstr(aYx)+' order by 评委');
    RzCheckList1.Items.Clear;
    RzCheckList1.Items.BeginUpdate;
    while not cds_Temp.Eof do
    begin
      RzCheckList1.Add(cds_Temp.Fields[0].Asstring);
      cds_Temp.Next;
    end;
  finally
    RzCheckList1.Items.EndUpdate;
    cds_Temp.Free;
  end;
end;

procedure TSelectZyKmPw.InitZyKmCheckList;
begin
end;

procedure TSelectZyKmPw.SetParam(const yx, sf, kd,zy,km: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  aKm := km;
  InitZyKmCheckList;
  InitPwCheckList;
end;

end.
