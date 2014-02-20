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
        <link id="cssLinkID" href="defaultTheme.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="myscript.js"  type="text/javascript"></script>
        <title>Get Out Local</title>
    </head>
    
<script>

</script>
    
    <jsp:include page="pre-content.jsp" />

    <br>
    <p>
        <img src ='images/cultus_lake_01.jpg' alt ="A sign for Cultus Lake Campground">
    <h1 id="clickableHeaderOne">Title One</h1>
    <div id="pOne">Don't risk having a bad trip by picking a campground at random.
        Use Get Out Local and find the best places to camp near you 
        by seeing what other campers have to say about campgrounds 
        they've already been to. Add the places that you love to 
        help others campers have great trips too.
        <br><br>
    </div>
    <h1 id="clickableHeaderTwo">Title Two</h1>
    <div id="pTwo">
        This site will let you search for a particular location or 
        camper. You can also see all the places in any state or look for
        trips that happened during a certain time of year.
    </div>

</p>
<p>
    <a href="files/proosal.docx">My Project Proposal<a/>
</p>
<p>
    <a href="files/data_model.docx">My Data Model<a/>
</p>
<div id="themeSelector">
    Change Background To: 
    <select onchange="javascript:changeStyle(this.value)">
        <option value="defaultTheme.css">Default</option>
        <option value="themeOne.css">Theme 1</option>
        <option value="themeTwo">Theme 2</option>
    </select>  
</div>
<jsp:include page="post-content.jsp" />
