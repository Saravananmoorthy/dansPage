<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        String msg = "You are now logged off!";
        try {
            session.invalidate();
        } catch (Exception e) {
            msg = "Exception was thrown trying to log off: " + e.getMessage();
            //seems unlikely we'd ever get here but Java requires we catch here.
        }
    %>

    <br>
    <br>
    <h3><%=msg%></h3>

    <jsp:include page="post-content.jsp" />
