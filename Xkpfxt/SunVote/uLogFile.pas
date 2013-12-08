{*********************************************************************
  创建日期  2010-1-18
  作者名    xx
  功能描述
      日志文件操作
  修改信息（修改人、修改原因、修改日期）
     初始创建文件时可生成多级目录 (xx、创建时可带文件夹、2010-2-24)
     增加判断日志文件存在 (xx、可能需要初始创建信息、2010-2-24)
*********************************************************************}

unit uLogFile;

interface
uses
  SysUtils,Forms,Classes;

Type
   TLogFile = Class

  Private
    FFileName:string;

  Public
    Constructor Create(FileName:string);
    Destructor Destroy; Override;

    Procedure WriteErrLog(Description,ClassFunctionName:string;AddLast:Boolean=False); //写出错日志
    Function FileExist: Boolean; //日志文件存在
  End;
implementation

Constructor TLogFile.Create(FileName:string);
var
  lDir:string;
Begin
  Inherited Create; // 如参数不一样,则这里的 Create 不能省略

  lDir:=ExtractFileDir(FileName);

  if lDir='' then //只有文件名(123.txt)
    begin
      lDir:=ExtractFilePath(Application.ExeName);
      FFileName:=lDir+FileName; //当前exe所在目录
    end
  else   //带路径
    begin
      if pos(':',lDir)>0 then //完整路径(D:\1\2\3.log)
        FFileName:=FileName
      else //不完整路径(1\2\3.log)
        begin
          lDir:=ExtractFilePath(Application.ExeName)+lDir;  //当前exe所在目录
          FFileName:=lDir+'\'+ExtractFileName(FileName);
        end;

      if not DirectoryExists(lDir) then
        begin
          ForceDirectories(lDir);//多级文件夹 CreateDir(lDir);一级
        end;
    end;

End;

Destructor TLogFile.Destroy;
Begin
  //inherited Destroy;
  Inherited; //省略就是继承同名方法
end;

//*********************************************************************　　　　　　　　　　　　　　　　　　　　　　　　　　　
//  功能说明：日志文件存在
//  参数说明：
//  函数返回值说明：True 存在，False不存在
//**********************************************************************
function TLogFile.FileExist: Boolean;
begin
  if FileExists(FFileName) then
    Result:=True
  else
    Result:=False
end;

//系统所有操作日志记录，包括基本系统操作，系统错误信息等等。日志信息保存在安装程序的log文件下，保存日志信息格式以.log文件结尾，内容为：
//操作日期：日期格式：yyyy-mm-dd hh:mm:ss:sss；
//操作模块：如：用户模块；
//操作动作：如：添加，修改用户；
//操作参数：操作过程中传递的参数值；
//备注：其他备注信息；

//*********************************************************************　　　　　　　　　　　　　　　　　　　　　　　　　　　
//  功能说明：写出错日志
//  参数说明：Description:描述
//            ClassFunctionName:类名函数名
//            AddLast:True 添加到未行、False=添加到首行
//              10000行后添加单行速度都快0-0.016s，连续写多行速度相差很大(未行速度快)
//  函数返回值说明：
//**********************************************************************
procedure TLogFile.WriteErrLog(Description,ClassFunctionName:string;AddLast:Boolean=False);
var
  lTime:string;
  lLog:string;
  lSpace:string;
  lTextFile: TextFile;
  lStrLit:TStringList;
  lOpenFile,lAppend:Boolean;

begin
  try
    lTime:=FormatDateTime('yyyy-mm-dd hh:nn:ss:zzz',now);
    lSpace:='  ';
    lLog:=lTime + lSpace + Description + lSpace +ClassFunctionName;

    lOpenFile:=False;
    if FileExists(FFileName) then
      lAppend:=True
    else
      begin
        AssignFile(lTextFile,FFileName);
        Rewrite(lTextFile);         //文件不存在则创建
        lAppend:=False;
        lOpenFile:=True;
      end;

    if AddLast then
      begin
        if lAppend then
          begin
            AssignFile(lTextFile,FFileName);
            Append(lTextFile);
          end;

        WriteLn(lTextFile,lLog);  //这种方式1000行 =0.7秒 几乎不受文件大小影响
        CloseFile(lTextFile);
      end
    else
      begin
        if lOpenFile then
          CloseFile(lTextFile);

        //空时，这种方式1000行 =1.6秒
        //已有6000条时，这种方式1000行 =8.4秒
        lStrLit:=TStringList.Create; //已有6000条时，这种方式1000行 =14秒 受文件大小影响大
        lStrLit.loadfromfile(FFileName);
        lStrLit.insert(0,lLog);
        lStrLit.savetofile(FFileName);
        lStrLit.Free;
      end;
  except on E: Exception do
    RaiseLastOSError;
  end;


end;

end.
