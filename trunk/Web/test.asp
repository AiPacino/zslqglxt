<%
Response.write "http://" & Request.ServerVariables("HTTP_HOST") & Mid(Request.ServerVariables("URL"),1,InStrRev(Request.ServerVariables("URL"),"/"))
%> 
<br>
<%=Request.ServerVariables("URL")%>
<br>
<%=Mid(Request.ServerVariables("URL"),InStrRev(Request.ServerVariables("URL"),"/"),30)%>