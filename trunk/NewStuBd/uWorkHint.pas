unit uWorkHint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,StrUtils,
  Dialogs, StdCtrls, DBCtrlsEh, Mask, Buttons, ExtCtrls, DB, DBClient, OleCtrls,
  SHDocVw, Menus, AppEvnts;

type
  TWorkHint = class(TForm)
    pnl1: TPanel;
    cds_Work: TClientDataSet;
    wb1: TWebBrowser;
    btn_Prev: TSpeedButton;
    btn_Next: TSpeedButton;
    chk_OnlyOne: TCheckBox;
    pm1: TPopupMenu;
    N1: TMenuItem;
    lbl_Today: TLabel;
    ApplicationEvents1: TApplicationEvents;
    pmi_Edit: TMenuItem;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_PrevClick(Sender: TObject);
    procedure btn_NextClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pm1Popup(Sender: TObject);
    procedure lbl_TodayClick(Sender: TObject);
  private
    { Private declarations }
    curDate:TDateTime;
    sHtml:string;
    procedure FillData(const dt:TDateTime);
  public
    { Public declarations }
  end;

implementation
uses uDM,mshtml,ActiveX,DateUtils,uMain;

{$R *.dfm}
procedure   WBLoadHTML(WebBrowser:   TWebBrowser;   HTMLCode:   string)   ;
var
  sl: TStringList;
  ms: TMemoryStream;
begin                            
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE   do
    Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0) ;
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TWorkHint.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  mPoint: TPoint;
begin
  if IsChild(wb1.Handle, Msg.hwnd) and
    ((Msg.Message = WM_RBUTTONDOWN) or (Msg.Message = WM_RBUTTONUP)) then
  begin
    GetCursorPos(mPoint); //得到光标位置
    pm1.Popup(mPoint.X, mPoint.Y); //弹出popupmenu1的菜单
    Handled := True;
  end;
end;

procedure TWorkHint.btn_CloseClick(Sender: TObject);
begin
  cds_Work.Cancel;
  Close;
end;

procedure TWorkHint.btn_NextClick(Sender: TObject);
begin
  curDate := curDate+1;
  FillData(curDate);
end;

procedure TWorkHint.btn_PrevClick(Sender: TObject);
begin
  curDate := curDate-1;
  FillData(curDate);
end;

procedure TWorkHint.FillData(const dt:TDateTime);
var
  sf,sqlstr,dtstr,msg:string;
begin
  sqlstr := 'select * from 工作安排表 where 开始日期='+quotedstr(FormatDateTime('yyyy-mm-dd',dt))+
//            ' and 结束日期<='+quotedstr(FormatDateTime('yyyy-mm-dd',dt))+
            ' and 层次 is not null order by 省份,批次,科类 desc';
  cds_Work.XMLData := dm.OpenData(sqlstr);
  if IsToday(curDate) then
     dtstr := '【今天】'
  else if IsSameDay(curDate,Tomorrow) then
     dtstr := '【明天】'
  else if IsSameDay(curDate,Yesterday) then
     dtstr := '【昨天】'
  else
     dtstr := FormatDateTime('yyyy年mm月dd日',dt);

  Self.Caption := dtstr+'工作日程安排';

  lbl_Today.Caption := FormatDateTime('今天是yyyy年mm月dd日',now);
  sHtml := '';
  sHtml := '<div style="font-size:12px;color:#F00"><b>各省招办录取时间安排：</b></div><p>'+#13;
  sHtml := sHtml+'<div style="font-size:12px">';
  while not cds_Work.Eof do
  begin
    if sf<>cds_Work.FieldByName('省份').AsString then
    begin
      sf := cds_Work.FieldByName('省份').AsString;
      sHtml := sHtml+'<div style="color:#F00"><b>【'+sf+'】</b></div>';
    end;
    sHtml := sHtml+'　　【'+cds_Work.FieldByName('层次').AsString+'】&nbsp;';

    sHtml := sHtml+cds_Work.FieldByName('开始日期').AsString+'~'+cds_Work.FieldByName('结束日期').AsString+'&nbsp;';
    sHtml := sHtml+cds_Work.FieldByName('批次').AsString;//+'&nbsp;|&nbsp;';

    //sHtml := sHtml+cds_Work.FieldByName('科类').AsString+'<br>';
{
    if cds_Work.FieldByName('联系方式').AsString<>'' then
      sHtml := sHtml+'&nbsp;&nbsp;&nbsp;&nbsp;'+'联系方式：'+cds_Work.FieldByName('联系方式').AsString+'<br>'+#13;
    if cds_Work.FieldByName('备注').AsString<>'' then
      sHtml := sHtml+'&nbsp;&nbsp;&nbsp;&nbsp;'+'备注：'+cds_Work.FieldByName('备注').AsString+'<br>'+#13;
}
    if sf<>cds_Work.FieldByName('省份').AsString then
      sHtml := sHtml+'<p>';
    cds_Work.Next;
  end;
  sHtml := sHtml+'</div>';
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
  sqlstr := 'select * from 录检员工作日志表 where 创建时间='+quotedstr(FormatDateTime('yyyy-mm-dd',dt))+
            ' order by 操作员';
  cds_Work.XMLData := dm.OpenData(sqlstr);
  sHtml := sHtml+'<p><div style="font-size:12px;color:#F00"><b>录检员工作日志：</b></div>'+#13;
  sHtml := sHtml+'<div style="font-size:12px">';
  while not cds_Work.Eof do
  begin
    if sf<>cds_Work.FieldByName('操作员').AsString then
    begin
      sf := cds_Work.FieldByName('操作员').AsString;
      sHtml := sHtml+'<div style="color:#F00"><b>【'+sf+'】</b></div>';
    end;
    sHtml := sHtml+'　　'+cds_Work.FieldByName('内容').AsString;
    if sf<>cds_Work.FieldByName('操作员').AsString then
      sHtml := sHtml+'<p>';
    cds_Work.Next;
  end;
  sHtml := sHtml+'</div>';

  WBLoadHTML(wb1,sHtml);
end;

procedure TWorkHint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caMinimize;
end;

procedure TWorkHint.FormCreate(Sender: TObject);
begin
  curDate := now;
  FillData(curDate);
  Self.Left := TForm(Self.Owner).ClientWidth-Self.Width-6;
  Self.Top := TForm(Self.Owner).ClientHeight-Self.Height-55;
end;

procedure TWorkHint.lbl_TodayClick(Sender: TObject);
begin
  curDate := now;
  FillData(curDate);
end;

procedure TWorkHint.N1Click(Sender: TObject);
begin
  curDate := Now;
  FillData(curDate);
end;

procedure TWorkHint.pm1Popup(Sender: TObject);
begin
  pmi_Edit.Visible := (StrToIntDef(gb_Czy_Level,3)<=2);
end;

end.
