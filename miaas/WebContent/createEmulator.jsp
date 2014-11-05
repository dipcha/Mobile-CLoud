<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.miass.db.DBOperations;" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style type="text/css">
<!--
html{
	 height: 100%;
	}
body {
	font: 100% Verdana, Arial, Helvetica, sans-serif;
	background: #B2E6FF;
	margin: 0; /* it's good practice to zero the margin and padding of the body element to account for differing browser defaults */
	padding: 0;
	 height: 100%;
	color: #000000;
}
.oneColElsCtr #container {
	height:100%;
	background: #FFFFFF;
	border: 1px solid #000000;
	 /* this overrides the text-align: center on the body element. */
}
.oneColElsCtr #mainContent {
	height:100%;
	padding: 0 20px; /* remember that padding is the space inside the div box and margin is the space outside the div box */
}
.button {
    border: 1px solid #006;
    background: #9cf;
}
-->
</style>
<style type="text/css">
        .nav{    
  position: absolute;
    top: 0;
    left: 0;
    width: 150px;
    height:100%;
    display: inline;
}

.navlist
{
list-style-type:none;
padding:0;
text-align: left;
margin: 10px;
}
.main{
   margin-left: 150px;
  padding: 0;
  width:100%;
  height:100%;
     
}
</style></head>

<body class="oneColElsCtr"  style="margin-top:0; padding-top:0; font-family: 'Berlin Sans FB Demi'; font-size: medium; color: #333;">
<div class="nav">
<ul class="navlist">
<li><a href="main.jsp">Home</a></li>
<li><a href="createEmulator.jsp">create Emulator</a></li>
<li><a href="listEmulators.jsp">List Emulators</a></li>
<li><a href="bill.jsp">View Bill</a></li>
</ul>

</div>
<div class="main">
<div id="container">
  <div id="mainContent">
  <p>Create an emulator</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" >
      <form action="" method="post">
  <tr>
    <td>Name of emulator</td>
    <td><input type="text" name="name" id="name" /></td>
  </tr>
  <tr>
    <td>Port Number</td>
    <td><input type="text" name="port" id="port" /></td>
  </tr>
  <tr>
    <td>Version</td>
    <td><!--<input type="text" name="version" id="version" />-->
        <select name="version" id="version">
            <option value="android-19"> Android 4.4.2</option>
            <option value="android-18"> Android 4.3</option>
            <option value="android-17"> Android 4.2</option>
        </select>
        </td>
    
  </tr>
         
      <tr >
          <td colspan="2">
              <br></br>
              <center>   <input type="submit" value="Submit"></input></center>

          </td>
      </tr>
           <tr style='color:blue'><td><center>
        <%
            if(session.getAttribute("id")==null)
            {
            
            response.sendRedirect("login.jsp");
            }
        if(request.getParameter("name")!=null&&request.getParameter("version")!=null&&request.getParameter("port")!=null)
        {
            int id=DBOperations.createEmulator(session.getAttribute("id").toString(), request.getParameter("name"), request.getParameter("port"), request.getParameter("version"));
        if(id==1)
        {
         out.println("<p >Emulator created successfully</p>");
       /// response.sendRedirect("main.jsp");
        }
        else
        {
        out.println("<p >Emulator could not be created</p>");
        }
        }
        
        %>
            </center> </td> </tr>
</table>
</form>
    
	<!-- end #mainContent --></div>
<!-- end #container --></div>
</div>
</body>
</html>
