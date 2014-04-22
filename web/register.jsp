<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="validationUtils.*" %>

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
        String formMsg = "";
        StringData wuData = new StringData();  // all properties of a new WebUser object are "" (empty string)

        Validate wuValidate;
        if (request.getParameter("userEmail") == null) {
            // first display.  All form fields are null, if and only iff any one form field is null.
            wuValidate = new Validate(); // no error messages
        } else {
            // postback -- fill WebUserData object with form data.
            wuData.userEmail = request.getParameter("userEmail");
            wuData.userPw = request.getParameter("userPw");
            wuData.userPw2 = request.getParameter("userPw2");
            wuData.membershipFee = "";
            wuData.birthday = "";
            wuData.userRoleId = "4";   //self register is always lowest priority user

            wuValidate = new Validate(wuData); // populate error messages from user inputs

            if (wuValidate.isValidated()) {
                // get an OPEN db connection.  Using default constructor (no inputs)
                // means the dbconn object will try to determine where it's running
                // and use the right connection string.
                DbConn dbc = new DbConn();
                String dbError = dbc.getErr();
                if (dbError.length() == 0) {
                    WebUserMods wus = new WebUserMods(dbc);
                    // insert the validated web user object
                    formMsg = wus.insert(wuValidate);
                    if (formMsg.length() == 0) { //trying to insert from a web user validation object.
                        formMsg = "Record inserted. ";
                    }
                    dbc.close();
                } else {
                    formMsg = dbError; // db connection error
                }
            } else {
                formMsg = "Please try again."; // user data entry error
            }
        } // postback
    %>

    <jsp:include page="pre-content.jsp" />

    <h1>User Registration</h1>
    <form name="myForm" action="register.jsp" method="POST">
        <table style="text-align:left; border:thin solid gray; padding:5px;">
            <tr>
                <td>User Email</td>
                <td><input type="text" name="userEmail" value="<%= wuData.userEmail%>" /></td>
                <td class="error"><%=wuValidate.getUserEmailMsg()%></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="userPw" value="<%= wuData.userPw%>" /></td>
                <td class="error"><%=wuValidate.getUserPwMsg()%></td>
            </tr>
            <tr>
                <td>Re-type Password</td>
                <td><input type="password" name="userPw2" value="<%= wuData.userPw%>" /></td>
                <td class="error"><%=wuValidate.getUserPw2Msg()%></td>
            </tr>
            <td><input type="submit" value="Submit" /></td>
            <td colspan="2" class="error"><%=formMsg%></td>
            </tr>
        </table>
    </form>

    <jsp:include page="post-content.jsp" />