<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="Connections/conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>2011�꽭���Ƽ�ʦ��ѧԺУ���ɼ���ѯ���</title>
</head>
<%
dim path
'----��д�ı��ļ����ݺ���
function UpdateCount
	dim fs,file_names,index_s,out
	Set fs = CreateObject("Scripting.FileSystemObject")
	Set file_names = fs.OpenTextFile(server.mappath("counter.txt"))
	index_s=file_names.readline
	index_s=index_s+1
	file_names.close
	
	Set out=fs.CreateTextFile(server.mappath("counter.txt"))
	out.WriteLine(index_s)
	out.close
	set fs=nothing
end function
%>
<body background="background.gif">
<%
	on error resume next
	dim mycon,sqlstr,rec,ksh,xm,sMsg,v_sf,v_ksh,v_xm,v_xb,v_zymc,v_ms,v_yy,v_fz,v_wd

	ksh = Trim(request.form("ksh"))
	xm = Trim(request.form("xm"))
    if (ksh="") or (xm="") then
%>
	<script language="javascript">alert("�����ź���������Ϊ�գ�");</script>
	<meta http-equiv="refresh" content="0; url=index.asp" />
<%
      'response.redirect("index.asp")
	  response.End()
    end if

    'response.write MM_conn_STRING & ksh & "," & xm
    'response.end()
    set mycon = Server.CreateObject("adodb.connection")
    mycon.Open MM_conn_STRING

    sqlstr = "SELECT ������,ʡ��,����,�Ա�,������,��װ����,������,�赸��  FROM ���ճɼ� WHERE ������='"&ksh&"' and ����='"&xm&"'"
    'response.write sqlstr
    'response.end

    set rec = mycon.Execute(sqlstr)

if rec.bof and rec.eof then
	sMsg="�Բ���δ�ܲ�ѯ���ÿ�����У���ɼ���Ϣ���������ʿɲ���绰0791-3812427��3831320������ѯ��"
	v_sf = "&nbsp;/"
	v_ksh = "&nbsp;/"
	v_xm = "&nbsp;/"
	v_xb = "&nbsp;/"
	v_ms = "&nbsp;/"
	v_fz = "&nbsp;/"
	v_yy = "&nbsp;/"
	v_wd = "&nbsp;/"
else
	v_sf = trim(rec("ʡ��"))
	v_ksh = rec("������")
	v_xm = rec("����")
	v_xb = rec("�Ա�")
	v_ms = rec("������")
	v_fz = rec("��װ����")
	v_yy = rec("������")
	v_wd = rec("�赸��")
	sMsg = v_xm & "ͬѧ������У��רҵ�ɼ����£�"
	if v_ms<>"" then v_zymc="������"
	if v_yy<>"" then v_zymc=v_zymc&"���֣�"
	if v_fz<>"" then v_zymc=v_zymc&"��װ���ݣ�"
	if v_wd<>"" then v_zymc=v_zymc&"�赸��"
	v_zymc = mid(v_zymc,1,Len(v_zymc)-1)
 End If
  '���²�ѯ�˴�,���뱣֤���ݿ����ڵ��ļ����п�дȨ�ޣ���Ŀ¼����ΪUesers�ɶ���д�����ˡ�
  call UpdateCount
  rec.close()
  set rec=Nothing
%>
<div align="center"><font color="#FF0000" size="3" face="����">��ѯ�����</font></div>
<p>
<table width="492" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#0000FF">
  <tr height="35">
	<td height="62" colspan="2" bgcolor="#FFFFFF"><font color="#FF0000" size="2">����<%=sMsg%></font></td>
  </tr>
  <tr>
  	<td width="104" height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">ʡ�ݣ�</font></div></td> 
    <td width="365" height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_sf%></font></td>
  </tr>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">�����ţ�</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_ksh%></font></td>
  </tr>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">������</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_xm%></font></td>
  </tr>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">�Ա�</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_xb%></font></td>
  </tr>  
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">����רҵ��</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_zymc%></font></td>
  </tr>  
<%if v_ms<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">�����ɼ���</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_ms%></font></td>
    </tr>
<%end if%>    
<%if v_yy<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">���ֳɼ���</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_yy%></font></td>
    </tr>
<%end if%>    
<%if v_fz<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">��װ���ݳɼ���</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_fz%></font></td>
    </tr>
<%end if%>    
<%if v_wd<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">�赸�ɼ���</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_wd%></font></td>
    </tr>
<%end if%>    
  <tr height="35">
	<td height="62" colspan="2" valign="middle" bgcolor="#FFFFFF"><font size="2">����<font color="#FF0000"><strong>ע��</strong></font><font color="#000000"><strong>�������ʿɲ���绰0791-3812427��3831320������ѯ����</strong></font></font></td>
  </tr>
</table>

<p align="center">
<a href="index.asp"><font size="2">������</font></a> 
</body>
</html>