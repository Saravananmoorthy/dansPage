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
    
    <script> // apply “tab selected” to the element with id “home”
        document.getElementById("labs").className = "tab selected";
    </script>                

   <h2>Lab 2 Data Model</h2>
        <a href="files/data_model.docx">My Data Model<a/>
    <h2>Lab 3 Home Page</h2>
        <p>
            This lab involved the creation of the basic site. I didn't deviate
            from the lab instructions.
        </p>
    <h2>Lab 4 Forms Javascript Cookies</h2>
        <p>
            For this lab I added a few HTML 5 tags to the form so that the name
            field and email field must be filled in. I also set the max characters
            to the comment field to 512. By setting the email field to type email
            the browser will at least check for something that resembles an email
            address when the user enters something.
            <br>
            I opted to keep the same layout style for all three themes on the 
            site for the sake of consistency. I did change the colors and the 
            level of transparency for each of the three themes though, as well as
            the back ground. i had hoped to make the default selection on the 
            theme selector dropdown box be the current theme, but couldn't seem
            to get it to work properly. I've added it to the list of technical 
            debt for the site.
            <br>
            I left the "document.getElementById(this).className = "tab selected";"
            script in each html page because it seemed to generate errors if I 
            moved it to the central javascript page.
        </p>
    <h2>Lab 5 Display Data</h2>
    <h2>Lab 6 Delete</h2>
    <h2>Lab 7 Insert</h2>
    <h2>Lab 8 Log On</h2>
    <h2>Lab 9 Insert Associative</h2>
    <h2>Lab 10 Update Ajax</h2>
    <h2>My Challenge</h2>

    <jsp:include page="post-content.jsp" />
