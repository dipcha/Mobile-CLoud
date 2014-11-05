<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.miass.db.DBOperations;" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body  bgcolor="#B2E6FF" style="margin-top:0; padding-top:0; font-family: 'Berlin Sans FB Demi'; font-size: medium; color: #333;">
<table bgcolor="white" width="80%" height="100%" border="0" align="center">
  <tr>
    <td height="90" align="center"><p >Login</p></td>
  </tr>
  <tr>
    <td>
    <center>
    <form id="form1" name="form1" method="post" action="" width="40%">
     Username
        <input type="text" name="username" id="username" /><br /><br />
      Password&nbsp;&nbsp;
        <input type="password" name="password" id="password" /><br /><br />
      
      
        <input type="submit" name="submit" id="submit" value="Submit" style="background:#63F; color:#FFF" />
    </form>
    <center>
    </td>
      
  </tr>
    <tr style='color:blue'><td><center>
        <%
        if(request.getParameter("username")!=null&&request.getParameter("password")!=null)
        {
            String id=DBOperations.login(request.getParameter("username"), request.getParameter("password"));
        if(id!=null)
        {
        session.setAttribute("id", id);
        response.sendRedirect("main.jsp");
        }
        else
        {
        out.println("<p >Invalid username or password</p>");
        }
        }
        
        %>
            </center> </td> </tr>
  <tr>
    <td height="445">&nbsp;</td>
  </tr>
</table>

</body>
</html>
