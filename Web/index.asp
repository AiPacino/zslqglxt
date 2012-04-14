<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="Connections/conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>江西科技师范学院2011年校考成绩查询结果</title>
</head>
<%
dim path
'----读写文本文件内容函数
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
      <font color="red" size="3" face="新宋体">江西科技师范学院2011年校考专业成绩查询</font>
</div>
    <p>
<table width="632" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0066FF">
  <tr>
    <td width="630" height="59" align="left" bgcolor="#FFFFFF"><font size="2" face="宋体"><br>	
    </font><form name="form1" method="post" action="display_lqmd.asp">
      <div align="center">
        <font color="36669E" size="2" face="宋体"><strong>考生号：</strong></font> 
          <font size="2" face="宋体">
            <input name="ksh" type="text" id="ksh">
          </font><br>
		  <font color="36669E" size="2" face="宋体"><strong>姓　名：</strong></font> 
          <font size="2" face="宋体">
            <input name="xm" type="text" id="xm">
          </font>
        <br><font size="2" face="宋体">　　　　　
            <input type="submit" name="Submit" value="查　询">　
          <input type="reset" name="Submit2" value="重　置">
            </font>
      </div>
    </form>

<p>
<font color="blue" size="2">　　本查询系统可查询我校艺术和音乐校考专业成绩！</font><p>
	</td>
  </tr>
</table>
<p>
<hr>
<p>
<font color="red" size="2"><center>查询人次：<%=ReadCount%>人</center></font>
<p>
<p>
</body>
</html>