<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page language="java" import="SQL.*" %>
<%@page language="java" import="model.Parks.StringData" %>
<%@page language="java" import="model.Parks.ParkMods" %>

<!-- The purpose of this page is return text in JSON form so there is no HTML needed -->

<%
    String parkId = request.getParameter("primaryKey");
    StringData parkStringData = new StringData();// all properties empty
    DbConn dbc = new DbConn();  // get an OPEN db connection. 
    String dbError = dbc.getErr();

    if (dbError.length() != 0) { // could not get connection
        parkStringData.setRecordStatus("Database connection error in "
                + "getOtherJSON.jsp: " + dbError);
    } else { // got connection
        ParkMods sqlMods = new ParkMods(dbc);
        parkStringData = sqlMods.find(parkId);
        if (parkStringData == null) {
            parkStringData.setRecordStatus("getOtherJSON.jsp. Problem finding "
                    + "record with id " + parkId + ": " + sqlMods.getErrorMsg());
        } else {
            parkStringData.setRecordStatus("If found, fields have values. "
                    + "If not found, all fields are empty string.");
        }
    }
    out.print(parkStringData.toJSON());
    dbc.close();
%>
