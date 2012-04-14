unit uLqqkBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls, DB, StrUtils,
  DBClient, GridsEh, DBGridEh, RzPanel, RzRadGrp, Menus, DBGridEhImpExp,
  DBGridEhGrouping, Mask, DBCtrlsEh, frxpngimage, pngimage;

type
  TLqqkBrowse = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Excel: TBitBtn;
    GroupBox1: TGroupBox;
    DBGridEH1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    N1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    mi_Export: TMenuItem;
    btn_RefreshBdl: TBitBtn;
    mi_RefreshBdl: TMenuItem;
    btn_Print: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    lbl_Title: TLabel;
    img_Hint: TImage;
    grp_Yx: TGroupBox;
    cbb_XlCc: TDBComboBoxEh;
    btn_More: TBitBtn;
    GroupBox2: TGroupBox;
    cbb_Lb: TDBComboBoxEh;
    grp_Sf: TGroupBox;
    cbb_Sf: TDBComboBoxEh;
    mni_N3: TMenuItem;
    chk_HideNull: TCheckBox;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);
    procedure btn_RefreshBdlClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure cbb_XlCcChange(Sender: TObject);
    procedure btn_MoreClick(Sender: TObject);
    procedure DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure mni_N3Click(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
    aSf:string;
    sqlList:TStrings;
    procedure Open_Table;
  public
    { Public declarations }
  end;

implementation
uses uDM,uMain;
{$R *.dfm}

procedure TLqqkBrowse.btn_ExcelClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEH1);
end;

procedure TLqqkBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TLqqkBrowse.btn_MoreClick(Sender: TObject);
begin
  Main.act_Lq_lqqkCountExecute(Self);
end;

procedure TLqqkBrowse.btn_PrintClick(Sender: TObject);
begin
  PrintDBGridEH(DBGridEH1,Self,Self.Caption);
end;

procedure TLqqkBrowse.btn_RefreshBdlClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TLqqkBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TLqqkBrowse.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TLqqkBrowse.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept :=  ClientDataSet1.FieldByName('省份').AsString = aSf;
end;

procedure TLqqkBrowse.DBGridEH1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if (Column.FieldName='已录人数') or (Column.FieldName='计划总数') then
  begin
    if ClientDataSet1.FieldByName('已录人数').AsInteger<>ClientDataSet1.FieldByName('计划总数').AsInteger then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := $00D392C1;//$007D332D;//clMaroon;
      //Column.Font.Color := clWhite;
    end else
      Column.Font.Color := clBlack;
  end;

  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);

end;

procedure TLqqkBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TLqqkBrowse.FormCreate(Sender: TObject);
begin
  Self.Left := Trunc((Main.Width - Self.Width)/2);
  Self.Top := 30;//Trunc((Main.Height - Self.Height)/2);
  sqlList := TStringList.Create;
  dm.SetXlCcComboBox(cbb_XlCc,False);
  dm.SetLbComboBox(cbb_Lb,True);
  dm.SetSfComboBox(cbb_Sf,True);
  Open_Table;
end;

procedure TLqqkBrowse.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sqlList);
end;

procedure TLqqkBrowse.mni_N3Click(Sender: TObject);
begin
  //mni_N3.Checked := not mni_N3.Checked;
  //ClientDataSet1.Filtered := False;
  if mni_N3.Checked then
  begin
    cbb_Sf.Text := ClientDataSet1.FieldByName('省份').AsString;
    aSf := cbb_Sf.Text;
  end else
  begin
    cbb_Sf.Text := '全部';
    aSf := '';
  end;
  //ClientDataSet1.Filtered := mni_N3.Checked;
end;

procedure TLqqkBrowse.Open_Table;
var
  sqlstr,sWhere :string;
begin
  sWhere := ' where 学历层次='+quotedstr(cbb_XlCc.Text);
  if cbb_Lb.ItemIndex>0 then
    sWhere := sWhere+' and 类别='+quotedstr(cbb_Lb.Text);
  if cbb_Sf.Text<>'全部' then
    sWhere := sWhere+' and 省份='+quotedstr(cbb_Sf.Text);

  if chk_HideNull.Checked then
    sWhere := sWhere+' and 已录人数 is not null';
  
  sqlstr := 'SELECT * FROM 录取信息分析表'+sWhere+' order by 学历层次,省份,类别';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

end.
