<%-- 
    Document   : display_using_classes
    Created on : Feb 23, 2014, 8:19:32 AM
    Author     : dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.ParkView" %>
<%@page language="java" import="model.Parks.ParkMods" %>
<%@page language="java" import="model.Parks.StringData" %>
<%@page language="java" import="model.Parks.Validate" %>

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
    <a href="insertOther.jsp"><h3>Add A New Park</h3></a>
    </div>

        <%
       String dbDataOrError = "";
        // All properties of a new webUserStringData object are "" (empty string).
        StringData parkStringData = new StringData();

        // All error mesages in the new Validate object are "" (empty string)  
        // This is good for first display.
        Validate parkValidate = new Validate();

        String strParkId = ""; // will be null or "" unless user is trying to update

        // This will hold a confirmation or error message relating to user's update attempt
        String formMsg = "";
        
        DbConn dbc = new DbConn();
        dbDataOrError = dbc.getErr();
        if (dbDataOrError.length() == 0) {
            
            // This object can do update, delete, insert.
            ParkMods sqlMods = new ParkMods(dbc);
            
            // check to see if the user wants to delete a row.
            String delKey = request.getParameter("deletePK");
            if (delKey != null && delKey.length() > 0) {

                // try to delete the row that has PK = delKey
                String delMsg = sqlMods.delete(delKey);
                if (delMsg.length() == 0) {
                    out.println("<h3>Park " + delKey + " has been deleted</h3>");
                } else {
                    out.println("<h3>" + sqlMods.getErrorMsg() + "</h3>");
                }
            }
            
            // webUserId (html form input) will have a value (not null, not empty)
            // if the user is trying to update.
            strParkId = request.getParameter("parkId");
            if (strParkId != null && strParkId.length() > 0) {
                // postback -- fill WebUserData object with form data.
                parkStringData.parkId = request.getParameter("parkId");
                parkStringData.parkName = request.getParameter("parkName");
                parkStringData.stateName = request.getParameter("stateName");
                parkStringData.overNightFee = request.getParameter("overNightFee");
                parkValidate = new Validate(parkStringData); // populate error messages from user inputs

                // try to update the Web User record. returns error message or empty string
                formMsg = sqlMods.update(parkValidate); // empty string means went in OK.
                if (formMsg.length() == 0) { //trying to insert from a web user validation object.
                    formMsg = parkStringData.parkName + " updated. ";
                }
            }
            
            // this is a String that holds the whole result set formated into a HTML table.
            dbDataOrError = ParkView.listUpdateDeleteUsers("resultSetFormat", "javascript:deleteRow",
                    "icons/delete.png", "javascript:sendRequest", "icons/update.png", dbc);
         
            // PREVENT DB connection leaks: shouldnt hurt to close it even if it was never opened.
            dbc.close();
        }
         
    %>
    
     <div id="inputArea">
        <form name="updateDelete" action="other.jsp" method="get">
            <input type="hidden" name="deletePK">

        </form>
        <br/>
        <form name="updateForm" action="other.jsp" method="get">           
            Park Id <input type="hidden"  name="parkId" value="<%= parkStringData.parkId%>" /> 
            <br/>
            <table class="inputTable">
                <tr>
                    <td class="prompt">Park Name:</td>
                    <td><input type="text" name="parkName" size="45" value="<%= parkStringData.parkName%>" /></td>
                    <td class="error"><%=parkValidate.getParkNameMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">State Name:</td>
                    <td><input type="text" name="stateName" size="45" value="<%= parkStringData.stateName%>" /></td>
                    <td class="error"><%=parkValidate.getStateNameMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Overnight Fee:</td>
                    <td><input type="text" name="overNightFee" value="<%= parkStringData.overNightFee%>" /></td>
                    <td class="error"><%=parkValidate.getOverNightFeeMsg()%></td>   
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
            if (document.updateForm.parkId.value != null &&
                    document.updateForm.parkId.value.length > 0) {
                document.getElementById("inputArea").style.display = "block";
            }
        }

        function deleteParkRow(primaryKey) {
            if (confirm("Do you really want to delete park " + primaryKey + "?")) {
                document.updateDelete.deletePK.value = primaryKey;
                document.updateDelete.submit();
            }
        }
        
        function clearFields() {
            document.getElementById("inputArea").style.display = "none";
            document.updateForm.parkId.value = "";
            document.updateForm.parkName.value = "";
            document.updateForm.stateName.value = "";
            document.updateForm.overNightFee.value = "";
        }
        
        function handleResponse() {
            document.getElementById("inputArea").style.display = "block";
            //alert('handling response');
            if (httpReq.readyState == 4 && httpReq.status == 200) {
                //alert('handling response ready 4 status 200');
                var response = httpReq.responseText;
                alert("response is " + response);

                // be careful -- field names on the document are case sensative
                // field names extracted from the JSON response are also case sensative.
                var parkObj = eval(response);
                
                document.updateForm.parkId.value = parkObj.parkId;
                document.updateForm.parkName.value = parkObj.parkName;
                document.updateForm.stateName.value = parkObj.stateName;
                document.updateForm.overNightFee.value = parkObj.overNightFee;
            }
        }
        
        // this is ajax call to server, 
        // asking for all the data associated with a particular primary key
        function sendRequest(primaryKey) {
            alert('sending request for park ' + primaryKey);
            httpReq.open("GET", "getOtherJSON.jsp?primaryKey=" + primaryKey);
            httpReq.onreadystatechange = handleResponse;
            httpReq.send(null);
        }

    </script>

    <jsp:include page="post-content.jsp" />