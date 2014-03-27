<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="SQL.*" %>
<%@page language="java" import="validationUtils.*" %>
<%@page language="java" import="view.WebUserView" %>

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
    
    <% 
        DbConn dbc = new DbConn();
        String selectTag="";
        String dbErrorOrData = dbc.getErr();
        String defaultChoice = "";
        String dept = "";
        defaultChoice = request.getParameter(dept);
                
                selectTag = 
                        "<option value='0'>Select Department</option> " +
                        "<option value='2' selected='selected'>Biology</option> " +
                        "<option value='1'>Chemistry</option>" + 
                        "<select>";
                        
                        

                // this returns a string that contains a HTML table with the data in it
                //dbErrorOrData = WebUserView.listAllUsers("resultSetFormat", dbc);

                // PREVENT DB connection leaks:
                //    EVERY code path that opens a db connection, must also close it.
               
    %>
    
    <h4>Testing the Creation and Persistence of Pick List</h4>
    <form action="testPickList.jsp" method="GET">
        <select name='dept'>
        <%=selectTag%>
        <%=defaultChoice%>
       <input type="submit" value="Click Here for Test"/>
     </form>
   

    
      
        
    <jsp:include page="post-content.jsp" />