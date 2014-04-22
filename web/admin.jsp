<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        String msg = "We don't know who you are.";
        String redirectMsg = "";
        StringData myWebUserStringDataObj = (model.WebUser.StringData) session.getAttribute("webUser");
        if (myWebUserStringDataObj != null) {
            String user_Name = myWebUserStringDataObj.getUserEmail();
            String user_Role = myWebUserStringDataObj.getUserRoleId();
            int userRole = Integer.parseInt(user_Role);

            if (userRole > 1) { //Admin has the lowest permission number.
                redirectMsg = "Sorry. You are not authorized to access the ADMIN page.";
            }

            msg = "Hello " + user_Name + ", your role is " + user_Role + ".";
        } else {
            redirectMsg = "Sorry you cannot access the ADMIN page because you are not logged in.";
        }

        if (redirectMsg.length() != 0) {
            try {
                response.sendRedirect("deny.jsp?errorMsg=" + redirectMsg);
            } catch (Exception e) {
                msg += " Exception was thrown: " + e.getMessage();
            }
        }
    %>

    <jsp:include page="pre-content.jsp" />

    <br/>
    <br/>
    <%=msg%>
    <br>

    <jsp:include page="post-content.jsp" />
