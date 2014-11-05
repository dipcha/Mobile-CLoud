<%-- 
    Document   : listEmulators
    Created on : May 15, 2014, 5:50:54 PM
    Author     : raghav
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.miass.db.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Emulators</title>


<style type="text/css">
html {
	height: 100%;
}

body {
	font: 100% Verdana, Arial, Helvetica, sans-serif;
	background: #B2E6FF;
	margin: 0;
	/* it's good practice to zero the margin and padding of the body element to account for differing browser defaults */
	padding: 0;
	height: 100%;
	text-align: center;
	/* this centers the container in IE 5* browsers. The text is then set to the left aligned default in the #container selector */
	color: #000000;
}

.oneColElsCtr #container {
	width: 100%;
	height: 100%;
	background: #FFFFFF;
	margin: 0 auto;
	/* the auto margins (in conjunction with a width) center the page */
	border: 1px solid #000000;
	text-align: center;
	/* this overrides the text-align: center on the body element. */
}

.oneColElsCtr #mainContent {
	height: 100%;
	padding: 0 20px;
	/* remember that padding is the space inside the div box and margin is the space outside the div box */
}

.button {
	border: 1px solid #006;
	background: #9cf;
}

.nav {
	position: absolute;
	top: 0;
	left: 0;
	width: 150px;
	height: 100%;
	display: inline;
}

.navlist {
	list-style-type: none;
	padding: 0;
	text-align: left;
	margin: 10px;
}

.main {
	margin-left: 150px;
	padding: 0;
	width: 100%;
	height: 100%;
}
</style>
</head>
<body class="oneColElsCtr"
	style="margin-top: 0; padding-top: 0; font-family: 'Berlin Sans FB Demi'; font-size: medium; color: #333;">
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
				<table border="0">
					<tr>
						<td>Name</td>
						<td>Version</td>
						<td>Port</td>
						<td></td>
						<td></td>
					</tr>

					<%
						if (session.getAttribute("id") == null) {

							response.sendRedirect("login.jsp");
						}
						if (request.getParameter("opt") != null) {
							if (request.getParameter("opt").equalsIgnoreCase("delete")) {
								DBOperations.deleteEmulator(request.getParameter("id"));
							}
							if (request.getParameter("opt").trim().equalsIgnoreCase("Stop")) {
								DBOperations.stopEmulator(request.getParameter("id"));
							}
							if (request.getParameter("opt").trim()
									.equalsIgnoreCase("Launch")) {

								DBOperations.launchEmulator(request.getParameter("id"));
							}
						}
						ArrayList<Emulator> emulators = DBOperations.getEmulators(session
								.getAttribute("id").toString());
						for (Emulator e : emulators) {
					%>
					<form action="" method="post">
						<tr>
							<td>
								<%
									out.println(e.getName());
								%>
							</td>
							<td>
								<%
									out.println(e.getVersion());
								%>
							</td>
							<td>
								<%
									out.println(e.getPort());
								%>
							</td>
							<td><input type="hidden" id="id" name="id"
								value="<%out.println(e.getId());%>" /></td>
							<td><input type="submit"
								value="<%out.println(e.isRunning() ? "Stop" : "Launch");%>"
								name="opt" id="opt" /></td>
							<td><input type="submit" value="delete" name="opt" id="opt" /></td>
						</tr>
					</form>

					<%
						}
					%>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
