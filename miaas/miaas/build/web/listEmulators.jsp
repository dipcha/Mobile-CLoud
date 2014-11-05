<%-- 
    Document   : listEmulators
    Created on : May 15, 2014, 5:50:54 PM
    Author     : raghav
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.miass.db.*;" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Emulators</title>
    </head>
    <body>
        <table border="0">
            <tr>
                <td>Name</td>
                <td>Version</td>
                <td>Port</td>
                <td></td>
                <td></td>
            </tr>
           
        <%
         if(session.getAttribute("id")==null)
            {
            
            response.sendRedirect("login.jsp");
            }
         if(request.getParameter("opt")!=null)
         {
         if(request.getParameter("opt").equalsIgnoreCase("delete"))
         {
         DBOperations.deleteEmulator(request.getParameter("id"));
         }
         if(request.getParameter("opt").trim().equalsIgnoreCase("Stop"))
         {
         DBOperations.stopEmulator(request.getParameter("id"));
         }
         if(request.getParameter("opt").trim().equalsIgnoreCase("Launch"))
         {
          
         DBOperations.launchEmulator(request.getParameter("id"));
         }
         }
         ArrayList<Emulator> emulators=DBOperations.getEmulators(session.getAttribute("id").toString());
         for(Emulator e:emulators)
         {
         %>
         <form action="" method="post">
             <tr>
                 <td><% out.println(e.getName()); %></td>
                 <td><% out.println(e.getVersion()); %></td>
                 <td><% out.println(e.getPort()); %></td>
                 <td><input type="hidden" id="id" name="id" value="<%out.println(e.getId());%>"/></td>
                 <td><input type="submit" value="<%out.println(e.isRunning()?"Stop":"Launch");%>" name="opt" id="opt"/></td> 
                 <td><input type="submit" value="delete" name="opt" id="opt"/></td>
             </tr>
         </form>
            
         <%
         }
         
        %>
        </table>
    </body>
</html>
