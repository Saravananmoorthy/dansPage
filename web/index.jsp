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
        <title>Get Out Local</title>
        <style>
            body {
                font-family: "Tahoma", "Helvetica", "Arial", sans-serif;
                background-image: url(images/BG_Campsite_Big.jpg);  /* Pic size:200-300K, but for sure <500K. Put in folder "images" */
                /*Background image courtesy of http://www.tonyjohnson.info/ */
                background-repeat: no-repeat;
                background-size: cover;  /* bg pic will stretch when window is resized */
                background-color: #1c1c24; /* select color that matches your bg pic */
                opacity:0.88;
            }
            #container {
                /*border:2px solid green; */
                width:85%;  
                margin:auto;  /* this means center the container div (itself, not its contents) */
                font-size: 14px;
                min-width: 750px;  /* if user tries to size smaller than this, scroll bar will kick in. */
            }
            #title {
                /*border:2px solid brown;
                /*background-color:#bbbac2;*/
                color: #bbbac2;
                font-weight: bold;
                font-size: 30px;
                letter-spacing: 2px;
            }
            #nav {
                /*border:2px solid yellow; */
            }
            .tab {
                /*border:2px solid blue; */
                width:12%;
                float:left;
                font-size:22px;
                min-width:100px; /* tab will only get this narrow when user sizes down window */
                text-align:center;
                background-color:#bbbac2;
                border-top-left-radius:10px;               
                border-top-right-radius:10px;   
                margin:auto; 
                color: #1b1b24;
             }
            .tab:hover { 
                background-color:#a1a0af; 
            }
            .tab a {
                text-decoration: none;
            }
            .tab a:link {
                color:#1e1e29;
            }
            .tab a:visited {
                color:#2d2e3f;
            }
            .newLine {
                clear:both;
            }
            #content {
                /*border:2px solid purple; */
                color:#1b1b24;
                font-size: 18px;
                clear:both;
                margin:0px;
                
                
            }
            .selected {
                background-color:#bbbac2;
            }
            #footer {
                /*border:2px solid gold; */
                background-color:#bbbac2;
                text-align: right;
                color: #1b1b24;
                 
            }
            #footer a {
                text-decoration: none;
                color: #1b1b24;
            }
            img {
                float:left;   
                margin: 10px;
                margin-top:0px;
                margin-bottom:15px;
            }
            
        </style>
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
            </div> <!-- finishes off the content div -->
            <div id="footer">Web Site Design by 
                <a href="mailto:dmcginni@temple.edu">Dan McGinnis</a></div>
        </div> <!-- finishes off the container div -->
    </body>
</html>
