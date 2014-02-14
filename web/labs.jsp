<%-- 
    Document   : index
    Created on : Feb 12, 2014, 9:43:32 AM
    Author     : dan mcginnis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="mystyle.css" rel="stylesheet" type="text/css" />
        <script src="myscript.js"  type="text/javascript"> </script>
        <title>Get Out Local</title>
    </head>
    <jsp:include page="pre-content.jsp" />
    
    <script> // apply “tab selected” to the element with id “home”
        document.getElementById("labs").className = "tab selected";
    </script>                

   <h2>Lab 2 Data Model</h2>
        <a href="files/data_model.docx">My Data Model<a/>
    <h2>Lab 3 Home Page</h2>
    <h2>Lab 4 Forms Javascript Cookies</h2>
    <h2>Lab 5 Display Data</h2>
    <h2>Lab 6 Delete</h2>
    <h2>Lab 7 Insert</h2>
    <h2>Lab 8 Log On</h2>
    <h2>Lab 9 Insert Associative</h2>
    <h2>Lab 10 Update Ajax</h2>
    <h2>My Challenge</h2>

    <jsp:include page="post-content.jsp" />
