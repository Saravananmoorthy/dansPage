<%@page import="model.Parks.Validate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page language="java" import="model.TripReport.StringData" %>

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
        String 
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
            <td class="prompt">Park Name:</td>
            <td><input type="text" name="parkName" size="45" value="<%= parkStringData.parkName%>" /></td>
            <!--<td class="error"><%=parkValidate.getParkNameMsg()%></td>-->
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

    <jsp:include page="post-content.jsp" />
