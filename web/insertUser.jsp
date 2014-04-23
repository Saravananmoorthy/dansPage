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

    <jsp:include page="pre-content.jsp" />

    <%

        String formMsg = "";
        StringData wuData = new StringData();  // all properties of a new WebUser object are "" (empty string)

        Validate wuValidate;
        if (request.getParameter("userEmail") == null) {
            // first display.  All form fields are null, iff any one form field is null.
            wuValidate = new Validate(); // no error messages
        } else {
            // postback -- fill WebUserData object with form data.
            wuData.userEmail = request.getParameter("userEmail");
            wuData.userPw = request.getParameter("userPw");
            wuData.userPw2 = request.getParameter("userPw2");
            wuData.membershipFee = request.getParameter("membershipFee");
            wuData.birthday = request.getParameter("birthday");
            wuData.userRoleId = request.getParameter("userRoleId");

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
        }
    %>

    <h1>User Registration</h1>
    <form name="myForm" action="insertUser.jsp" method="POST">
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
            <tr>
                <td>Membership Fee</td>
                <td><input type="text" name="membershipFee" value="<%= wuData.membershipFee%>" /></td>
                <td class="error"><%=wuValidate.getMembershipFeeMsg()%></td>
            </tr>
            <tr>
                <td>User Role</td>
                <td><input type="text" name="userRoleId" value="<%= wuData.userRoleId%>" /></td>
                <td class="error"><%=wuValidate.getUserRoleMsg()%></td>
            </tr>
            <tr>
                <td>Birthday</td>
                <td><input type="text" name="birthday" value="<%= wuData.birthday%>" /></td>
                <td class="error"><%=wuValidate.getBirthdayMsg()%></td>
            </tr>
            <tr>
                <td><input type="submit" value="Submit" /></td>
                <td colspan="2" class="error"><%=formMsg%></td>
            </tr>
        </table>
    </form>

    <div class="intraLink">
        <a href="users.jsp"><h3>List All Campers</h3></a>
    </div>

    <jsp:include page="post-content.jsp" />