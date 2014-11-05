<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.miass.db.*;" %>
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
	text-align: center; /* this centers the container in IE 5* browsers. The text is then set to the left aligned default in the #container selector */
	color: #000000;
}
.oneColElsCtr #container {
	height:100%;
	background: #FFFFFF;
	border: 1px solid #000000;
	text-align: center; /* this overrides the text-align: center on the body element. */
}
.oneColElsCtr #mainContent {
	height:100%;
	padding: 0 20px; /* remember that padding is the space inside the div box and margin is the space outside the div box */
}
.button {
    border: 1px solid #006;
    background: #9cf;
}
td{
    width:300px;
    height:50px;
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
      <h1>Your unpaid bills</h1>
      <center>
      <table>
          <tr>
              <td>Name</td>
              <td>Start Time</td>
              <td>End Time</td>
              <td>Cost</td>
          </tr>
          <%
          if(session.getAttribute("id")==null)
            {
            
            response.sendRedirect("login.jsp");
            }
            DecimalFormat twoDForm = new DecimalFormat("#.###");
            double total=0;
          ArrayList<BillEntry> bills=DBOperations.getBills(session.getAttribute("id").toString());
          for(BillEntry bill:bills)
          {
          %>
          <tr>
                 <td><% out.println(bill.getName()); %></td>
                 <td><% out.println(bill.getStart()); %></td>
                 <td><% if(bill.getEnd()!=null)out.println(bill.getEnd()); %></td>
                 <td><% if(bill.getEnd()!=null){out.println(Double.valueOf(twoDForm.format(bill.getCost())));total=total+bill.getCost(); }%></td>
             </tr>
          <%
          }
          %>
          <tr>
              <td>Total</td>
              <td></td>
              <td></td>
              <td><%out.println(Double.valueOf(twoDForm.format(total)));%></td>
          </tr>
      </table>
      </center>
 
   
    <input name="emulator" type="submit" value="Pay Bill" style="background:#63F; color:#FFF" />
    
    
	<!-- end #mainContent --></div>
<!-- end #container --></div>
</div>
</body>
</html>
