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
        <script>
            // apply “tab selected” to the element with id “home”
            document.getElementById(this).className = "tab selected";
        </script>
        <title>Get Out Local</title>
    </head>
    
<script>

</script>
    
    <jsp:include page="pre-content.jsp" />

    <br>
    <p>
        <img src ='images/cultus_lake_01.jpg' alt ="A sign for Cultus Lake Campground">
    <h1 id="clickableHeaderOne">What We Are</h1>
    <div id="pOne">Don't risk having a bad trip by picking a campground at random.
        Use Get Out Local and find the best places to camp near you 
        by seeing what other campers have to say about campgrounds 
        they've already been to. Add the places that you love to 
        help others campers have great trips too. This site will let you search for a particular location or 
        camper. You can also see all the places in any state or look for
        trips that happened during a certain time of year.
        <br><br>
    </div>
    <h1 id="clickableHeaderTwo">Who We Are</h1>
    <div id="pTwo">
        A samll group of people who love camping and want to help you find the
        best places for your next trip. Our site contains only human created 
        content. We're not interesting in cluttering the site with automatically
        generated content from spam robots.
    </div>

</p>
<p>
    <a href="files/proosal.docx">My Project Proposal<a/>
</p>
<p>
    <a href="files/data_model.docx">My Data Model<a/>
</p>

<jsp:include page="post-content.jsp" />
