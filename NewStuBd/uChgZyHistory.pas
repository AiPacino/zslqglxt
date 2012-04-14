unit uChgZyHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, GridsEh, DBGridEh,
  ExtCtrls, DBGridEhImpExp, DBClient, pngimage, frxpngimage, DBGridEhGrouping;

type
  TChgZyHistory = class(TForm)
    Panel1: TPanel;
    dxgrd_1: TDBGridEh;
    btn_Exit: TBitBtn;
    btn_Excel: TBitBtn;
    DataSource1: TDataSource;
    ADOQuery1: TClientDataSet;
    btn_Print: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    btn_Refresh: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExcelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
  private
    { Private declarations }
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  ChgZyHistory: TChgZyHistory;

implementation
uses uDM;
{$R *.dfm}

procedure TChgZyHistory.btn_ExcelClick(Sender: TObject);
begin
  dm.ExportDBEditEH(dxgrd_1);
end;

procedure TChgZyHistory.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TChgZyHistory.btn_PrintClick(Sender: TObject);
var
  ksh,oldzy,sqlstr:string;
begin
  ksh := ADOQuery1.FieldByName('������').AsString;
  oldzy := ADOQuery1.FieldByName('ԭ¼ȡרҵ').AsString;
  sqlstr := 'select * from view_����רҵ��¼�� where ������='+quotedstr(ksh)+' and ԭ¼ȡרҵ='+quotedstr(OldZy);
  dm.PrintReport('����רҵ��˱�.fr3',dm.OpenData(sqlstr),1);
end;

procedure TChgZyHistory.btn_RefreshClick(Sender: TObject);
begin
  OpenTable;
end;

procedure TChgZyHistory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ADOQuery1.Close;
  Action := caFree;
end;

procedure TChgZyHistory.FormCreate(Sender: TObject);
begin
  OpenTable;
end;

procedure TChgZyHistory.OpenTable;
var
  sqlstr:string;
begin
  if gb_Czy_Level='2' then
  begin
    Self.Caption := '�롾'+gb_Czy_Dept+'����ص�'+Self.Caption;
    sqlstr := 'select * from view_����רҵ��¼�� where ԭԺϵ='+quotedstr(gb_Czy_Dept)+' or ��Ժϵ='+quotedstr(gb_Czy_Dept)+' order by Id';
  end else
  begin
    sqlstr := 'select * from view_����רҵ��¼�� order by Id';
  end;

  ADOQuery1.XMLData := dm.OpenData(sqlstr);

end;

end.
