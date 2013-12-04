unit uPwqd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, DBClient, GridsEh, DBGridEh, StdCtrls;

type
  TPwqd = class(TForm)
    DBGridEh1: TDBGridEh;
    cds_pw: TClientDataSet;
    ds_pw: TDataSource;
    btn_OK: TButton;
    btn_Close: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    aYx,aSf,aKd,aZy:string;
    procedure Open_Table;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy:string);
  end;

var
  Pwqd: TPwqd;

implementation
uses uDM;
{$R *.dfm}

procedure TPwqd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPwqd.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考考点评委表 where 承考院系='+quotedstr(aYx)+
                                          ' and 省份='+quotedstr(aSf)+
                                          ' and 考点名称='+quotedstr(aKd)+
                                          ' and 专业='+quotedstr(aZy);
  cds_pw.XMLData := dm.OpenData(sqlstr);
end;

procedure TPwqd.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  Open_Table;

end;

end.
