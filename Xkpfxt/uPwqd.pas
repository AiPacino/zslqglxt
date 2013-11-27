unit uPwqd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, DBClient, GridsEh, DBGridEh, StdCtrls;

type
  TPwqd = class(TForm)
    DBGridEh1: TDBGridEh;
    cds_pw: TClientDataSet;
    cds_pwid: TIntegerField;
    cds_pwStringField: TStringField;
    cds_pwStringField2: TStringField;
    cds_pwStringField3: TStringField;
    cds_pwField: TBooleanField;
    ds_pw: TDataSource;
    btn1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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

procedure TPwqd.FormCreate(Sender: TObject);
var
  sqlstr:string;
begin
  cds_pw.XMLData := dm.OpenData('select top 3 * from 校考评委名单表');
end;

end.
