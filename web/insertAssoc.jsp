<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.TripReport.*" %>

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


    <h3>
        Soon you'll be able to add a trip report here.
    </h3>

    <%  Validate tripValidate = new Validate();
        String info = "";
        String parkId = "";
        String formMsg="";

        StringData myTripDataObj = (model.TripReport.StringData) session.getAttribute("parkId");

        if (myTripDataObj != null) {
            info = myTripDataObj.getWebUserId();
            parkId = myTripDataObj.getParkId();
        }


    %>

    UserId: <%=info%>
    <br>
    ParkId: <%=parkId%>


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
            <td><input type=textarea name="tripDescription" maxlength="512" value="<%= myTripDataObj.tripDescription%>" /></td>
            <td class="error"><%=tripValidate.getTripDescriptionMsg()%></td>
        </tr>
        <tr>
            <td class="prompt"><input type="submit" value="Add" /></td>
            <td><input type="button" value="Clear Data" onclick="clearFields()"/></td>
            <td id="message"><%=formMsg%></td>
        </tr>
    </table>          

    <jsp:include page="post-content.jsp" />
