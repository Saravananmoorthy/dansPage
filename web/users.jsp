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
                    msg = "<h3>Camper " + delKey + " has been deleted</h3>";
                } else {
                    msg = "<h3>" + sqlMods.getErrorMsg() + "</h3>";
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
                    formMsg = webUserStringData.userEmail + " updated. ";
                }
            }

            // this is a String that holds the whole result set formated into a HTML table.
            dbDataOrError = WebUserView.listUpdateDeleteUsers("resultSetFormat", "javascript:deleteRow",
                    "icons/delete.png", "javascript:sendRequest", "icons/update.png", dbc);

            // PREVENT DB connection leaks: shouldnt hurt to close it even if it was never opened.
            dbc.close();
        }
    %>
    
    <jsp:include page="pre-content.jsp" />
    
    <%=msg%>

    <br>
    <div class="intraLink">
        <a href="insertUser.jsp"><h3>Add A New Camper</h3></a>
    </div>

    <div id="inputArea">
        <form name="updateDelete" action="users.jsp" method="get">
            <input type="hidden" name="deletePK">

        </form>
        <br/>
        <form name="updateForm" action="users.jsp" method="get">           
            Web User Id <input type="hidden"  name="webUserId" value="<%= webUserStringData.webUserId%>" /> 
            <br/>
            <table class="inputTable">
                <tr>
                    <td class="prompt">User Email:</td>
                    <td><input type="email" name="userEmail" size="45" value="<%= webUserStringData.userEmail%>" /></td>
                    <td class="error"><%=webUserValidate.getUserEmailMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Password:</td>
                    <td><input type="password" name="userPw" size="45" value="<%= webUserStringData.userPw%>" /></td>
                    <td class="error"><%=webUserValidate.getUserPwMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Retype Password:</td>
                    <td><input type="password" name="userPw2" size="45" value="<%= webUserStringData.userPw%>" /></td>
                    <td class="error"><%=webUserValidate.getUserPw2Msg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Membership Fee:</td>
                    <td><input type="text" name="membershipFee" value="<%= webUserStringData.membershipFee%>" /></td>
                    <td class="error"><%=webUserValidate.getMembershipFeeMsg()%></td>   
                <tr>
                    <td class="prompt">User Role:</td>
                    <td><input type="number" step="1" min="1" max="5" name="userRoleId" value="<%= webUserStringData.userRoleId%>" /></td>
                    <td class="error"><%=webUserValidate.getUserRoleMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Birthday:</td>
                    <td><input type="date" name="birthday" value="<%= webUserStringData.birthday%>" /></td>
                    <td class="error"><%=webUserValidate.getBirthdayMsg()%></td>                    
                </tr>
                <tr>
                    <td class="prompt"><input type="submit" value="Update" /></td>
                    <td><input type="button" value="Clear Data" onclick="clearFields()"/></td>
                    <td id="message"><%=formMsg%></td>
                </tr>
            </table>          
        </form>
    </div>
    <div class="newLine"></div>
    <br/>

    <%=dbDataOrError%>

    <script language="Javascript" type="text/javascript">

        // Note: These next 9 lines of javascript are global (not in any funtion).
        // This is needed for asynchronous calls. 
        // 
        // Make the XMLHttpRequest Object
        var httpReq;
        if (window.XMLHttpRequest) {
            httpReq = new XMLHttpRequest();  //For Firefox, Safari, Opera
        }
        else if (window.ActiveXObject) {
            httpReq = new ActiveXObject("Microsoft.XMLHTTP");         //For IE 5+
        } else {
            alert('ajax not supported');
        }

        function setInputArea() {
            if (document.updateForm.webUserId.value != null &&
                    document.updateForm.webUserId.value.length > 0) {
                document.getElementById("inputArea").style.display = "block";
            }
        }

        function deleteRow(primaryKey) {
            if (confirm("Do you really want to delete camper " + primaryKey + "?")) {
                document.updateDelete.deletePK.value = primaryKey;
                document.updateDelete.submit();
            }
        }

        function clearFields() {
            document.getElementById("inputArea").style.display = "none";
            document.updateForm.webUserId.value = "";
            document.updateForm.userEmail.value = "";
            document.updateForm.userPw.value = "";
            document.updateForm.userPw2.value = "";
            document.updateForm.membershipFee.value = "";
            document.updateForm.userRoleId.value = "";
            document.updateForm.birthday.value = "";
        }

        function handleResponse() {
            document.getElementById("inputArea").style.display = "block";
            if (httpReq.readyState == 4 && httpReq.status == 200) {
                var response = httpReq.responseText;
                var webUserObj = eval(response);
                document.updateForm.webUserId.value = webUserObj.webUserId;
                document.updateForm.userEmail.value = webUserObj.userEmail;
                document.updateForm.userPw.value = webUserObj.userPw;
                document.updateForm.userPw2.value = webUserObj.userPw2;
                document.updateForm.membershipFee.value = webUserObj.membershipFee;
                document.updateForm.userRoleId.value = webUserObj.userRoleId;
                document.updateForm.birthday.value = webUserObj.birthday;
            }
        }

        // this is ajax call to server, 
        // asking for all the data associated with a particular primary key
        function sendRequest(primaryKey) {
            httpReq.open("GET", "getWebUserJSON.jsp?primaryKey=" + primaryKey);
            httpReq.onreadystatechange = handleResponse;
            httpReq.send(null);
        }

    </script>


    <jsp:include page="post-content.jsp" />