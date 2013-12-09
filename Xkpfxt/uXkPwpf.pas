unit uXkPwpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IniFiles,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, RzBorder, DBCtrls, Mask,uDownloadDataOperate,
  DBGridEhGrouping, GridsEh, DBGridEh, OleServer, SunVote_TLB, RzPanel, RzStatus,
  viArrow;

type
  TXkPwpf = class(TForm)
    pnl_right: TPanel;
    pnl1: TPanel;
    led_Time: TRzLEDDisplay;
    lbl1: TLabel;
    pnl2: TPanel;
    bvl2: TBevel;
    pnl3: TPanel;
    cds_pf: TClientDataSet;
    ds_Pf: TDataSource;
    cds_stu: TClientDataSet;
    ds_stu: TDataSource;
    cds_stuId: TAutoIncField;
    cds_stuStringField: TStringField;
    cds_stuStringField2: TStringField;
    cds_stuStringField3: TStringField;
    cds_stuStringField4: TStringField;
    cds_stuStringField5: TStringField;
    cds_stuStringField6: TStringField;
    cds_stuStringField7: TStringField;
    cds_stuStringField8: TStringField;
    cds_stuStringField9: TStringField;
    cds_stuStringField10: TStringField;
    cds_stuDateTimeField: TDateTimeField;
    cds_stuDateTimeField2: TDateTimeField;
    cds_stuFloatField: TFloatField;
    cds_stuStringField11: TStringField;
    cds_stuStringField12: TStringField;
    cds_stuStringField13: TStringField;
    cds_stuStringField14: TStringField;
    grp1: TGroupBox;
    lbl2: TLabel;
    dbedt1: TDBText;
    lbl3: TLabel;
    dbedt2: TDBText;
    lbl4: TLabel;
    dbedt3: TDBText;
    lbl5: TLabel;
    dbedt4: TDBText;
    lbl6: TLabel;
    dbedt5: TDBText;
    lbl7: TLabel;
    dbedt6: TDBText;
    lbl8: TLabel;
    dbedt7: TDBText;
    lbl9: TLabel;
    dbedt8: TDBText;
    lbl10: TLabel;
    dbedt9: TDBText;
    lbl11: TLabel;
    lbl12: TLabel;
    dbedt11: TDBText;
    dbmmo1: TDBText;
    tmr1: TTimer;
    lbl13: TLabel;
    dbedt_Rch: TLabel;
    pnl_cj: TPanel;
    lbl_Rch: TLabel;
    pnl_Bottom: TPanel;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    pnl4: TPanel;
    RzStatusPane2: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    pnl6: TPanel;
    Panel1: TPanel;
    DBGridEh2: TDBGridEh;
    Panel2: TPanel;
    MultipleAssess: TMultipleAssess;
    ScoreRuleExplain: TScoreRuleExplain;
    btn_2: TBitBtn;
    btn_3: TBitBtn;
    btn_4: TBitBtn;
    btn_5: TBitBtn;
    btn_1: TBitBtn;
    btn_goBack: TBitBtn;
    lbl_zy: TLabel;
    viArrow1: TviArrow;
    viArrowEx1: TviArrowEx;
    viArrowEx2: TviArrowEx;
    viArrowEx3: TviArrowEx;
    viArrowEx4: TviArrowEx;
    procedure tmr1Timer(Sender: TObject);
    procedure btn_3Click(Sender: TObject);
    procedure btn_2Click(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure btn_5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure MultipleAssessDataDownload(ASender: TObject; KeyID,
      DownloadStatus: Integer; const DownloadInfo: WideString);
    procedure MultipleAssessKeyStatus(ASender: TObject;
      const BaseTag: WideString; KeyID, CommitOK: Integer;
      const KeyValue: WideString);
    procedure ScoreRuleExplainDataDownload(ASender: TObject; KeyID,
      DownloadStatus: Integer; const DownloadInfo: WideString);
    procedure btn_goBackClick(Sender: TObject);
    procedure btn_4Click(Sender: TObject);
  private
    { Private declarations }
    aKsh,aRch:string;
    lDownloadSuccessKeyIDs, lDownloadErrorKeyIDs: string;
    aYx,aSf,aKd,aZy,sqlWhere:string;
    LabelList:Array of TLabel;
    procedure InitKeySet;
    procedure CreateLabelList;
    procedure InitLabelList;
    procedure InitDownLoadKeyTable;
    function  DownloadKeyTable:Boolean;
    procedure DestroyLabelList;
    function  OpenStuTable:string;
    procedure OpenPfTable(const ksh:string);
    procedure CreateKsCjTable;
    function  GetRch:string;
    function  KsPfRecordIsExists(const ksh:string):Boolean; //���ּ�¼�Ƿ����
    function  AllPwIsPosted:Boolean; //������ί�Ƿ����ύ
    procedure DeleteKscj(const ksh:string);
    procedure savecj;
    procedure ShowKmcj;
    procedure InitMultipleAccess;
    function  DownLoadKeyData(const KeyIDs,fileType:string;out ErrorKeyIDs:string):Boolean;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy:string);
    procedure UpdateKeyCjTable(const KeyId:Integer;const cj1,cj2:string;const IsPosted:Boolean);
  end;

var
  XkPwpf: TXkPwpf;

implementation
uses uDM, uXkPwQd,PublicVariable,uInputKsBox;
{$R *.dfm}

function InputKsInfoBox(const DefaultValue:string=''):string;
begin
  Result := '';
  with TInputKsBox.Create(nil) do
  begin
    edt_Value.Text := DefaultValue;
    edt_Value.SelStart := Length(DefaultValue);
    edt_Value.SelLength := 0;
    if ShowModal=mrOk then
      Result := edt_Value.Text;
    Free;
  end;
end;

procedure TXkPwpf.btn_4Click(Sender: TObject);
begin
  led_Time.Enabled := False;
  btn_4.Enabled := False;
  btn_5.Enabled := True;
  btn_goBack.Enabled := True;
  Speak('��ʱ������');
  Speak('��'+aRch+'���ſ��������˳���');
end;

function TXkPwpf.AllPwIsPosted: Boolean;
begin
  Result := True;
  cds_pf.First;
  while not cds_pf.Eof do
  begin
    if cds_pf.FieldByName('�ύʱ��').IsNull then
    begin
      Result := False;
      Exit;
    end;
    cds_pf.Next
  end;
end;

procedure TXkPwpf.btn_1Click(Sender: TObject);
//var
//  keyids,errorkeyids:string;
begin
  //keyids := '3,4';
  //dm.DownLoadKeyData(KeyIds,MsgItemInfo,ErrorKeyIds);
  //dm.DownLoadKeyData(KeyIds,MsgMultipleAssess,ErrorKeyIds);
  //Exit;

  with TXkPwqd.Create(nil) do
  begin
    SetParam(ayx,asf,akd,azy);
    if ShowModal=mrOk then
    begin
      DM.FillKsKmList(aYx,aZy);
      if DownloadKeyTable then
      begin
        btn_1.Enabled := False;
        btn_2.Enabled := True;
        cds_pf.Close;
      end;
    end;
  end;
  InitLabelList;

end;

procedure TXkPwpf.btn_2Click(Sender: TObject);
var
  ksh,sqlstr,swhere,yx,sf,kd,zy,pw,pfq,km:string;
begin
  try
    ksh := OpenStuTable;
    if ksh='' then Exit; //����������
    aKsh := ksh;

    if KsPfRecordIsExists(ksh) then
    begin
      if Application.MessageBox('���棡�ÿ��������ּ�¼�Ѵ��ڣ�Ҫ�Ըÿ�������������',
        'ϵͳ��ʾ', MB_YESNO + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST) <> IDYES then
      begin
        Exit;
      end
      else
      begin
        if UpperCase(InputBox('����ȷ��','�����롾OK��ȷ�ϣ�',''))='OK' then
          DeleteKscj(ksh)
        else
          Exit;
      end;
    end;

    aRch := GetRch;
    dbedt_Rch.Caption := aRch;
    Speak('��'+aRch+'���ſ�������׼���볡��');

    sqlstr := 'update У���ֳ����ֱ� set ������='+quotedstr(aKsh)+',������='+quotedstr(aRch)+
              ',��Ŀ1=null,��Ŀ2=null,�ύʱ��=null';
    dm.ExecSql(sqlstr);

    lbl_Rch.Caption := '���ڶ��볡��Ϊ��'+aRch+'���Ŀ����������֣�';
    OpenPfTable(aKsh);

    Speak('��'+aRch+'���ſ��������볡��');
    btn_3.Enabled := True;
    //ShowKmcj;
  finally
  end;
end;

procedure TXkPwpf.btn_3Click(Sender: TObject);
var
  state:string;
begin
  InitMultipleAccess;
  MultipleAssess.StartMode := 1; //������¿�ʼģʽ
  state := MultipleAssess.Start;
  if state<>'0' then
  begin
    Application.MessageBox('������Ӳ������ʧ�ܣ�', 'ϵͳ��ʾ', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
  end else
  begin
    tmr1.Tag := 0;
    tmr1.Enabled := True;
    btn_2.Enabled := False;
    btn_3.Enabled := False;
    btn_4.Enabled := True;
    btn_5.Enabled := False;
    Speak('��ʱ��ʼ��');
    //CreateKsCjTable;
  end;

end;

procedure TXkPwpf.btn_5Click(Sender: TObject);
begin
  CreateKsCjTable;
  MultipleAssess.Stop;
  //savecj;
  //ShowKmcj;
  tmr1.Enabled := False;
  btn_2.Enabled := True;
  btn_3.Enabled := False;
  btn_5.Enabled := False;
  btn_goBack.Enabled := False;
end;

procedure TXkPwpf.btn_goBackClick(Sender: TObject);
var
  state:string;
begin
  if Application.MessageBox('���Ҫ�ѳɼ�������ί�������޸�������',
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES
    then
  begin
    MultipleAssess.Stop;

    if Application.MessageBox('�ٴ�ȷ�ϣ����Ҫ�ѳɼ�������ί�������޸�������',
      'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES
      then
    begin
      //InitMultipleAccess;
      MultipleAssess.StartMode := 0; //����
    end else
      MultipleAssess.StartMode := 2; //�����ύ
    MultipleAssess.Start;
  end;

end;

procedure TXkPwpf.CreateKsCjTable;
var
  km,cjField,sqlstr:string;
  i: Integer;
begin
  //DeleteKscj(aksh);
  if DataSetNoSave(cds_pf) then
  begin
    if DM.UpdateData('������','select top 0 * from У���ֳ����ֱ�',cds_pf.Delta,False) then
      cds_pf.MergeChangeLog
    else
      Exit;
  end;
  
  for i := 0 to gb_KskmList.Count - 1 do
  begin
    km := gb_KskmList.ValueFromIndex[i];
    cjField := '��Ŀ'+gb_KskmList.Names[i];
    sqlstr := 'Insert into У����Ŀ�ɼ��� (�п�Ժϵ,ʡ��,��������,������,������,��ί,������,���Կ�Ŀ,�ɼ�,�ύʱ��) '+
              'select �п�Ժϵ,ʡ��,��������,������,������,��ί,������,'+quotedstr(km)+','+cjField+',�ύʱ��'+
              ' from У���ֳ����ֱ� order by ��ί';
    dm.ExecSql(sqlstr);
  end;
  Speak('����������ȷ�ϣ�');
  Speak('����һλ����׼����');
end;

procedure TXkPwpf.CreateLabelList;
var
  sqlstr:string;
  iCount:Integer;
begin
  sqlstr := 'select count(*) from У��������ί�� '+sqlWhere+' and רҵ='+quotedstr(aZy);
  iCount := dm.GetRecordCountBySql(sqlstr);
  if iCount<5 then
    iCount := 5;
  SetLength(LabelList,iCount);
  InitLabelList;
end;

procedure TXkPwpf.DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if (Column.FieldName = '��Ŀ1') or (Column.FieldName = '��Ŀ2')  then
  begin
    if cds_pf.FieldByName('�ύʱ��').IsNull then
      AFont.Color := clBlue
    else
      AFont.Color := clGray;
  end;

end;

procedure TXkPwpf.DeleteKscj(const ksh: string);
var
  sqlstr,sWhere :string;
begin
  swhere := sqlWhere+' and ������='+quotedstr(ksh);
  sqlstr := 'delete from У����Ŀ�ɼ��� '+swhere;
  dm.ExecSql(sqlstr);
end;

procedure TXkPwpf.DestroyLabelList;
var
  i: Integer;
begin
  for i := 0 to High(LabelList) do
    FreeAndNil(LabelList[i]);
end;

function TXkPwpf.DownLoadKeyData(const KeyIDs, fileType: string;
  out ErrorKeyIDs: string): Boolean;
var
  lDemoType: TSDKAppType;
  data: OleVariant;
  download: TDownloadOperate;
  s, State, FileName: String;
  sList:TStrings;
begin
  download := TDownloadOperate.Create;
  try
    // �ۺϲ���: satMultipleAssess // ���ֹ���˵��:  satScoreRuleExplain;
    lDemoType := satMultipleAssess; //�ۺϲ���

    //fileType := cbbSelectFile.Items[cbbSelectFile.ItemIndex];

    If (fileType = MsgItemInfo) Then
    Begin
      case lDemoType of
        satElection:
          FileName := 'ElectionItem.ini';
        satBatchVote:
          FileName := 'BatchVoteItem.ini';
        satBatchEvaluation:
          FileName := 'BatchEvaluationItem.ini';
        satBatchScore:
          FileName := 'BatchScoreItem.ini';
        satMultipleAssess:
          FileName := 'MultipleAssessItem.ini';
      end;
    End
    else
    begin
      If (fileType = MsgRandomItem) Then
        FileName := 'RandomItem.ini';

      If (fileType = MsgEvaluationRule) Then
        FileName := 'EvaluationRule.ini';

      If (fileType = MsgScoreRule) Then
        FileName := 'ScoreRule.ini';

      If (fileType = MsgMultipleAssess) Then
        FileName := 'MultipleAssessRule.ini';

      If (fileType = MsgSelfExercise) Then
        FileName := 'SelfExercise.ini';

      If (fileType = MsgFileDownload) Then
      begin
      //  btnDownloadFile.Text := FFileDownloadPath;
        exit;
      end;

      If (fileType = MsgAvoidItemsDownload) Then
        FileName := 'AvoidItem.ini';
    end;
    FileName := ExtractFilePath(ParamStr(0))+'DownloadData\'+FileName;

    if lDemoType<>satFileDownload then
      begin
        data := download.ConvertIniToArray2(FileName);//��ͳһתΪ��ά���������
      end;

    Case lDemoType Of
      satMultipleAssess: // �ۺϲ���
        Begin
          If (fileType = MsgItemInfo) Then
          Begin
            data := download.ConvertIniToArray(FileName);
            State := MultipleAssess.StartDownloadItemsName(keyIDs, data);
            s := 'MultipleAssess��Download Items state=' + State;
          End;
          If (fileType = MsgMultipleAssess) Then
          Begin
            State := MultipleAssess.StartDownloadAssessRules(keyIDs, data);
            s := 'MultipleAssess��Download AssessRules state=' + State;
          End;
          If (fileType = MsgScoreRule) Then
          Begin
            State := MultipleAssess.StartDownloadScoreRules(keyIDs, data);
            s := 'MultipleAssess��Download ScoreRules state=' + State;
          End;
          If (fileType = MsgEvaluationRule) Then
          Begin
            State := MultipleAssess.StartDownloadEvaluationRules(keyIDs, data);
            s := 'MultipleAssess��Download EvaluationRules state=' + State;
          End;
        End;
      satScoreRuleExplain: // ���ֹ���˵��
        begin
          sList := TStringList.Create;
          try
          sList.Add('�����ɼ� 0-25');
          sList.Add('ҵ������ 0-25');
          sList.Add('����ˮƽ 0-25');
          sList.Add('����̬�� 0-25');
          data := download.ConvertStrToArray(sList.Text);
          State := ScoreRuleExplain.StartDownload(keyIDs, data);
          s := 'ScoreRuleExplain��Download RandomItems state=' + State;
          finally
            sList.Free;
          end;
        end;

    Else
      Exit;
    End;

    If (State = '0') Then
      s := s + '  Start download success';
    If (State = '-1') Then
      s := s + '  Not set the baseConnection property';
    If (State = '-2') Then
      s := s + '  The keyIDs is invalid';
    If (State = '-3') Then
      s := s + '  The download data is invalid or out of range';
    //ShowMsg(s);
    Result := (State = '0');
  finally
    download.Free;
  end;
end;

function TXkPwpf.DownloadKeyTable: Boolean;
var
  cds_tmp:TClientDataSet;
  KeyIds,sqlstr,pw,ErrorKeyIds:string;
  i:integer;
begin
  InitDownLoadKeyTable;//��ʼ��������Ŀ���ñ�
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select ������,��ί from У���ֳ����ֱ� where ������ is not null order by ������';
    cds_tmp.XMLData := dm.OpenData(sqlstr);
    while not cds_tmp.Eof do
    begin
      KeyIds := KeyIds+cds_tmp.FieldByName('������').AsString+',';
      cds_tmp.Next;
    end;
    //keyids := '3,4';
    if KeyIds='' then Exit;
    if KeyIds[Length(KeyIds)]=',' then
      KeyIds := Copy(KeyIds,1,Length(KeyIds)-1);

    //Result := DownLoadKeyData(KeyIds,MsgItemInfo,ErrorKeyIds); //��������ָ�꣬
    Result := DownLoadKeyData(KeyIds,MsgMultipleAssess,ErrorKeyIds); // �ۺϲ������򣬼����ǵĿ��Կ�Ŀ

    if not Result then
    begin
      Application.MessageBox(PChar(ErrorKeyIds+'��������������Ŀ�����ֹ�������ʧ�ܣ�'),
        'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TXkPwpf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MultipleAssess.Stop;
  ScoreRuleExplain.StopDownload;
  Action := caFree;
end;

procedure TXkPwpf.FormCreate(Sender: TObject);
begin
  dm.KeypadManage1.ShowKeyInfo(0,1);  //0:���м��̣�1����ʾ������
  MultipleAssess.BaseConnection := dm.BaseConnection1.DefaultInterface;
  InitMultipleAccess;
  ScoreRuleExplain.BaseConnection := DM.BaseConnection1.DefaultInterface;
end;

procedure TXkPwpf.FormDestroy(Sender: TObject);
begin
  DestroyLabelList;
  InitKeySet;
end;

function TXkPwpf.GetRch: string;
var
  s,sqlstr,sWhere :string;
  cds_temp:TClientDataSet;
begin
  cds_temp := TClientDataSet.Create(nil);
  try
  swhere := ' where �п�Ժϵ='+quotedstr(ayx)+' and ʡ��='+quotedstr(aSf)+
            ' and ��������='+quotedstr(aKd);
  sqlstr := 'select max(������) from У����Ŀ�ɼ��� '+swhere;
  cds_temp.XMLData := DM.OpenData(sqlstr);
  s := cds_temp.Fields[0].AsString;
  Result := Format('%.3d',[StrToIntDef(s,0)+1]);
  finally
    cds_temp.Free;
  end;
end;

procedure TXkPwpf.InitDownLoadKeyTable;
var
  sqlstr,fn,FileName:string;
  myini1,myini2:TInifile;
  i:Integer;
begin
  FileName := 'MultipleAssessItem.ini';
  fn := ExtractFilePath(ParamStr(0))+'DownloadData\'+FileName;
  myini1 := TIniFile.Create(fn);
  try
    myini1.WriteInteger('Info','ItemNum',1);
    myini1.WriteString('Item1','Text','�÷�');
  finally
    myini1.Free;
  end;

  FileName := 'MultipleAssessRule.ini';
  fn := ExtractFilePath(ParamStr(0))+'DownloadData\'+FileName;
  myini2 := TIniFile.Create(fn);
  try
    myini2.WriteInteger('Info','ItemNum',gb_KskmList.Count);
    for i:= 0 to gb_KskmList.Count-1 do
    begin
      myini2.WriteString('Item'+gb_kskmList.Names[i],'Text',gb_KskmList.ValueFromIndex[i]);
    end;
  finally
    myini2.Free;
  end;

end;

procedure TXkPwpf.InitKeySet;
begin
  dm.ExecSql('update У���ֳ����ֱ� set ������=null ');
end;

procedure TXkPwpf.InitLabelList;
var
  cds_tmp:TClientDataSet;
  sqlstr,pw:string;
  i:integer;
begin
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select ������,��ί from У���ֳ����ֱ� order by ������';
    cds_tmp.XMLData := dm.OpenData(sqlstr);

    for i:=0 to High(LabelList) do
    begin
      LabelList[i] := TLabel.Create(nil);
      LabelList[i].Parent := self.pnl_Bottom;
      LabelList[i].AutoSize := False;
      LabelList[i].Font.Color := clWhite;
      LabelList[i].Width := 64;
      LabelList[i].Height := 50;
      LabelList[i].Top := 8;
      LabelList[i].Left := 10+i*(LabelList[i].Width+5);
      LabelList[i].Transparent := False;
      LabelList[i].Alignment := taCenter;
      LabelList[i].Caption := Format('%.4d',[i+1])+#10+'δǩ��';
      LabelList[i].Color := clMaroon;

      if cds_tmp.Locate('������',i+1,[]) then
      begin
        if not cds_tmp.FieldByName('������').IsNull then
        begin
          LabelList[i].Color := clBlue;
          pw := cds_tmp.FieldByName('��ί').AsString;
          LabelList[i].Caption := Format('%.4d',[i+1])+#10+pw;
        end;
      end;
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TXkPwpf.InitMultipleAccess;
begin
  MultipleAssess.BaseConnection := dm.BaseConnection1.DefaultInterface;
  MultipleAssess.Mode := 0;
  MultipleAssess.DisplayFormat := 1;

  MultipleAssess.NumberBegin := 1;
  MultipleAssess.NumberEnd := 1;
  MultipleAssess.RuleBegin := 1;
  MultipleAssess.RuleEnd := 1;

  MultipleAssess.LessMode := 1; //��ѡģʽ
  MultipleAssess.EnterMove := 1;
  MultipleAssess.ColWidthFirst := 18;
  MultipleAssess.ColWidthOther := 8;
  MultipleAssess.StartMode := 1; //������¿�ʼģʽ

  MultipleAssess.SecrecyMode:=0;
  MultipleAssess.ModifyMode:=0;
  MultipleAssess.AvoidMode:=0;
end;

function TXkPwpf.KsPfRecordIsExists(const ksh:string): Boolean;
var
  sqlstr,sWhere :string;
begin
  swhere := sqlWhere+' and ������='+quotedstr(ksh);
  sqlstr := 'select count(*) from У����Ŀ�ɼ��� '+swhere;
  Result := dm.RecordIsExists(sqlstr);
end;

procedure TXkPwpf.MultipleAssessDataDownload(ASender: TObject; KeyID,
  DownloadStatus: Integer; const DownloadInfo: WideString);
var
  lDownloadSuccessKeyIDs, lDownloadErrorKeyIDs: string;
Begin
  If (KeyID = 0) And (DownloadStatus = 0) Then
  Begin
    lDownloadSuccessKeyIDs := MultipleAssess.DownloadSuccessKeyIDs;
    lDownloadErrorKeyIDs := MultipleAssess.DownloadErrorKeyIDs;
  End;
  //ShowDownInfo('MultipleAssess', KeyID, DownloadStatus, DownloadInfo,
  //  lDownloadSuccessKeyIDs, lDownloadErrorKeyIDs);
end;

procedure TXkPwpf.MultipleAssessKeyStatus(ASender: TObject;
  const BaseTag: WideString; KeyID, CommitOK: Integer;
  const KeyValue: WideString);
var
  s,cj1,cj2:string;
  i,ii:Integer;
  time:TDateTime;
begin
  //KeyValue //1_1=89,2_1=56.5
  s := KeyValue;
  i := Pos('1_1=',s);
  ii := Pos(',',s);
  if i>0 then
  begin
    if ii=0 then ii:=10;
      cj1 := Copy(s,i+4,ii-5);
  end;

  i := Pos('1_2=',s);
  ii := Pos(',',s);
  if i>0 then
  begin
    if ii=0 then ii:=10;
      cj2 := Copy(s,i+4,ii-5);
  end;

  cds_pf.DisableControls;
  DBGridEh2.SaveBookmark;
  try
    if cds_pf.Locate('������',KeyID,[]) then
    begin
      if cj1<>'' then
      begin
        cds_pf.Edit;
        cds_pf.FieldByName('��Ŀ1').Value := StrToFloatDef(cj1,0.00);
        cds_pf.Post;
      end;
      if cj2<>'' then
      begin
        cds_pf.Edit;
        cds_pf.FieldByName('��Ŀ2').Value := StrToFloatDef(cj2,0.00);
        cds_pf.Post;
      end;
      if CommitOK=1 then
      begin
        time := now;
        cds_pf.Edit;
        cds_pf.FieldByName('�ύʱ��').AsDateTime := time;
        cds_pf.Post;

        if AllPwIsPosted then
        begin
          btn_4.Enabled := True;
          btn_4.OnClick(Self);
          tmr1.Enabled := False;
          btn_5.Enabled := True;
        end;
      end;
    end;
    //UpdateKeyCjTable(KeyID,cj1,cj2,CommitOK=1);
  finally
    cds_pf.EnableControls;
    DBGridEh2.RestoreBookmark;
  end;
end;

procedure TXkPwpf.OpenPfTable(const ksh:string);
var
  sqlstr,sWhere :string;
  i: Integer;
begin
  sqlstr := 'select * from У���ֳ����ֱ� where ������='+quotedstr(ksh)+' order by ��ί,������';
  cds_pf.XMLData := DM.OpenData(sqlstr);
  for i := 0 to gb_KskmList.Count - 1 do
    DBGridEh2.FieldColumns['��Ŀ'+gb_KsKmlist.Names[i]].Title.Caption := gb_KskmList.ValueFromIndex[i]+'�÷�';
end;

function TXkPwpf.OpenStuTable:string;
var
  ksh,sqlstr:string;
begin
  while True do
  begin
    ksh:=InputKsInfoBox(ksh);
    if ksh='' then Exit;

    sqlstr := 'select * from view_У����������רҵ�� where ��������='+quotedstr(aKd)+
                                               ' and רҵ='+quotedstr(aZy)+
                                               ' and (������='+quotedstr(ksh)+
                                               ' or ���֤��='+quotedstr(ksh)+
                                               ' or ׼��֤��='+quotedstr(ksh)+')';
    cds_stu.XMLData := dm.OpenData(sqlstr);
    if cds_stu.RecordCount=0 then
    begin
      Application.MessageBox('������Ϣ�����ڣ�������������룡  ', 'ϵͳ��ʾ',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end else
    begin
      Result := cds_stu.FieldByName('������').AsString;
      Exit;
    end;
  end;
end;

procedure TXkPwpf.savecj;
begin
end;

procedure TXkPwpf.ScoreRuleExplainDataDownload(ASender: TObject; KeyID,
  DownloadStatus: Integer; const DownloadInfo: WideString);
var
  lDownloadSuccessKeyIDs, lDownloadErrorKeyIDs: string;
Begin
  If (KeyID = 0) And (DownloadStatus = 0) Then
  Begin
    lDownloadSuccessKeyIDs := ScoreRuleExplain.DownloadSuccessKeyIDs;
    lDownloadErrorKeyIDs := ScoreRuleExplain.DownloadErrorKeyIDs;
  End;
  //ShowDownInfo('ScoreRuleExplain', KeyID, DownloadStatus, DownloadInfo,
  //  lDownloadSuccessKeyIDs, lDownloadErrorKeyIDs);
end;

procedure TXkPwpf.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  sqlWhere := ' where �п�Ժϵ='+quotedstr(aYx)+
              ' and ʡ��='+quotedstr(aSf)+
              ' and ��������='+quotedstr(aKd);
              //' and רҵ='+quotedstr(aZy);

  lbl_zy.Caption := '���ڽ��С�'+zy+'��רҵ����';
  InitKeySet;
  CreateLabelList;
end;

procedure TXkPwpf.ShowKmcj;
var
  sqlstr,km,cj :string;
  cds_tmp:TClientDataSet;
begin
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'SELECT ���Կ�Ŀ,avg(�ɼ�) as �ɼ� FROM У����Ŀ�ɼ���'+sqlWhere+
              ' and ������='+quotedstr(aRch)+' group by ���Կ�Ŀ';
    cds_tmp.XMLData := dm.OpenData(sqlstr);
    //lbl_Cj.Caption := '';
    while not cds_tmp.eof do
    begin
      km := cds_tmp.Fields[0].AsString;
      cj := Format('%.2f',[cds_tmp.Fields[1].AsFloat]);
      //lbl_Cj.Caption := lbl_Cj.Caption+km+#13+cj+#13+#13;
      cds_tmp.Next;
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TXkPwpf.tmr1Timer(Sender: TObject);
var
  lt:integer;
begin
  led_Time.Tag := led_Time.Tag+1;
  lt := led_Time.Tag;
  led_Time.Caption := Format('%-.2d:%-.2d',[lt div 60,lt mod 60]);
end;

procedure TXkPwpf.UpdateKeyCjTable(const KeyId: Integer; const cj1, cj2: string;
  const IsPosted: Boolean);
var
  postTime:string;
  sqlstr,kskm:string;
begin
  if not IsPosted then
    postTime := 'null'
  else
    postTime := 'getdate()';

  if cj1<>'' then
  begin
    kskm := gb_KskmList.Values['1'];
    sqlstr := 'update У����Ŀ�ɼ��� set �ɼ�='+cj1+sqlWhere+' and ������='+quotedstr(aKsh)+
              ' and ���Կ�Ŀ='+quotedstr(kskm)+' and ������='+IntToStr(KeyId);
    DM.ExecSql(sqlstr);
  end;
  if cj2<>'' then
  begin
    kskm := gb_KskmList.Values['2'];
    sqlstr := 'update У����Ŀ�ɼ��� set �ɼ�='+cj2+sqlWhere+' and ������='+quotedstr(aKsh)+
              ' and ���Կ�Ŀ='+quotedstr(kskm)+' and ������='+IntToStr(KeyId);
    DM.ExecSql(sqlstr);
  end;

  if not IsPosted then
    postTime := 'null'
  else
    postTime := 'getdate()';
  sqlstr := 'update У����Ŀ�ɼ��� set �ύʱ��='+postTime+sqlWhere+
            ' and ������='+quotedstr(aKsh)+' and ������='+IntToStr(KeyId);
  DM.ExecSql(sqlstr);

  if IsPosted then //�ж���ί�Ƿ�ȫ���ύ
  begin
    sqlstr := 'select count(*) from У����Ŀ�ɼ��� '+sqlwhere+' and ������='+quotedstr(aKsh);
    btn_5.Enabled := DM.GetRecordCountBySql(sqlstr)=0;
  end;
end;

end.
