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
    <table border="0" width="2" cellspacing="3" cellpadding="4">
        <thead>
           <!-- I'm not sure what the table head is for. Netbeans created it for me. I'm leaving it in for now --> 
            <tr>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <form name="myForm" method="post" action="http://www.temple.edu/cgi-bin/mail?dmcginni@temple.edu">
        <tbody>
            <tr>
                <td>Name:</td>
                <td><input type="text" name="userName" required = "required"/></td>
            </tr>
            <tr>
                <td>email address:</td>
                <td><input type="email" name="emailAddress" required = "required"/></td>
            </tr>
            <tr>
                <td>Do you already have an account?</td>
                <td><input type="radio" name="haveAccount" value="Y"/>Yes
                    <input type="radio" name="haveAccount" value="N"/>No
                </td>
            </tr>
            <tr>
                <td>Would you like a response?</td>
                <td><input type="checkbox" name="responseRequired"/></td>
            </tr>
            <tr>
                <td>Type of comment:</td>
                <td>
                    <select name="commentType">
                        <option value="Sg" >Suggestion</option>
                        <option value="Co">Complaint</option>
                        <option value="Su">Support</option>
                        <option value="Ot">Other</option>
                        <option value="Su" selected="selected">Support</option>
                    </select> 

                </td>
            </tr>
            <tr>
                <td>Comments</td>
                <td></td>
            </tr>
            <tr>
                <!--Max lenght is set to the size of the field in the attached database -->
                <td><textarea name="inputcomments" cols="40" rows="5" required = "required" maxlength = 512></textarea></td>
                <td></td>
            </tr>
            <tr>
                <td><input type="submit" value="Submit"/></td>
                <td></td>
            </tr>
        </tbody>
        </form>
    </table>


    <jsp:include page="post-content.jsp" />
