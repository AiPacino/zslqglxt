unit uDisplayMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CnAAFont, CnAACtrls, DBGridEhGrouping, DB, DBClient, GridsEh,
  DBGridEh, Grids;

type
  TDisplayMessage = class(TForm)
    albl_SysName: TCnAALabel;
    albl_Dwmc: TCnAALabel;
    albl_Ksxx: TCnAALabel;
    cds_Pf: TClientDataSet;
    ds_Pf: TDataSource;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TDisplayMessage.FormCreate(Sender: TObject);
begin
  Self.Caption := Application.Title;
end;

end.
