<%-- 
    Document   : index
    Created on : Feb 12, 2014, 9:43:32 AM
    Author     : dan mcginnis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="model.WebUser.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link id="cssLinkID" href="css/defaultTheme.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="myscript.js"  type="text/javascript"></script>
        <script>
            // apply “tab selected” to the element with id “home”
            document.getElementById(this).className = "tab selected";
        </script>
        <title>Get Out Local</title>
    </head>

    <%
        String msg = ""; // first display will show nothing on screen.
        String user_Name = request.getParameter("uname");
        String user_Role = "";
        String pwEncrypted = "";
        StringData webuserStringData;
        String user_name = "";
        String pass_word = "";
        if (user_Name == null) {
            user_Name = ""; // surpress "NULL" (first display) from showing up in the username text field.
        } // postback, check username and password
        else {
            DbConn dbc = new DbConn();
            String dbErrorOrData = dbc.getErr();
            user_name = request.getParameter("uname");
            pass_word = request.getParameter("pw");

            if (dbErrorOrData.length() == 0) { // got open connection
                WebUserMods sqlMods = new WebUserMods(dbc);
                webuserStringData = sqlMods.findLogonUser(user_name, pass_word);
                if (webuserStringData.getUserEmail().length() == 0) {
                    msg = "You entered an invalid username or password";
                } else {
                    msg = "Welcome " + webuserStringData.getUserEmail()
                            + ", your user role ID is "
                            + webuserStringData.getUserRoleId();
                    session.setAttribute("webUser", webuserStringData); //set Session Object
                }
                // PREVENT DB connection leaks:
                //    EVERY code path that opens a db connection, must also close it.
                dbc.close();
            }
        } // postback
    %>

    <jsp:include page="pre-content.jsp" />

    <br>
    <br>
    <form method="get" action="logon.jsp" >
        Please enter your username: <input type="input" name="uname" value="<%=user_Name%>">
        <br>
        Please enter your password: <input type="password" name="pw">
        <br>
        <input type = "submit" value = "Log On" > <br/>
        <h3>  <%=msg%></h3>
    </form>

    <jsp:include page="post-content.jsp" />
