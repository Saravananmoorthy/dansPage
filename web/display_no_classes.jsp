<%-- 
    Document   : display_no_classes
    Created on : Feb 22, 2014, 4:54:56 PM
    Author     : dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.DriverManager"%>
<%@ page language="java" import="java.sql.Connection"%>
<%@ page language="java" import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
    <head>
        <style>
            body {background-color: khaki;}
            table, th, td {background-color: beige; 
                           border:thin solid maroon;
                           padding: 3px;
                           text-align:left;}
        </style>
        <title>List All Users</title>
    </head>
    <body>
        <%

            ServletContext context = getServletContext();
            String connectionString = context.getInitParameter("db_connection_string");
            out.println("<br/>Attribute db connection string: " + connectionString);

            Connection con = null; // "telephone call" between web app and the db mgt system
            PreparedStatement stmt = null; // holds the SQL statement the web app wants to run
            ResultSet results = null;  // holds the data that results from executing the SQL SELECT statement.

            out.println("<br/>ready to get the driver... <br/>");
            try { // to find the driver

                String DRIVER = "com.mysql.jdbc.Driver";
                Class.forName(DRIVER).newInstance();
                out.println("got the driver... <br/>");

                try { // to get the connection

                    // this works if you are running from Wachman Hall (in the CIS network)                    
                    //String url = "jdbc:mysql://CIS-Linux2.temple.edu:3306/SP11_2308_sallyk?user=sallyk&password=loh3Nito"; 
 
                    // you have to use this if you are working from home -- and you must be "tunnelled in" to the CIS network
                    String url = "jdbc:mysql://localhost:3307/SP11_2308_sallyk?user=sallyk&password=loh3Nito";

                    con = DriverManager.getConnection(url);
                    out.println("got the connection with the db..." + "<br/>");

                    try {
                        String sql = "select user_email, user_password from web_user order by user_email";
                        stmt = con.prepareStatement(sql);
                        results = stmt.executeQuery();

                        out.println("executed the query <br/><br/>");
                        out.println("<table>");
                        out.println("<tr><th>User Email</th><th>User Password</th></tr>");
                        while (results.next()) {
                            out.print("<tr>");
                            out.print("<td>" + results.getString("user_email") + "</td>");
                            out.print("<td>" + results.getString("user_password") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                        out.println("All Done !!");
                        results.close();  // close the result set
                        stmt.close(); // close the statement
                        con.close();  // close the db connection (THIS ONE IMPORTANT-no leaks!)
                    } catch (Exception e) {
                        out.println("problem creating statement & running query:" + e.getMessage() + "<br/>");
                        results.close();  // close the result set
                        stmt.close(); // close the statement
                        con.close();  // close the db connection (THIS ONE IMPORTANT-no leaks!)
                    }
                } catch (Exception e) {
                    out.println("problem getting connection:" + e.getMessage() + "<br/>");
                }
            } catch (Exception e) {
                out.println("problem getting driver:" + e.getMessage() + "<br/>");
            }
        %>
    </body>
</html>
