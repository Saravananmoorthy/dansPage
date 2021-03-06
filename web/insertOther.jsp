<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page language="java" import="model.Parks.*" %>
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
        StringData parkData = new StringData();  // all properties of a new WebUser object are "" (empty string)

        Validate parkValidate;
        if (request.getParameter("parkName") == null) {
            // first display.  All form fields are null, if and only iff any one form field is null.
            parkValidate = new Validate(); // no error messages
        } else {
            // postback -- fill WebUserData object with form data.
            parkData.parkName = request.getParameter("parkName");
            parkData.overNightFee = request.getParameter("overNightFee");
            parkData.stateName = request.getParameter("stateName");

            parkValidate = new Validate(parkData); // populate error messages from user inputs

            if (parkValidate.isValidated()) {

                // get an OPEN db connection.  Using default constructor (no inputs)
                // means the dbconn object will try to determine where it's running
                // and use the right connection string.
                DbConn dbc = new DbConn();
                String dbError = dbc.getErr();
                if (dbError.length() == 0) {
                    ParkMods wus = new ParkMods(dbc);
                    // insert the validated web user object
                    formMsg = wus.insert(parkValidate);
                    if (formMsg.length() == 0) {
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

    <h1>Add a Park</h1>
    <form name="myForm" action="insertOther.jsp" method="POST">
        <table style="text-align:left; border:thin solid gray; padding:5px;">
            <tr>
                <td>Park name</td>
                <td><input type="text" name="parkName" value="<%= parkData.parkName%>" /></td>
                <td class="error"><%=parkValidate.getParkNameMsg()%></td>
            </tr>
            <tr>
                <td>State Name</td>
                <td><input type="text" name="stateName" value="<%= parkData.stateName%>" /></td>
                <td class="error"><%=parkValidate.getStateNameMsg()%></td>
            </tr>

            <tr>
                <td>Overnight Fee</td>
                <td><input type="text" name="overNightFee" value="<%= parkData.overNightFee%>" /></td>
                <td class="error"><%=parkValidate.getOverNightFeeMsg()%></td>
            </tr>
            <td><input type="submit" value="Submit" /></td>
            <td colspan="2" class="error"><%=formMsg%></td>
            </tr>
        </table>
    </form>

    <div class="intraLink">
        <a href="other.jsp"><h3>List All Parks</h3></a>
    </div>

    <jsp:include page="post-content.jsp" />