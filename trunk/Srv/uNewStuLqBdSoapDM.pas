Unit uNewStuLqBdSoapDM;

interface

uses SysUtils, Classes, InvokeRegistry, Midas, SOAPMidas, SOAPDm, Dialogs,
  frxClass, frxDBSet, frxDesgn, DBClient, Provider, ADODB, TConnect, DB,
  VCLUnZip, VCLZip, EncdDecdEx;

type
  INewStuLqBdSoapDM = interface(IAppServerSOAP)
    ['{F4E89F68-92B3-4CED-9EDC-805AB43BEBE7}']
  end;

  TNewStuLqBdSoapDM = class(TSoapDataModule, INewStuLqBdSoapDM, IAppServerSOAP, IAppServer)
    qry_Update: TADOQuery;
    qry_Access: TADOQuery;
    qry_AccessDSDesigner: TWideStringField;
    qry_AccessDSDesigner2: TWideStringField;
    qry_AccessDSDesigner3: TWideStringField;
    qry_AccessWideStringField4: TWideStringField;
    qry_AccessDSDesigner4: TWideStringField;
    qry_AccessWideStringField5: TWideStringField;
    qry_AccessDSDesigner5: TWideStringField;
    qry_AccessDSDesigner26: TWideStringField;
    qry_AccessDSDesigner6: TWideStringField;
    qry_AccessDSDesigner7: TWideStringField;
    qry_AccessDSDesigner8: TWideStringField;
    qry_AccessDSDesigner9: TWideStringField;
    qry_AccessDSDesigner10: TWideStringField;
    qry_AccessDSDesigner11: TWideStringField;
    qry_AccessDSDesigner12: TWideStringField;
    qry_AccessDSDesigner13: TWideStringField;
    qry_AccessDSDesigner14: TFloatField;
    qry_AccessDSDesigner15: TWideStringField;
    qry_AccessDSDesigner16: TWideStringField;
    qry_AccessDSDesigner17: TWideStringField;
    qry_AccessDSDesigner18: TWideStringField;
    qry_AccessDSDesigner19: TWideStringField;
    qry_AccessDSDesigner20: TWideStringField;
    qry_AccessDSDesigner21: TWideStringField;
    qry_AccessDSDesigner22: TWideStringField;
    qry_AccessDSDesigner23: TWideStringField;
    qry_AccessAction_Time: TWideStringField;
    qry_AccessDSDesigner24: TWideStringField;
    qry_AccessDSDesigner25: TWideStringField;
    qry_AccessWideStringField: TWideStringField;
    qry_AccessWideStringField2: TWideStringField;
    qry_AccessBooleanField: TBooleanField;
    qry_AccessWideStringField3: TWideStringField;
    con_Access: TADOConnection;
    con_DBF: TADOConnection;
    qry_DBF: TADOQuery;
    con_Srv: TLocalConnection;
    qry_Temp: TADOQuery;
    DataSet_Query: TADODataSet;
    DSP_Query: TDataSetProvider;
    cds_Query: TClientDataSet;
    cds_Update: TClientDataSet;
    DSP_Update: TDataSetProvider;
    DataSet_Update: TADODataSet;
    DataSet_Temp: TADODataSet;
    frxDesigner1: TfrxDesigner;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    dlgSave_1: TSaveDialog;
    VCLZip1: TVCLZip;
    VCLUnZip1: TVCLUnZip;
    cds_Temp: TClientDataSet;
    DSP_Temp: TDataSetProvider;
    sp_GetJhNo: TADOStoredProc;
    sp_UpdateLqInfo: TADOStoredProc;
    sp_GetLqztsNo: TADOStoredProc;
    procedure SoapDataModuleCreate(Sender: TObject);
    procedure SoapDataModuleDestroy(Sender: TObject);
    procedure DSP_UpdateUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure DataSet_UpdatePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
  
  public
    function Query_Data(const SqlText: string; var sData: string):Integer;
    function Update_Data(const pkField,SqlText: string; const sData: string; var sError:string):Boolean;
    function RecordIsExists(const sSqlStr:string):Boolean;
    function ExecSqlCmd(const sSqlStr:string):Boolean;overload;
    function ExecSqlCmd(const sSqlStr:string;var sError:string):Boolean;overload;

    function GetAdjustJHNo:string;
    function GetLqtzsNo(const ksh:string):string;
    function UpdateLqInfo(const sXlCc:string):Boolean;
  end;

implementation
uses uDbConnect,uNewStuLqBdIntf;
{$R *.DFM}

procedure TNewStuLqBdDMCreateInstance(out obj: TObject);
begin
 obj := TNewStuLqBdSoapDM.Create(nil);
end;

{ TNewStuLqBdDM }

function TNewStuLqBdSoapDM.ExecSqlCmd(const sSqlStr: string): Boolean;
var
  sError:string;
begin
  Result := ExecSqlCmd(sSqlStr,sError);
end;

procedure TNewStuLqBdSoapDM.DataSet_UpdatePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Exception.Create(e.Message);
end;

procedure TNewStuLqBdSoapDM.DSP_UpdateUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  raise E;
end;

function TNewStuLqBdSoapDM.ExecSqlCmd(const sSqlStr: string;
  var sError: string): Boolean;
var
  adoqry:TADOQuery;
begin
  adoqry := TADOQuery.Create(nil);
  adoqry.Connection := con_Access;
  try
    try
      adoqry.SQL.Text := sSqlStr;
      adoqry.ExecSQL;
      Result := True;
    except
      on e:Exception do
      begin
        sError := e.Message;
        Result := False;
      end;
    end;
  finally
    FreeAndNil(adoqry);
  end;
end;

function TNewStuLqBdSoapDM.GetAdjustJHNo: string;
begin
  sp_GetJhNo.ExecProc;
  Result := sp_GetJhNo.Parameters.ParamByName('@res_No').Value;
end;

function TNewStuLqBdSoapDM.GetLqtzsNo(const ksh: string): string;
begin
  sp_GetLqztsNo.Parameters.ParamByName('@ksh').Value := ksh;
  sp_GetLqztsNo.ExecProc;
  Result := sp_GetLqztsNo.Parameters.ParamByName('@res_No').Value;
end;

function TNewStuLqBdSoapDM.Query_Data(const SqlText: string;
  var sData: string): Integer;
var
  sTempData:string;
begin
  try
    try
      cds_Query.Active := False;
      cds_Query.CommandText := SqlText;
      cds_Query.Active := True;
      sData := cds_Query.XMLData;

      if gb_Use_Zip then
      begin
        sTempData := VCLZip1.ZLibCompressString(sData);
        sData := EncodeString(sTempData);
        //if Base64Encode(sTempData,sData) = BASE64_OK then
        //  Result := S_OK;
      end;
      Result := S_OK;
    except
      Result := S_FALSE;
      cds_Query.CommandText := '';
      cds_Query.Close;
    end;

  finally
    cds_Query.Active := False;
  end;
end;

function TNewStuLqBdSoapDM.RecordIsExists(const sSqlStr: string): Boolean;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_Access;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := sSqlStr;
    try
      DataSet_Temp.Open;
      Result := DataSet_Temp.Fields[0].AsInteger>0;
    except
      Result := False;
    end;
  finally
    DataSet_Temp.Close;
    DataSet_Temp.Free;
  end;
end;

procedure TNewStuLqBdSoapDM.SoapDataModuleCreate(Sender: TObject);
var
  vHost,vSa,vPwd,vDb,vMode:string;
begin
  con_Access.Connected := False;
  con_Access.ConnectionString := ReadConnInfo(vHost,vDb,vSa,vPwd,vMode);
  //ADOConnection1.Connected := True;
end;

procedure TNewStuLqBdSoapDM.SoapDataModuleDestroy(Sender: TObject);
begin
  con_Access.Connected := False;
end;

function TNewStuLqBdSoapDM.UpdateLqInfo(const sXlCc: string): Boolean;
begin
  sp_UpdateLqInfo.Parameters.ParamByName('@xlcc').Value := sXlCc;
  sp_UpdateLqInfo.ExecProc;
  Result := True;
end;

function TNewStuLqBdSoapDM.Update_Data(const pkField, SqlText, sData: string;
  var sError: string): Boolean;
var
  iErrorCount,i:Integer;
  sTempData:string;
begin
  Result := False;
  try
    DataSet_Update.Close;
    DataSet_Update.CommandText := SqlText;
    {
    DM.cds_Update.Active := False;
    DM.cds_Update.CommandText := SqlText;
    dm.cds_Update.Active := True;
    }
    if gb_Use_Zip then
    begin
      //Base64Decode(sData,sTempData);
      sTempData := DecodeString(sData);
      sTempData := VCLUnZip1.ZLibDecompressString(sTempData);
    end else
      sTempData := sData;

    cds_Update.XMLData := sTempData;

    for i := 0 to cds_Update.FieldCount - 1 do
    begin
      //if UpperCase(dm.cds_Update.Fields[i].FieldName) = UpperCase(pkField) then
      //  dm.cds_Update.Fields[i].ProviderFlags := dm.cds_Update.Fields[i].ProviderFlags + [ pfInKey,pfInWhere ]
      //else
      //  dm.cds_Update.Fields[i].ProviderFlags := dm.cds_Update.Fields[i].ProviderFlags-[pfInWhere,pfInKey];

      if cds_Update.Fields[i].DataType in [ ftDate, ftTime, ftDateTime ] then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInWhere ]
      else if cds_Update.Fields[i].DataType = ftAutoInc then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInUpdate ];
    end;


    DataSet_Update.Open;
    with DataSet_Update.FieldByName(pkField) do //主键必须在AdoDataSet中设置，不能在ClientDataSet中设置
      ProviderFlags := ProviderFlags + [ pfInKey,pfInWhere ];

    try
      iErrorCount := cds_Update.ApplyUpdates(0);  
      Result := iErrorCount=0;
    except
      on e:Exception do
      begin
        sError := e.Message;
        Result := False;
      end;
    end;
  finally
    cds_Update.Active := False;
  end;
end;

initialization
   InvRegistry.RegisterInvokableClass(TNewStuLqBdSoapDM, TNewStuLqBdDMCreateInstance);
   InvRegistry.RegisterInterface(TypeInfo(INewStuLqBdSoapDM));
end.
