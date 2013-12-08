
Unit uStringOperate;

Interface
Uses Classes, SysUtils, StrUtils,Math;

Const
  gcAvailSign = '��';
  //�ָ���+ת���������ʹ���κη�ת������ָ���
  gcTrope = '\'; //ת���
  gcSplitNum = ','; //���ֵ����ָ���

  gcSplit1 = '|'; //�ָ���1
  gcSplit2 = '/'; //�ָ���2
  gcSplit3 = '<'; //�ָ���3
  gcSplit4 = '>'; //�ָ���4

Type
  TArrayInt = Array Of Integer; //�Զ�����������
  TAryStr = Array Of String; //�Զ����ַ�����


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
Function StrReplace(Const sStr, OldPattern, NewPattern: String): String; //�ַ��滻

Function StrToIntEx(Const S: String): Integer; //�ַ���ת���� ���ִ�Ϊ0
Function StrToByte(Const S: String): byte; //�ַ���ת�ֽ�

Function StrToFromUnicode(sStr: String): TArrayInt; //�ַ���ת��λ��
Function TrimZTBCD(sBCD: String): String; //�ָ�����BCD���ֵ

Function StrToLetters(sStr: String; LetterType: Integer = 1): String; //�ַ���ת��ĸ

Function GetStr(StrSource, StrBegin, StrEnd: String): String; //ȡ�ַ���
Function GetStrMidEnd(Var StrSource: String; StrBegin, StrEnd: String): String; //ȡ�ַ��������ӽ���λȡֵ

Function GetAlignString(Value: String; MaxLength: Integer;
  Align: TAlignment; LeftSpace: Boolean = True): String; //ȡ�����ִ������ո�

Function GetFormatDataTime(DataTime:TDateTime): String; //ȡ��ʽ����ʱ��(YYYY-MM-DD  HH:MM:SS)
Function GetStringLines(AText:string): Integer; //ȡ�ı�������

Function GetFormatFloat(Value:Double;Digits: Integer): String; //��ʽ��С����ʾ

Function GetLimitString(AValue: string; MaxLen: Integer; AnsiString:Boolean=True):string; //ȡ���Ƶ���󳤶�

Implementation

//*********************************************************************������������������������������������������������������
//  ����˵�����ַ���ת�ֽ�
//  ����˵����S���ַ���
//  ��������ֵ˵�����ֽ�
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

//*********************************************************************������������������������������������������������������
//  ����˵�����ַ���ת���� ���ִ�Ϊ0  StrToInt���ִ�����
//  ����˵����S���ַ���
//  ��������ֵ˵��������
//*********************************************************************

Function StrToIntEx(Const S: String): Integer;
Begin
  If s = '' Then
    Result := 0
  Else
    Result := StrToInt(s);
End;
//*********************************************************************������������������������������������������������������
//  ����˵�����ַ���ת����(1,2-3=1,2,3)
//  ����˵����sNumbers���ַ���; iMin:��Сֵ; iMax:���ֵ; sSplit:�ָ���; sConnect:���ӷ�
//  ��������ֵ˵������������
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
        j := PosEx(sSplit, sNumbers, i); //�ָ���

        If (j > 0) Then
          s := Trim(Copy(sNumbers, i, j - i))
        Else
          s := Trim(Copy(sNumbers, i, Length(sNumbers)));

        ii := Pos(sConnect, s); //���ӷ�
        If ii > 0 Then //�����ӷ�
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
        Else //�����ӷ�������
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

    //��������
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
// ���ܣ��ַ��б�ת����([1..3]=1,2,3)
// ����˵���� SL���ַ��б�; Delimiter:���ӷ�
// ����: yb ʱ�� 09.08.14
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
// ���ܣ��ַ���ת����(1,2,3=[1..3])
// ����˵���� S���ַ���; Delimiter:���ӷ�
// ����: yb ʱ�� 09.08.14
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

    //result.Strings[result.Count-1] := Copy(S,i,Length(S));//�µ�TStrings������Զ��ӻس�����

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
// ���ܣ��ϲ��ֶΣ�����˫д�ָ������ڲ�ת���滻���Ա�֤�κ��ַ��ϲ����ܻ�ԭ�ֽ�
// ����˵���� SL���ַ��б�; Delimiter:���ӷ�
// ����: yb 09.08.14
//       xx 10.05.24 �޸�Sl2��ֵ
//*****************************************************************************

Function JoinEx(SL: TstringList; Delimiter: String = '|'): String;
Var
  i: Longint;
  SL2: TstringList;
  sTrp, sRep, sSpl: String;
Begin
  Try
    SL2 := TStringList.Create;
    SL2.Assign(SL); //����SL xx 2010-05-24
    //    SL2.Text := SL.Text; //�µ�TStrings����ǰ����Զ��ӻس�#$D

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
// ���ܣ��ֽ��ֶΣ�����˫д�ָ������ڲ�ת���滻���Ա�֤�κ��ַ��ϲ����ܻ�ԭ�ֽ�
// ����˵���� sSource���ַ���; Delimiter:���ӷ� ; Result:�ַ��б�
// ����: yb ʱ�� 09.08.14
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
// ���ܣ����������ָ���������ַ�
// ����˵���� sStr���ַ���; iLength:���� ; Result: ȡ�ַ�
// ����: xx ʱ�� 09.08.18
//*****************************************************************************

Function StrLeft(sStr: String; iLength: integer): String;
Begin
  result := copy(sStr, 1, iLength);
End;

//*****************************************************************************
// ���ܣ����ұ�����ָ���������ַ�
// ����˵���� sStr���ַ���; iLength:���� ; Result: ȡ�ַ�
// ����: xx ʱ�� 09.08.18
//*****************************************************************************

Function StrRight(sStr: String; iLength: integer): String;
Begin
  result := Copy(sStr, Length(sStr) - iLength + 1, iLength);
End;

//*****************************************************************************
// ���ܣ���ָ��λ������ָ���������ַ�
// ����˵���� sStr���ַ���; iBegin:��ʼλ�ã�iLength:����
//           ��ѡ������Ҫ���ص��ַ��������ʡ�Ի� length �����ı����ַ���
//�������������� start �����ַ������������ַ����д� start ��β�˵������ַ�
// ����: xx ʱ�� 09.08.18
// StrMid('1��2' ,2,3)='��2' ������2���ַ������ܵ�ȡ
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
// ���ܣ���ָ��λ������ָ���������ַ� ���滻��ָ���ַ�
// ����˵���� sStr���ַ���; iLength:���� ; Result: ȡ�ַ�
// ����: xx ʱ�� 09.08.18
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
// ���ܣ��ַ��滻
// ����˵���� sStr���ַ���; iLength:���� ; Result: ȡ�ַ�
// ����: xx ʱ�� 09.08.18
//*****************************************************************************

Function StrReplace(Const sStr, OldPattern, NewPattern: String): String;
Begin
  result := StringReplace(sStr, OldPattern, NewPattern, [rfReplaceAll]);
End;

//*****************************************************************************
// ����˵�����ַ���ת��λ��
//          ����VB�� StrConv(sChar, vbFromUnicode)��
// ����˵����sStr: �ַ���
// ��������ֵ˵������λ��(����TArrayInt���������ʾ�ֽ����飩
//�й�1=214,208,185,250,49
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
// ����˵�����ַ���ת��ĸ
// ����˵����sStr: �ַ���  LetterType: 0Сд 1��д��
// ��������ֵ˵������ĸ    12340=ABCDJ
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
// ����˵�����ָ�����BCD���ֵ
// ����˵����sBCD: �ַ���
// ��������ֵ˵�����滻���BCD��
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
// ����˵����ȡ�ַ���
// ����˵����StrSource: Դ�ַ�����StrBegin:��ʼ;StrEnd������
// ��������ֵ˵����ȡ�����ַ���
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
// ����˵����ȡ�ַ��������ӽ���λȡֵ
// ����˵����StrSource: Դ�ַ�����StrBegin:��ʼ;StrEnd������
// ��������ֵ˵����ȡ�����ַ���������Դ�ַ����ӽ���λ+1��ʼ����ȡֵ
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
// ����˵����ȡ�����ִ������ո�,�ԷǺ�������ո���ʾ��Ȳ���!��
// ����˵����Value: Դ�ַ�����MaxLength:��󳤶�(�ֽ�)��
//           Align:���뷽ʽ; LeftSpace:���з�ʽ���ո�λ��  True�󲹿ո�False�Ҳ��ո�
// ��������ֵ˵���� �������ִ�
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

        If lSpace Mod 2 = 1 Then //���� ����1��
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
// ����˵��������ת�ַ��б�([1..3]=1,2,3)
// ����˵����sAry���ַ�����; Delimiter:���ӷ�
// ��������ֵ˵�����ַ��б�
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
// ����˵�����ַ��б�ת����([1..3]=1,2,3)
// ����˵����sAry�������ַ�����; s:�ַ��б�; Delimiter:���ӷ�
// ��������ֵ˵���� 0ʧ�ܡ�>0�ɹ� ֱ�ӷ������鳤��
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

    //result.Strings[result.Count-1] := Copy(S,i,Length(S));//�µ�TStrings������Զ��ӻس�����

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
// ����˵����ȡ��ʽ����ʱ��(
// ����˵����DataTime������ʱ��
// ��������ֵ˵����'YYYY-MM-DD  HH:MM:SS' ����Ϊ20���ɴ������ݿ��DataTime�ֶ�
//*****************************************************************************
Function GetFormatDataTime(DataTime:TDateTime): String;
begin
  Result:= FormatDateTime('YYYY-MM-DD  HH:MM:SS', DataTime);
end;

//*****************************************************************************
// ����˵����ȡ�ı�������
// ����˵�����ı�
// ��������ֵ˵��������
{Windowsϵͳ���棬ÿ�н�β�ǡ�<����><�س�>��������\n\r����
Unixϵͳ�ÿ�н�βֻ�С�<����>��������\n����
Macϵͳ�ÿ�н�β�ǡ�<�س�>����һ��ֱ�Ӻ���ǣ�
Unix/Macϵͳ�µ��ļ���Windows��򿪵Ļ����������ֻ���һ�У�
��Windows����ļ���Unix/Mac�´򿪵Ļ�����ÿ�еĽ�β���ܻ���һ��^M���š�}
//*****************************************************************************
Function GetStringLines(AText:string): Integer;
begin
  Result:=Length(AText)-length(StringReplace(AText, #10, '', [rfReplaceAll])) + 1;
end;


//*****************************************************************************
// ����˵������ʽ��С����ʾ
// ����˵����Value����ֵ��Digits:С��λ
// ��������ֵ˵����
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

  lValue:=SimpleRoundTo(Value,0-Digits);  //������Math

  if Digits>0 then
    begin
      Result:=FormatFloat(lFormat, lValue);
      if lValue<1 then //.12
        Result:='0' + Result;
    end

  else
    Result:=FloatToStr(lValue);

end;

//*********************************************************************������������������������������������������������������
//  ����˵����������󳤶�����
//  ����˵����AValue��Դ�ַ�; MaxLen:��󳤶�  AnsiString(����������)
//  ��������ֵ˵�����ֽ�
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


