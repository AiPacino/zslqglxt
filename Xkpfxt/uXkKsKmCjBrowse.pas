unit uXkKsKmCjBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBGridEhGrouping;

type
  TXkKsKmcjBrowse = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open_Table(const Yx,Zy,Ksh:string);
  end;

var
  XkKsKmcjBrowse: TXkKsKmcjBrowse;

implementation
uses uDM;
{$R *.dfm}

{ TXkKsKmcjBrowse }

procedure TXkKsKmcjBrowse.Open_Table(const Yx,Zy,Ksh: string);
var
  sqlstr:string;
begin
  sqlstr := 'select * from view_У�����Ƴɼ������� where ������='+quotedstr(ksh)+
            ' and �п�Ժϵ='+quotedstr(Yx)+' and רҵ='+quotedstr(Zy);
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
