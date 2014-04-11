<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.WebUser.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link id="cssLinkID" href="defaultTheme.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="myscript.js"  type="text/javascript"></script>
        <script>
            // apply “tab selected” to the element with id “home”
            document.getElementById(this).className = "tab selected";
        </script>
        <title>Get Out Local</title>
    </head>


    <jsp:include page="pre-content.jsp" />

    <%
        String msg = "Don't know who you are.";
        String redirectMsg = "";
        StringData myWebUserStringDataObj = (model.WebUser.StringData) session.getAttribute("webUser");
        String user_Name = myWebUserStringDataObj.getUserEmail();
        String user_Role = myWebUserStringDataObj.getUserRoleId();
        System.out.println("user_Role: " + user_Role);
        int userRole = Integer.parseInt(user_Role);
        System.out.println("int user role: " + userRole);
            if (user_Name == null) {
                redirectMsg = "Sorry you cannot access the ADMIN page because you are not logged in.";
            } else if (userRole > 1) {
                redirectMsg = "Sorry you are not authorized to access the ADMIN page.";
            }
            if (redirectMsg.length() != 0) {
                try {
                    response.sendRedirect("deny.jsp?errorMsg=" + redirectMsg);
                } catch (Exception e) {
                    msg += " Exception was thrown: " + e.getMessage();
                }
            }
        msg = "Hello " + user_Name + " (your role is " + userRole + ")";
    %>

    <br/>
    <br/>
    <%=msg%>
    <br/>
    <br/>
    <h3>You are allowed to access this ADMIN page.</h3>
    
    
<jsp:include page="post-content.jsp" />
