<%-- 
    Document   : pre-content
    Created on : Feb 13, 2014, 9:18:43 PM
    Author     : dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.WebUser.*" %>

<%
    StringData myWebUserStringDataObj = (model.WebUser.StringData) session.getAttribute("webUser");
    String user_Name = null;
    String link = "<a href='register.jsp'> Register </a> / <a href='logon.jsp'> Log On </a> ";
    if (myWebUserStringDataObj != null) {
        user_Name = myWebUserStringDataObj.getUserEmail();
        link = "Welcome " + user_Name + " <a href ='logoff.jsp'> Log Off </a >";
    }
%>

<body onload="setTheme();
        setInputArea()">
    <br/>
    <div id="container">
        <div id="title">Get Out Local</div>  <!-- finishes off the title div -->
        <div id="nav">
            <div id="home"    class="tab selected"> <a href="index.jsp">  Home</a></div>
            <div id="assoc"   class="tab">          <a href="assoc.jsp">Trip Reports</a></div>
            <div id="other"   class="tab">          <a href="other.jsp">Parks</a></div>
            <div id="users"   class="tab">          <a href="users.jsp">Campers</a></div>
            <div id="search"  class="tab">          <a href="search.jsp"> Search</a></div>
            <div id="contact" class="tab">          <a href="contact.jsp">Contact</a></div>
            <div id="admin"   class="tab">          <a href="admin.jsp">Admin</a></div>
            <div id="labs"    class="tab">          <a href="labs.jsp">   Labs</a></div>
        </div>  <!-- finishes off the nav div -->

        <br>

        <div id="content" class="selected">
            <div class="intraLink" style="text-align: right">
                <%=link%>
            </div>