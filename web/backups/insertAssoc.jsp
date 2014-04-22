<%@page import="SQL.DbConn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.TripReport.*" %>

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
        Validate tripValidate;
        StringData myTripDataObj = (model.TripReport.StringData) session.getAttribute("parkId");

        if (myTripDataObj == null) {
            //session has timed out, re-direct back to logon page
            try {
                response.sendRedirect("deny.jsp?errorMsg=You must be logged in to add a trip");
            } catch (Exception e) {
                formMsg += " Exception was thrown: " + e.getMessage();
            }
        }

        if (request.getParameter("tripTitle") == null) {
            // first display.  All form fields are null, iff any one form field is null.
            tripValidate = new Validate();
        } else {
            myTripDataObj.setTripTitle(request.getParameter("tripTitle"));
            myTripDataObj.setTripDescription(request.getParameter("tripDescription"));
            myTripDataObj.setNumDaysSpent(request.getParameter("numDaysSpent"));
            myTripDataObj.setTripDate(request.getParameter("tripDate"));
            myTripDataObj.setPhotosURL(request.getParameter("photosURL"));
            myTripDataObj.setGpsURL(request.getParameter("gpsURL"));

            tripValidate = new Validate(myTripDataObj);

            if (tripValidate.isValidated()) {
                // get an OPEN db connection.  Using default constructor (no inputs)
                // means the dbconn object will try to determine where it's running
                // and use the right connection string.
                DbConn dbc = new DbConn();
                String dbError = dbc.getErr();
                if (dbError.length() == 0) {

                    TripReportMods tripMods = new TripReportMods(dbc);

                    formMsg = tripMods.insert(tripValidate);
                    if (formMsg.length() == 0) {
                        formMsg = "Trip record inserted.";
                    }
                    dbc.close();
                } else {
                    formMsg = dbError;
                }
            } else {
                formMsg = "Please try again.";
            }
        }
    %>

    <h1>Trip Entry</h1>
    <form name="addTrip" action="insertAssoc.jsp" method="GET">
        <input type="hidden"  name="parkId" value="<%= myTripDataObj.parkId%>" /> 
        <input type="hidden"  name="webUserId" value="<%= myTripDataObj.webUserId%>" /> 

        <table class="inputTable">
            <tr>
                <td class="prompt">Trip Title:</td>
                <td><input type="text" name="tripTitle" maxlength="64" value="<%= myTripDataObj.tripTitle%>" /></td>
                <td class="error"><%=tripValidate.getTripTitleMsg()%></td>
            </tr>
            <tr>
                <td class="prompt">Days Spent:</td>
                <td><input type="text" name="numDaysSpent" value="<%= myTripDataObj.numDaysSpent%>" /></td>
                <td class="error"><%=tripValidate.getNumDaysSpentMsg()%></td>   
            </tr>
            <tr>
                <td class="prompt">Photos at:</td>
                <td><input type="text" name="photosURL" value="<%=myTripDataObj.photosURL%>" /></td>
                <td class="error"><%=tripValidate.getPhotosURLMsg()%></td>
            </tr>
            <tr>
                <td class="prompt">GPS data at:</td>
                <td><input type="text" name="gpsURL" value="<%=myTripDataObj.gpsURL%>" /></td>
                <td class="error"><%=tripValidate.getGpsURLMsg()%></td>
            </tr>
            <tr>
                <td class="prompt">Trip Date:</td>
                <td><input type="text" name="tripDate" value="<%=myTripDataObj.tripDate%>" /></td>
                <td class="error"><%=tripValidate.getTripDateMsg()%></td>
            </tr>
            <tr>
                <td class="prompt">Trip Description:</td>
                <td><input type=textarea name="tripDescription" maxlength="512" 
                           value="<%= myTripDataObj.tripDescription%>" /></td>
                <td class="error"><%=tripValidate.getTripDescriptionMsg()%></td>
            </tr>
            <tr>
                <td class="prompt"><input type="submit" value="Add" /></td>
                <td id="message"><%=formMsg%></td>
            </tr>
        </table>      
    </form>

    <jsp:include page="post-content.jsp" />