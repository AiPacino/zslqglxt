<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="Connections/conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����Ƽ�ʦ��ѧԺ2011��У���ɼ���ѯ���</title>
</head>
<%
dim path
'----��д�ı��ļ����ݺ���
function ReadCount
	dim fs,file_names,index_s,out
	Set fs = CreateObject("Scripting.FileSystemObject")
	Set file_names = fs.OpenTextFile(server.mappath("counter.txt"))
	index_s=file_names.readline
	file_names.close
	set fs=nothing
	ReadCount = index_s
end function
%>
<body background="background.gif">
    <div align="center">
      <font color="red" size="3" face="������">�����Ƽ�ʦ��ѧԺ2011��У��רҵ�ɼ���ѯ</font>
</div>
    <p>
<table width="632" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0066FF">
  <tr>
    <td width="630" height="59" align="left" bgcolor="#FFFFFF"><font size="2" face="����"><br>	
    </font><form name="form1" method="post" action="display_lqmd.asp">
      <div align="center">
        <font color="36669E" size="2" face="����"><strong>�����ţ�</strong></font> 
          <font size="2" face="����">
            <input name="ksh" type="text" id="ksh">
          </font><br>
		  <font color="36669E" size="2" face="����"><strong>�ա�����</strong></font> 
          <font size="2" face="����">
            <input name="xm" type="text" id="xm">
          </font>
        <br><font size="2" face="����">����������
            <input type="submit" name="Submit" value="�顡ѯ">��
          <input type="reset" name="Submit2" value="�ء���">
            </font>
      </div>
    </form>

<p>
<font color="blue" size="2">��������ѯϵͳ�ɲ�ѯ��У����������У��רҵ�ɼ���</font><p>
	</td>
  </tr>
</table>
<p>
<hr>
<p>
<font color="red" size="2"><center>��ѯ�˴Σ�<%=ReadCount%>��</center></font>
<p>
<p>
</body>
</html>