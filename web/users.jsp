<%-- 
    Document   : display_using_classes
    Created on : Feb 23, 2014, 8:19:32 AM
    Author     : dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.WebUserView" %>
<%@page language="java" import="model.WebUser.WebUserMods" %>
<%@page language="java" import="model.WebUser.StringData" %>
<%@page language="java" import="model.WebUser.Validate" %>

<!DOCTYPE HTML>

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

    <br>
    <div class="intraLink">
        <a href="insertUser.jsp"><h3>Add A New Camper</h3></a>
    </div>

    <%
            String dbDataOrError = "";
            // All properties of a new webUserStringData object are "" (empty string).
            StringData webUserStringData = new StringData();

        // All error mesages in the new Validate object are "" (empty string)  
            // This is good for first display.
            Validate webUserValidate = new Validate();

            String strWebUserId = ""; // will be null or "" unless user is trying to update

            // This will hold a confirmation or error message relating to user's update attempt
            String formMsg = "";

            // Get database connection and check if you got it.
            DbConn dbc = new DbConn();
            dbDataOrError = dbc.getErr();
            if (dbDataOrError.length() == 0) {  // got open connection

                // This object can do update, delete, insert.
                WebUserMods sqlMods = new WebUserMods(dbc);

                // check to see if the user wants to delete a row.
                String delKey = request.getParameter("deletePK");
                if (delKey != null && delKey.length() > 0) {

                    // try to delete the row that has PK = delKey
                    String delMsg = sqlMods.delete(delKey);
                    if (delMsg.length() == 0) {
                        out.println("<h3>Camper " + delKey + " has been deleted</h3>");
                    } else {
                        out.println("<h3>" + sqlMods.getErrorMsg() + "</h3>");
                    }
                } 
            

        // webUserId (html form input) will have a value (not null, not empty)
            // if the user is trying to update.
            strWebUserId = request.getParameter("webUserId");
            if (strWebUserId != null && strWebUserId.length() > 0) {
                // postback -- fill WebUserData object with form data.
                webUserStringData.webUserId = request.getParameter("webUserId");
                webUserStringData.userEmail = request.getParameter("userEmail");
                webUserStringData.userPw = request.getParameter("userPw");
                webUserStringData.userPw2 = request.getParameter("userPw2");
                webUserStringData.membershipFee = request.getParameter("membershipFee");
                webUserStringData.birthday = request.getParameter("birthday");
                webUserStringData.userRoleId = request.getParameter("userRoleId");
                webUserValidate = new Validate(webUserStringData); // populate error messages from user inputs

                // try to update the Web User record. returns error message or empty string
                formMsg = sqlMods.update(webUserValidate); // empty string means went in OK.
                if (formMsg.length() == 0) { //trying to insert from a web user validation object.
                    formMsg = "Record " + webUserStringData.userEmail + " updated. ";
                }

            } // checking if strWebUserId not null (means they wanted to update)
            // this is a String that holds the whole result set formated into a HTML table.
            dbDataOrError = WebUserView.listUpdateDeleteUsers("resultSetFormat", "javascript:deleteRow",
                    "icons/delete.png", "javascript:sendRequest", "icons/update.png", dbc);
         // got open connection
    
    // PREVENT DB connection leaks: shouldnt hurt to close it even if it was never opened.
    dbc.close();
    //else {
                    //out.println("<h1>Campers</h1>"); // place holder for message (so data grid remains in same place before and after delete.s
               // }
            // delete processed (if necessary)
            // now print out the whole table
           // dbDataOrError = WebUserView.listDelUsers("resultSetFormat", dbc,
             //       "javascript:deleteRow", "icons/delete.png");
            //dbc.close();
       // } else {
         //   dbDataOrError = dbError;
       // }
       // dbc.close();
    %>
    <form name="updateDelete" action="users.jsp" method="get">
        <input type="hidden" name="deletePK">
    </form>

    <% out.println(dbDataOrError);%>

    <script language="Javascript" type="text/javascript">

        function deleteRow(primaryKey) {
            if (confirm("Do you really want to delete camper " + primaryKey + "?")) {
                document.updateDelete.deletePK.value = primaryKey;
                document.updateDelete.submit();
            }
        }

    </script>


    <jsp:include page="post-content.jsp" />