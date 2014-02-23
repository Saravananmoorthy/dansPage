<%-- 
    Document   : display_using_classes
    Created on : Feb 23, 2014, 8:19:32 AM
    Author     : dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.WebUserView" %>

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
        <style>
            body {background-color:lightgray;}
            .resultSetFormat {background-color:beige;}
            .resultSetFormat th {border: medium solid brown; background-color:powderblue; padding:5px;}
            .resultSetFormat td {border: thin solid brown; background-color:aliceblue; padding:5px;}
        </style>
    </head>
    <jsp:include page="pre-content.jsp" />

        <%
            DbConn dbc = new DbConn();
            String dbErrorOrData = dbc.getErr();
            if (dbErrorOrData.length() == 0) { // got open connection

                // this returns a string that contains a HTML table with the data in it
                dbErrorOrData = WebUserView.listAllUsers("resultSetFormat", dbc);

                // PREVENT DB connection leaks:
                //    EVERY code path that opens a db connection, must also close it.
                dbc.close();
            }
        %>

        <h1>Web Users</h1>
        <% out.print(dbErrorOrData); %>
   
    <jsp:include page="post-content.jsp" />