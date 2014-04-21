<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="model.WebUser.StringData" %>
<%@page language="java" import="model.WebUser.WebUserMods" %>

<!-- The purpose of this page is return text in JSON form so there is no HTML needed -->

<%
    String webUserId = request.getParameter("primaryKey");
    StringData wuStringData = new StringData();// all properties empty

    DbConn dbc = new DbConn();  // get an OPEN db connection. 
    String dbError = dbc.getErr();
    if (dbError.length() != 0) { // could not get connection
        wuStringData.setRecordStatus("Database connection error in "
                + "getWebUser.jsp: " + dbError);
    } else { // got connection
        WebUserMods sqlMods = new WebUserMods(dbc);
        wuStringData = sqlMods.find(webUserId);
        if (wuStringData == null) {
            wuStringData.setRecordStatus("getWebUserJSON.jsp. Problem finding "
                    + "record with id " + webUserId + ": " + sqlMods.getErrorMsg());
        } else {
            wuStringData.setRecordStatus("If found, fields have values. "
                    + "If not found, all fields are empty string.");
        }
    }
    out.print(wuStringData.toJSON());
    dbc.close();
%>
