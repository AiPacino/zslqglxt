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
    GetCursorPos(mPoint); //�õ����λ��
    pm1.Popup(mPoint.X, mPoint.Y); //����popupmenu1�Ĳ˵�
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
  sqlstr := 'select * from �������ű� where ��ʼ����='+quotedstr(FormatDateTime('yyyy-mm-dd',dt))+
//            ' and ��������<='+quotedstr(FormatDateTime('yyyy-mm-dd',dt))+
            ' and ��� is not null order by ʡ��,����,���� desc';
  cds_Work.XMLData := dm.OpenData(sqlstr);
  if IsToday(curDate) then
     dtstr := '�����졿'
  else if IsSameDay(curDate,Tomorrow) then
     dtstr := '�����졿'
  else if IsSameDay(curDate,Yesterday) then
     dtstr := '�����졿'
  else
     dtstr := FormatDateTime('yyyy��mm��dd��',dt);

  Self.Caption := dtstr+'�����ճ̰���';

  lbl_Today.Caption := FormatDateTime('������yyyy��mm��dd��',now);
  sHtml := '';
  sHtml := '<div style="font-size:12px;color:#F00"><b>��ʡ�а�¼ȡʱ�䰲�ţ�</b></div><p>'+#13;
  sHtml := sHtml+'<div style="font-size:12px">';
  while not cds_Work.Eof do
  begin
    if sf<>cds_Work.FieldByName('ʡ��').AsString then
    begin
      sf := cds_Work.FieldByName('ʡ��').AsString;
      sHtml := sHtml+'<div style="color:#F00"><b>��'+sf+'��</b></div>';
    end;
    sHtml := sHtml+'������'+cds_Work.FieldByName('���').AsString+'��&nbsp;';

    sHtml := sHtml+cds_Work.FieldByName('��ʼ����').AsString+'~'+cds_Work.FieldByName('��������').AsString+'&nbsp;';
    sHtml := sHtml+cds_Work.FieldByName('����').AsString;//+'&nbsp;|&nbsp;';

    //sHtml := sHtml+cds_Work.FieldByName('����').AsString+'<br>';
{
    if cds_Work.FieldByName('��ϵ��ʽ').AsString<>'' then
      sHtml := sHtml+'&nbsp;&nbsp;&nbsp;&nbsp;'+'��ϵ��ʽ��'+cds_Work.FieldByName('��ϵ��ʽ').AsString+'<br>'+#13;
    if cds_Work.FieldByName('��ע').AsString<>'' then
      sHtml := sHtml+'&nbsp;&nbsp;&nbsp;&nbsp;'+'��ע��'+cds_Work.FieldByName('��ע').AsString+'<br>'+#13;
}
    if sf<>cds_Work.FieldByName('ʡ��').AsString then
      sHtml := sHtml+'<p>';
    cds_Work.Next;
  end;
  sHtml := sHtml+'</div>';
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
  sqlstr := 'select * from ¼��Ա������־�� where ����ʱ��='+quotedstr(FormatDateTime('yyyy-mm-dd',dt))+
            ' order by ����Ա';
  cds_Work.XMLData := dm.OpenData(sqlstr);
  sHtml := sHtml+'<p><div style="font-size:12px;color:#F00"><b>¼��Ա������־��</b></div>'+#13;
  sHtml := sHtml+'<div style="font-size:12px">';
  while not cds_Work.Eof do
  begin
    if sf<>cds_Work.FieldByName('����Ա').AsString then
    begin
      sf := cds_Work.FieldByName('����Ա').AsString;
      sHtml := sHtml+'<div style="color:#F00"><b>��'+sf+'��</b></div>';
    end;
    sHtml := sHtml+'����'+cds_Work.FieldByName('����').AsString;
    if sf<>cds_Work.FieldByName('����Ա').AsString then
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
