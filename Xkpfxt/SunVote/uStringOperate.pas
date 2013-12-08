
Unit uStringOperate;

Interface
Uses Classes, SysUtils, StrUtils,Math;

Const
  gcAvailSign = '√';
  //分隔符+转义符，可以使用任何非转义符作分隔符
  gcTrope = '\'; //转义符
  gcSplitNum = ','; //数字单独分隔符

  gcSplit1 = '|'; //分隔符1
  gcSplit2 = '/'; //分隔符2
  gcSplit3 = '<'; //分隔符3
  gcSplit4 = '>'; //分隔符4

Type
  TArrayInt = Array Of Integer; //自定义整数数组
  TAryStr = Array Of String; //自定义字符数组


Function GetNumbers(sNumbers: String; iMin: Integer = 1; iMax: Integer = 9999;
  sSplit: String = ','; sConnect: String = '-'): TArrayInt;

Function JoinL(sAry: TAryStr; Const Delimiter: String = ','): String; overload;
Function SplitL(Var sAry: TAryStr; Const S: String; Const Delimiter: String = ','): Integer; overload;

Function JoinL(SL: TstringList; Const Delimiter: String = ','): String; overload;
Function SplitL(Const S: String; Delimiter: String ): TstringList; overload;

Function JoinEx(SL: TstringList; Delimiter: String = '|'): String;
Function SplitEx(sSource: String; Delimiter: String = '|'): TstringList;

Function StrLeft(sStr: String; iLength: integer): String;
Function StrRight(sStr: String; iLength: integer): String;

Function StrMid(sStr: String; iBegin: integer; iLength: integer): String; overload;
Function StrMid(sStr: String; iBegin: integer): String; overload;
Procedure StrMid(Var sStr: String; iBegin: integer; iLength: integer; sReplace: String); overload;
Function StrReplace(Const sStr, OldPattern, NewPattern: String): String; //字符替换

Function StrToIntEx(Const S: String): Integer; //字符串转整数 空字串为0
Function StrToByte(Const S: String): byte; //字符串转字节

Function StrToFromUnicode(sStr: String): TArrayInt; //字符串转区位码
Function TrimZTBCD(sBCD: String): String; //恢复中天BCD码的值

Function StrToLetters(sStr: String; LetterType: Integer = 1): String; //字符串转字母

Function GetStr(StrSource, StrBegin, StrEnd: String): String; //取字符串
Function GetStrMidEnd(Var StrSource: String; StrBegin, StrEnd: String): String; //取字符串，并从结束位取值

Function GetAlignString(Value: String; MaxLength: Integer;
  Align: TAlignment; LeftSpace: Boolean = True): String; //取对齐字串（补空格）

Function GetFormatDataTime(DataTime:TDateTime): String; //取格式日期时间(YYYY-MM-DD  HH:MM:SS)
Function GetStringLines(AText:string): Integer; //取文本的行数

Function GetFormatFloat(Value:Double;Digits: Integer): String; //格式化小数显示

Function GetLimitString(AValue: string; MaxLen: Integer; AnsiString:Boolean=True):string; //取限制的最大长度

Implementation

//*********************************************************************　　　　　　　　　　　　　　　　　　　　　　　　　　　
//  功能说明：字符串转字节
//  参数说明：S：字符串
//  函数返回值说明：字节
//*********************************************************************

Function StrToByte(Const S: String): byte;
Var
  i: Integer;
Begin
  Try
    If s = '' Then
      Result := 0
    Else
      Begin
        i := StrToIntEx(s);
        If i > 255 Then
          Result := 255
        Else If i < 0 Then
          Result := 0
        Else
          Result := i;
      End;
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.StrToByte ' + e.Message);
      End;
  End;
End;

//*********************************************************************　　　　　　　　　　　　　　　　　　　　　　　　　　　
//  功能说明：字符串转整数 空字串为0  StrToInt空字串报错
//  参数说明：S：字符串
//  函数返回值说明：整数
//*********************************************************************

Function StrToIntEx(Const S: String): Integer;
Begin
  If s = '' Then
    Result := 0
  Else
    Result := StrToInt(s);
End;
//*********************************************************************　　　　　　　　　　　　　　　　　　　　　　　　　　　
//  功能说明：字符串转数组(1,2-3=1,2,3)
//  参数说明：sNumbers：字符串; iMin:最小值; iMax:最大值; sSplit:分隔符; sConnect:连接符
//  函数返回值说明：整数数组
//*********************************************************************

Function GetNumbers(sNumbers: String; iMin: Integer = 1; iMax: Integer = 9999;
  sSplit: String = ','; sConnect: String = '-'): TArrayInt;
Var
  i, j, nSpl, nCon, ii, v, v1, v2, iLen: Integer;
  s, s1, s2: String;
  aryHas: Array Of Integer;
  b1, b2: Boolean;
Begin
  Try
    If iMin < 1 Then
      iMin := 1;
    If iMax > 9999 Then
      iMax := 9999;

    SetLength(aryHas, iMax + 1);

    nSpl := length(sSplit);
    nCon := Length(sConnect);
    i := 1;
    iLen := 0;

    While True Do
      Begin
        j := PosEx(sSplit, sNumbers, i); //分隔符

        If (j > 0) Then
          s := Trim(Copy(sNumbers, i, j - i))
        Else
          s := Trim(Copy(sNumbers, i, Length(sNumbers)));

        ii := Pos(sConnect, s); //连接符
        If ii > 0 Then //有连接符
          Begin
            s1 := Copy(s, 1, ii - 1);
            s2 := Copy(s, ii + nCon, Length(s));
            b1 := TryStrToInt(s1, v1);
            b2 := TryStrToInt(s2, v2);
            If b1 And b2 Then
              Begin
                If (v1 > v2) Then
                  Begin
                    v := v1;
                    v1 := v2;
                    v2 := v;
                  End
              End
            Else If b1 Then
              v2 := v1
            Else If b2 Then
              v1 := v2
            Else
              Begin
                v1 := 0;
                v2 := 0;
              End;
          End
        Else //无连接符，单数
          Begin
            If Not TryStrToInt(s, v1) Then
              v1 := 0;
            v2 := v1;
          End;

        If v1 < iMin Then
          v1 := iMin;
        If v2 > iMax Then
          v2 := iMax;
        For v := v1 To v2 Do
          Begin
            If aryHas[v] = 0 Then
              Begin
                aryHas[v] := 1;
                iLen := iLen + 1;
              End;
          End;

        If j < 1 Then
          Break;

        i := j + nSpl;

      End;

    //返回数组
    SetLength(Result, iLen);
    i := 0;
    For v := iMin To iMax Do
      Begin
        If aryHas[v] = 1 Then
          Begin
            Result[i] := v;
            i := i + 1;
          End;
      End;
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.GetNumbers ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能：字符列表转数组([1..3]=1,2,3)
// 参数说明： SL：字符列表; Delimiter:连接符
// 作者: yb 时间 09.08.14
//*****************************************************************************

Function JoinL(SL: TstringList; Const Delimiter: String = ','): String; Overload;
Var
  i: Longint;
Begin
  Try
    result := '';
    For i := 0 To SL.count - 1 Do
      Begin
        If i > 0 Then
          result := result + Delimiter;
        result := result + SL.Strings[i];
      End;
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.JoinL ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能：字符串转数组(1,2,3=[1..3])
// 参数说明： S：字符串; Delimiter:连接符
// 作者: yb 时间 09.08.14
//*****************************************************************************

Function SplitL(Const S: String; Delimiter: String ): TstringList; Overload;
Var
  i, j, n: Longint;
Begin
  Try
    result := TStringList.Create;
    if s='' then exit;

    n := length(Delimiter);
    i := 1;
    j := Pos(Delimiter, S);

    While j > 0 Do
      Begin
        result.Add(Copy(S, i, j - i));
        i := j + n;
        j := PosEx(Delimiter, S, i);
      End;
    result.Add(Copy(S, i, Length(S)));

    //result.Strings[result.Count-1] := Copy(S,i,Length(S));//新的TStrings对象会自动加回车换行

    //if result.Strings[result.Count-1] <> Copy(S,i,Length(S)) then
      //result.Strings[result.Count-1] := Copy(S,i,Length(S));
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.SplitL ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能：合并字段，采用双写分隔符和内部转义替换，以保证任何字符合并后都能还原分解
// 参数说明： SL：字符列表; Delimiter:连接符
// 作者: yb 09.08.14
//       xx 10.05.24 修改Sl2赋值
//*****************************************************************************

Function JoinEx(SL: TstringList; Delimiter: String = '|'): String;
Var
  i: Longint;
  SL2: TstringList;
  sTrp, sRep, sSpl: String;
Begin
  Try
    SL2 := TStringList.Create;
    SL2.Assign(SL); //复制SL xx 2010-05-24
    //    SL2.Text := SL.Text; //新的TStrings对象前面会自动加回车#$D

    Case SL2.Count Of
      0:
        exit;
      1:
        Begin
          result := SL2.Strings[0];
          exit;
        End;
    End;

    If Delimiter = '\' Then
      sTrp := '/'
    Else
      sTrp := '\';

    sRep := Delimiter + sTrp;
    sSpl := Delimiter + Delimiter;

    For i := 0 To SL2.Count - 1 Do
      SL2.Strings[i] := StringReplace(SL2.Strings[i], Delimiter, sRep, [rfReplaceAll]);

    result := JoinL(SL2, sSpl);

    SL2.Free;
  Except
    On e: exception Do
      Begin
        result := '';
        Raise Exception.Create('StringOperate.JoinEx ' + e.Message);
      End;
  End;
End;
//*****************************************************************************
// 功能：分解字段，采用双写分隔符和内部转义替换，以保证任何字符合并后都能还原分解
// 参数说明： sSource：字符串; Delimiter:连接符 ; Result:字符列表
// 作者: yb 时间 09.08.14
//*****************************************************************************

Function SplitEx(sSource: String; Delimiter: String = '|'): TstringList;
Var
  i: Longint;
  sTrp, sRep, sSpl: String;
Begin
  Try
    If length(sSource) < 1 Then
      Begin
        result := TStringList.Create;
        Exit;
      End;

    If Delimiter = '\' Then
      sTrp := '/'
    Else
      sTrp := '\';

    sRep := Delimiter + sTrp;
    sSpl := Delimiter + Delimiter;

    result := SplitL(sSource, sSpl);

    //result.Strings[result.Count-1] := copy(result.Strings[result.Count-1],1,length(result.Strings[result.Count-1])-2);

    For i := 0 To result.Count - 1 Do
      result.Strings[i] := StringReplace(result.Strings[i], sRep, Delimiter, [rfReplaceAll]);
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.SplitEx ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能：从左边算起指定数量的字符
// 参数说明： sStr：字符串; iLength:长度 ; Result: 取字符
// 作者: xx 时间 09.08.18
//*****************************************************************************

Function StrLeft(sStr: String; iLength: integer): String;
Begin
  result := copy(sStr, 1, iLength);
End;

//*****************************************************************************
// 功能：从右边算起指定数量的字符
// 参数说明： sStr：字符串; iLength:长度 ; Result: 取字符
// 作者: xx 时间 09.08.18
//*****************************************************************************

Function StrRight(sStr: String; iLength: integer): String;
Begin
  result := Copy(sStr, Length(sStr) - iLength + 1, iLength);
End;

//*****************************************************************************
// 功能：从指定位置算起指定数量的字符
// 参数说明： sStr：字符串; iBegin:开始位置；iLength:长度
//           可选参数；要返回的字符数。如果省略或 length 超过文本的字符数
//　　　　（包括 start 处的字符），将返回字符串中从 start 到尾端的所有字符
// 作者: xx 时间 09.08.18
// StrMid('1中2' ,2,3)='中2' 汉字算2个字符，不能单取
//*****************************************************************************

Function StrMid(sStr: String; iBegin: integer): String;
Var
  lLen: Integer;
Begin
  Try
    lLen := Length(sStr);
    result := Copy(sStr, iBegin, lLen - iBegin + 1);
  Except
    On e: exception Do
      Begin
        result := '';
        Raise Exception.Create('StringOperate.StrMid ' + e.Message);
      End;
  End;
End;

Function StrMid(sStr: String; iBegin: integer; iLength: integer): String;
Var
  lLen: Integer;
Begin
  Try
    lLen := Length(sStr) - iBegin + 1;
    If iLength > lLen Then
      iLength := lLen;

    result := Copy(sStr, iBegin, iLength);
  Except
    On e: exception Do
      Begin
        result := '';
        Raise Exception.Create('StringOperate.StrMid ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能：从指定位置算起指定数量的字符 ，替换成指定字符
// 参数说明： sStr：字符串; iLength:长度 ; Result: 取字符
// 作者: xx 时间 09.08.18
//*****************************************************************************

Procedure StrMid(Var sStr: String; iBegin: integer; iLength: integer; sReplace: String);
Var
  s1, s2: String;
Begin
  Try
    If iLength < 1 Then
      exit;

    s1 := StrLeft(sstr, iBegin - 1);
    s2 := StrRight(sStr, Length(sStr) - iLength - iBegin + 1);
    sStr := s1 + sReplace + s2;
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.StrMid ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能：字符替换
// 参数说明： sStr：字符串; iLength:长度 ; Result: 取字符
// 作者: xx 时间 09.08.18
//*****************************************************************************

Function StrReplace(Const sStr, OldPattern, NewPattern: String): String;
Begin
  result := StringReplace(sStr, OldPattern, NewPattern, [rfReplaceAll]);
End;

//*****************************************************************************
// 功能说明：字符串转区位码
//          类似VB的 StrConv(sChar, vbFromUnicode)。
// 参数说明：sStr: 字符串
// 函数返回值说明：区位码(借用TArrayInt整数数组表示字节数组）
//中国1=214,208,185,250,49
//*****************************************************************************

Function StrToFromUnicode(sStr: String): TArrayInt;
Var
  i, lLen: integer;
Begin
  Try
    lLen := Length(sStr);
    SetLength(Result, lLen);

    For i := 1 To lLen Do
      Begin
        Result[i - 1] := StrToInt('$' + IntToHex(Ord(sStr[i]), 2));
      End;
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.StrToFromUnicode ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能说明：字符串转字母
// 参数说明：sStr: 字符串  LetterType: 0小写 1大写　
// 函数返回值说明：字母    12340=ABCDJ
//*****************************************************************************

Function StrToLetters(sStr: String; LetterType: Integer = 1): String;
Var
  i: Integer;
  lS: String;
Begin
  Try
    lS := '';
    If LetterType = 1 Then
      LetterType := 64 //A=65
    Else
      LetterType := 96; //a=97

    For i := 1 To Length(sStr) Do
      Begin

        Case sStr[i] Of
          '1'..'9':
            lS := lS + Char(LetterType + StrToInt(sStr[i]));

          '0':
            lS := lS + Char(LetterType + 10);

        Else
        End;
      End;
    Result := lS;
  Except
    On e: exception Do
      Begin
        Result := '';
        Raise Exception.Create('StringOperate.StrToLetters ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能说明：恢复中天BCD码的值
// 参数说明：sBCD: 字符串
// 函数返回值说明：替换后的BCD码
//123E4=123.4
//*****************************************************************************

Function TrimZTBCD(sBCD: String): String;
Var
  i: Integer;
Begin
  Try
    For i := 1 To Length(sBCD) Do
      Begin
        Case sBCD[i] Of
          'A':
            StrMid(sBCD, i, 1, '*');

          'B':
            StrMid(sBCD, i, 1, '#');
          'C':
            StrMid(sBCD, i, 1, '-');
          'E':
            StrMid(sBCD, i, 1, '.');
          'F':
            Begin
              Result := StrLeft(sBCD, i - 1);
              Exit;
            End;
        Else
        End;
      End;

    Result := sBCD;
  Except
    On e: exception Do
      Begin
        Result := '';
        Raise Exception.Create('StringOperate.TrimZTBCD ' + e.Message);
      End;
  End;
End;

 


//*****************************************************************************
// 功能说明：取字符串
// 参数说明：StrSource: 源字符串；StrBegin:开始;StrEnd：结束
// 函数返回值说明：取到的字符串
//*****************************************************************************

Function GetStr(StrSource, StrBegin, StrEnd: String): String;
Var
  in_star, in_end: integer;
Begin
  in_star := AnsiPos(strbegin, strsource) + length(strbegin);
  in_end := AnsiPos(strend, strsource);
  result := copy(strsource, in_star, in_end - in_star);
End;

//*****************************************************************************
// 功能说明：取字符串，并从结束位取值
// 参数说明：StrSource: 源字符串；StrBegin:开始;StrEnd：结束
// 函数返回值说明：取到的字符串，并且源字符串从结束位+1开始重新取值
//*****************************************************************************

Function GetStrMidEnd(Var StrSource: String; StrBegin, StrEnd: String): String;
Var
  in_star, in_end: integer;
Begin
  in_star := AnsiPos(strbegin, strsource) + length(strbegin);
  in_end := AnsiPos(strend, strsource);
  result := copy(strsource, in_star, in_end - in_star);
  StrSource := StrMid(StrSource, in_end + Length(strend));
End;

//*****************************************************************************
// 功能说明：取对齐字串（补空格,对非汉字字体空格显示宽度不对!）
// 参数说明：Value: 源字符串；MaxLength:最大长度(字节)：
//           Align:对齐方式; LeftSpace:居中方式补空格位置  True左补空格、False右补空格
// 函数返回值说明： 对齐后的字串
//*****************************************************************************

Function GetAlignString(Value: String; MaxLength: Integer;
  Align: TAlignment; LeftSpace: Boolean = True): String;
Var
  lAddSpace, lSpace, lLen: Integer;

Begin
  lLen := Length(Value);
  If lLen >= MaxLength Then
    Begin
      Result := LeftStr(Value, MaxLength);
      Exit;
    End;

  Case Align Of
    taLeftJustify:
      Result := Value + StringOfChar(#32, MaxLength - lLen);

    taRightJustify:
      Result := StringOfChar(#32, MaxLength - lLen) + Value;

    taCenter:
      Begin
        lSpace := MaxLength - lLen;
        lAddSpace := lSpace Div 2;

        Result := StringOfChar(#32, lAddSpace) + Value + StringOfChar(#32, lAddSpace);

        If lSpace Mod 2 = 1 Then //奇数 补充1个
          Begin
            If LeftSpace Then
              Result := StringOfChar(#32, 1) + Result
            Else
              Result := Result + StringOfChar(#32, 1);
          End;
      End;
  End;
End;

//*****************************************************************************
// 功能说明：数组转字符列表([1..3]=1,2,3)
// 参数说明：sAry：字符数组; Delimiter:连接符
// 函数返回值说明：字符列表
//*****************************************************************************

Function JoinL(sAry: TAryStr; Const Delimiter: String = ','): String; Overload;
Var
  i: Integer;
Begin
  Try
    result := '';
    For i := 0 To High(sAry) Do
      Begin
        If i > 0 Then
          result := result + Delimiter;
        result := result + sAry[i];
      End;
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.JoinL ' + e.Message);
      End;
  End;

End;

//*****************************************************************************
// 功能说明：字符列表转数组([1..3]=1,2,3)
// 参数说明：sAry：返回字符数组; s:字符列表; Delimiter:连接符
// 函数返回值说明： 0失败、>0成功 直接返回数组长度
//*****************************************************************************

Function SplitL(Var sAry: TAryStr; Const S: String; Const Delimiter: String = ','): Integer; Overload;
Var
  i, j, n, lCnt: Integer;
Begin
  Try

    lCnt := 0;

    n := length(Delimiter);
    i := 1;
    j := Pos(Delimiter, S);

    While j > 0 Do
      Begin
        SetLength(sAry, lCnt + 1);
        sAry[lCnt] := Copy(S, i, j - i);
        lCnt := lCnt + 1;
        i := j + n;
        j := PosEx(Delimiter, S, i);
      End;

    SetLength(sAry, lCnt + 1);
    sAry[lCnt] := Copy(S, i, Length(S));

    Result := Length(sAry);

    //result.Strings[result.Count-1] := Copy(S,i,Length(S));//新的TStrings对象会自动加回车换行

    //if result.Strings[result.Count-1] <> Copy(S,i,Length(S)) then
      //result.Strings[result.Count-1] := Copy(S,i,Length(S));
  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.SplitL ' + e.Message);
      End;
  End;
End;

//*****************************************************************************
// 功能说明：取格式日期时间(
// 参数说明：DataTime：日期时间
// 函数返回值说明：'YYYY-MM-DD  HH:MM:SS' 长度为20，可代替数据库的DataTime字段
//*****************************************************************************
Function GetFormatDataTime(DataTime:TDateTime): String;
begin
  Result:= FormatDateTime('YYYY-MM-DD  HH:MM:SS', DataTime);
end;

//*****************************************************************************
// 功能说明：取文本的行数
// 参数说明：文本
// 函数返回值说明：行数
{Windows系统里面，每行结尾是“<换行><回车>”，即“\n\r”；
Unix系统里，每行结尾只有“<换行>”，即“\n”；
Mac系统里，每行结尾是“<回车>”。一个直接后果是，
Unix/Mac系统下的文件在Windows里打开的话，所有文字会变成一行；
而Windows里的文件在Unix/Mac下打开的话，在每行的结尾可能会多出一个^M符号。}
//*****************************************************************************
Function GetStringLines(AText:string): Integer;
begin
  Result:=Length(AText)-length(StringReplace(AText, #10, '', [rfReplaceAll])) + 1;
end;


//*****************************************************************************
// 功能说明：格式化小数显示
// 参数说明：Value：数值，Digits:小数位
// 函数返回值说明：
{SimpleRoundTo(1234567, 3) 1234000
SimpleRoundTo(1.234, -2) 1.23
SimpleRoundTo(1.235, -2) 1.24
SimpleRoundTo(-1.235, -2) -1.23}
//*****************************************************************************
Function GetFormatFloat(Value:Double;Digits: Integer): String;
var
  lFormat:string;
  lValue:Double;
begin
  if Value=0 then
    begin
      Result:='0';
      Exit;
    end;

  if Digits<0 then
    Digits:=0;

  if Digits>0 then
    lFormat := '.' + StringOfChar(#48, Digits); //.00

  lValue:=SimpleRoundTo(Value,0-Digits);  //需引用Math

  if Digits>0 then
    begin
      Result:=FormatFloat(lFormat, lValue);
      if lValue<1 then //.12
        Result:='0' + Result;
    end

  else
    Result:=FloatToStr(lValue);

end;

//*********************************************************************　　　　　　　　　　　　　　　　　　　　　　　　　　　
//  功能说明：限制最大长度输入
//  参数说明：AValue：源字符; MaxLen:最大长度  AnsiString(汉字算两个)
//  函数返回值说明：字节
//*********************************************************************
Function GetLimitString(AValue: string; MaxLen: Integer; AnsiString:Boolean=True):string;
begin
  if AValue='' then
    Exit;

  if MaxLen<1 then
    Exit;

  try
    if AnsiString then
      begin
        if Length(AValue)>MaxLen then
          Result:= AnsiLeftStr(AValue,MaxLen)
        else
          Result:= AValue;
      end
    else
      begin
        if Length(WideString(AValue))>MaxLen then
          Result:=LeftStr(AValue,MaxLen)
        else
          Result:= AValue;
      end;

  Except
    On e: exception Do
      Begin
        Raise Exception.Create('StringOperate.GetLimitString ' + e.Message);
      End;
  End;

end;

End.


