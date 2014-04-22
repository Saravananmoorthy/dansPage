<%-- 
    Document   : display_using_classes
    Created on : Feb 23, 2014, 8:19:32 AM
    Author     : dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.TripReportView" %>
<%@page language="java" import="model.TripReport.TripReportMods" %>

<!DOCTYPE HTML>

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
        String dbDataOrError = "";
        String msg = "";

        // Get database connection and check if you got it.
        DbConn dbc = new DbConn();
        String dbError = dbc.getErr();
        if (dbError.length() == 0) {

            // got open connection, check to see if the user wants to delete a row.
            String delKey = request.getParameter("deletePK");
            if (delKey != null && delKey.length() > 0) {

                // yep, they want to delete a row, instantiate objects needed to do the delete.
                TripReportMods sqlMods = new TripReportMods(dbc);

                // try to delete the row that has PK = delKey
                String delMsg = sqlMods.delete(delKey);
                if (delMsg.length() == 0) {
                    msg = "<h3>Trip " + delKey + " has been deleted</h3>";
                } else {
                    msg = "<h3>Unable to delete Trip " + delKey + ". " + sqlMods.getErrorMsg() + "</h3>";
                }
            } else {
                msg = "<h1>Trip Reports</h1>"; // place holder for message (so data grid remains in same place before and after delete.s
            }

            // now print out the whole table
            dbDataOrError = TripReportView.listDelUsers("resultSetFormat", dbc,
                    "javascript:deleteTripRow", "icons/delete.png");
            dbc.close();
        } else {
            dbDataOrError = dbError;
        }
    %>
    
    <jsp:include page="pre-content.jsp" />
    
    <%=msg%>


    <form name="updateDelete" action="assoc.jsp" method="get">
        <input type="hidden" name="deletePK">
    </form>

    <%=dbDataOrError%>

    <script language="Javascript" type="text/javascript">

        function deleteTripRow(primaryKey) {
            if (confirm("Do you really want to delete trip " + primaryKey + "?")) {
                document.updateDelete.deletePK.value = primaryKey;
                document.updateDelete.submit();
            }
        }

    </script>

    <jsp:include page="post-content.jsp" />