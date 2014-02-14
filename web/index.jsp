<%-- 
    Document   : index
    Created on : Feb 12, 2014, 9:43:32 AM
    Author     : dan mcginnis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="mystyle.css" rel="stylesheet" type="text/css" />
        <script src="myscript.js"  type="text/javascript"> </script>
        <title>Get Out Local</title>
    </head>
    <body>
        <br/>
        <div id="container">
            <div id="title">Get Out Local</div>  <!-- finishes off the title div -->
            <div id="nav">
                <div id="home"    class="tab"> <a href="index.jsp">  Home</a></div>
                <div id="assoc"   class="tab">          <a href="assoc.jsp">Trip Reports</a></div>
                <div id="other"   class="tab">          <a href="other.jsp">Parks</a></div>
                <div id="users"   class="tab">          <a href="users.jsp">Campers</a></div>
                <div id="search"  class="tab">          <a href="search.jsp"> Search</a></div>
                <div id="contact" class="tab">          <a href="contact.jsp">Contact</a></div>
                <div id="labs"    class="tab">          <a href="labs.jsp">   Labs</a></div>
                
            </div>  <!-- finishes off the nav div -->
            <div id="content" class="selected">
                <br>
                <p>
                    <img src ='images/cultus_lake_01.jpg' alt ="A sign for Cultus Lake Campground">
                    
                    Don't risk having a bad trip by picking a campground at random.
                    Use Get Out Local and find the best places to camp near you 
                    by seeing what other campers have to say about campgrounds 
                    they've already been to. Add the places that you love to 
                    help others campers have great trips too.
                    <br><br>
                    
                    This site will let you search for a particular location or 
                    camper. You can also see all the places in any state or look for
                    trips that happened during a certain time of year.
                    
                </p>
                <p>
                    <a href="files/proosal.docx">My Project Proposal<a/>
                </p>
                <p>
                    <a href="files/data_model.docx">My Data Model<a/>
                </p>
            <jsp:include page="post-content.jsp" />
