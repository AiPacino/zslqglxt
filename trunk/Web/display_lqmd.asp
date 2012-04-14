<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="Connections/conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>2011年江西科技师范学院校考成绩查询结果</title>
</head>
<%
dim path
'----读写文本文件内容函数
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
	<script language="javascript">alert("考生号和姓名不能为空！");</script>
	<meta http-equiv="refresh" content="0; url=index.asp" />
<%
      'response.redirect("index.asp")
	  response.End()
    end if

    'response.write MM_conn_STRING & ksh & "," & xm
    'response.end()
    set mycon = Server.CreateObject("adodb.connection")
    mycon.Open MM_conn_STRING

    sqlstr = "SELECT 考生号,省份,姓名,性别,美术类,服装表演,音乐类,舞蹈类  FROM 最终成绩 WHERE 考生号='"&ksh&"' and 姓名='"&xm&"'"
    'response.write sqlstr
    'response.end

    set rec = mycon.Execute(sqlstr)

if rec.bof and rec.eof then
	sMsg="对不起！未能查询到该考生的校考成绩信息。如有疑问可拨打电话0791-3812427，3831320进行咨询！"
	v_sf = "&nbsp;/"
	v_ksh = "&nbsp;/"
	v_xm = "&nbsp;/"
	v_xb = "&nbsp;/"
	v_ms = "&nbsp;/"
	v_fz = "&nbsp;/"
	v_yy = "&nbsp;/"
	v_wd = "&nbsp;/"
else
	v_sf = trim(rec("省份"))
	v_ksh = rec("考生号")
	v_xm = rec("姓名")
	v_xb = rec("性别")
	v_ms = rec("美术类")
	v_fz = rec("服装表演")
	v_yy = rec("音乐类")
	v_wd = rec("舞蹈类")
	sMsg = v_xm & "同学，您的校考专业成绩如下："
	if v_ms<>"" then v_zymc="美术，"
	if v_yy<>"" then v_zymc=v_zymc&"音乐，"
	if v_fz<>"" then v_zymc=v_zymc&"服装表演，"
	if v_wd<>"" then v_zymc=v_zymc&"舞蹈，"
	v_zymc = mid(v_zymc,1,Len(v_zymc)-1)
 End If
  '更新查询人次,必须保证数据库所在的文件夹有可写权限，把目录设置为Uesers可读可写就行了。
  call UpdateCount
  rec.close()
  set rec=Nothing
%>
<div align="center"><font color="#FF0000" size="3" face="宋体">查询结果：</font></div>
<p>
<table width="492" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#0000FF">
  <tr height="35">
	<td height="62" colspan="2" bgcolor="#FFFFFF"><font color="#FF0000" size="2">　　<%=sMsg%></font></td>
  </tr>
  <tr>
  	<td width="104" height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">省份：</font></div></td> 
    <td width="365" height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_sf%></font></td>
  </tr>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">考生号：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_ksh%></font></td>
  </tr>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">姓名：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_xm%></font></td>
  </tr>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">性别：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_xb%></font></td>
  </tr>  
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">报考专业：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_zymc%></font></td>
  </tr>  
<%if v_ms<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">美术成绩：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_ms%></font></td>
    </tr>
<%end if%>    
<%if v_yy<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">音乐成绩：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_yy%></font></td>
    </tr>
<%end if%>    
<%if v_fz<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">服装表演成绩：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_fz%></font></td>
    </tr>
<%end if%>    
<%if v_wd<>"" then%>
  <tr>
  	<td height="35" nowrap bgcolor="#FFFFFF"><div align="right"><font size="2">舞蹈成绩：</font></div></td> 
    <td height="35" nowrap bgcolor="#FFFFFF">      <p align="left"><font color="36669E" size="2">&nbsp;<%=v_wd%></font></td>
    </tr>
<%end if%>    
  <tr height="35">
	<td height="62" colspan="2" valign="middle" bgcolor="#FFFFFF"><font size="2">　　<font color="#FF0000"><strong>注：</strong></font><font color="#000000"><strong>如有疑问可拨打电话0791-3812427，3831320进行咨询！。</strong></font></font></td>
  </tr>
</table>

<p align="center">
<a href="index.asp"><font size="2">返　回</font></a> 
</body>
</html>