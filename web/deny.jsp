<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        String errorMessage = request.getParameter("errorMsg");
        if (errorMessage == null) {
            errorMessage = "Apparently you are not allowed to access that page...";
        }
    %>
    
    <jsp:include page="pre-content.jsp" />

    <br/>
    <br/>
    <h3><%=errorMessage%></h3>

    <jsp:include page="post-content.jsp" />
