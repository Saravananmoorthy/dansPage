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
        <link id="cssLinkID" href="css/defaultTheme.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="myscript.js"  type="text/javascript"></script>
        <script>
            // apply “tab selected” to the element with id “home”
            document.getElementById(this).className = "tab selected";
        </script>
        <title>Get Out Local</title>
    </head>

    <jsp:include page="pre-content.jsp" />

    <script> // apply “tab selected” to the element with id “home”
        document.getElementById("labs").className = "tab selected";
    </script>                

    <h2>Lab 2 Data Model</h2>
    <div class="intraLink">
        <a href="files/data_model.docx">My Data Model<a/>
    </div>
    <h2><a id="lab3">Lab 3 Home Page</a></h2>
    <p>
        This lab involved the creation of the basic site. I didn't deviate
        from the lab instructions.
    </p>
    <h2><a id="lab4">Lab 4 Forms Javascript Cookies</a></h2>
    <p>
        For this lab I added a few HTML 5 tags to the form so that the name
        field and email field must be filled in. I also set the max characters
        to the comment field to 512. By setting the email field to type email
        the browser will at least check for something that resembles an email
        address when the user enters something.
        <br>
        I opted to keep the same layout style for all three themes on the 
        site for the sake of consistency. I did change the colors and the 
        level of transparency for each of the three themes though, as well as
        the back ground. i had hoped to make the default selection on the 
        theme selector dropdown box be the current theme, but couldn't seem
        to get it to work properly. I've added it to the list of technical 
        debt for the site.
        <br>
        I left the "document.getElementById(this).className = "tab selected";"
        script in each html page because it seemed to generate errors if I 
        moved it to the central javascript page.
    </p>
    <h2><a id="lab5">Lab 5 Display Data</a></h2>
    <p>
        I ran into several issues with Firefox not refreshing the css files
        as I changed them unless I specifically went to the url of the css
        file itself. This really slowed down the process of checking color
        combinations. Interestingly, this was not an issue in chrome.
        <br>
        As of this lab all the tabs work except for the "Search" tab. The
        creation of the three new pages was mostly copying the working code
        from webusersview.java and editting it as appropriate for the two
        other sites. I looked for places to consolidate java code into a 
        seperate class but the few places I saw the possibility seemed that
        it would have added more complexity then was necessary to save a few
        lines of code. The place where I see a lot of redundant code is in
        the three css files. I'm not sure if there is a way to consolidate 
        those files into one larger file and have the three individual ones 
        just specify the particular colors and other minor differences. I 
        suppose that is a project for future free time.
        <br>
        I still seem to be getting errors from the javascript I talked about
        in the last lab even with the same code in each page. I'm approaching
        the submission deadline, so I am leaving it in place, since it doesn't
        seem to be affecting the site.
    </p>
    <h2><a id="lab6">Lab 6 Delete</a></h2>
    <p>
        The only issue that I had with this lab was an attempt to move the 
        sample javascript for deleting into the myscript.js file. But, I was
        unable to figure out how to reference the document when the javascript
        was not running from the page in question.
        <br>
        I removed some commentted out code that was in the sample code 
        provided for us.
    </p>
    <h2><a id="lab7">Lab 7 Insert</a></h2>
    <p>
        I didn't have any issues with this lab. Everything seems to be working
        properly. I had wanted to implement the extra credit, but unfortunately
        other school projects that are more pressing have prevented me. As such
        I have appended an additional sentence to the error message from a bad
        user role to help the user understand what is going on. I still hope to
        have the drop down implemented before the semester ends.
    <p>
        This version of the site does not yet contain the challenge.
    <h2><a id="lab8">Lab 8 Update Ajax</a></h2>
    <p>
        I also didn't have any issues with this lab. The sample code provided
        a good basis for creating the code. I have cleaned up several of the
        error and output messages to be more user friendly as well as removing
        the dialog boxes related to the JSON data requests. I also looped through
        all of the jsp pages and added database close statements where ever they 
        were needed.
    </p>
    <h2><a id="lab9">Lab 9 Logon</a></h2>
    <p>
        I did not have time to implement the encryption for this lab. I did
        create the seperate register page which asks the potential user for
        a smaller set of information and by default sets the role to 4, which
        has the lowest privledge.
    </p>
    <p>
        For this lab I also updated the users.jsp page to use HTML 5 validations in the
        form. This includes changing the input types to "email", "date", and "number" where
        appropriate. I belive this will make the site slightly more responsive as it adds
        an initial layer of rudimentary checking that doesn't require a round trip to the
        server to verify the data if it is wildly incorrect.
    </p>
    <h2><a id="lab10">Lab 10 Insert Associative</a></h2>
    <p>
        This lab did take me a little longer than the last labs did. This wasn't
        because it was any harder, but rather because it required me to pull 
        together all of the different parts that I have been working on through
        out the semester and put them together in a slightly different order. 
        During this lab I also started the process of a final code inspection 
        and cleanup to prepare for the final submission.
    </p>
    <p>
        I did make one deviation from the lab specs. Instead of creating a 
        separate class to hold the insert for the associative table, I placed
        the code in the TripReportsMods class. I made this decision for two reasons: 
        1. that class already existed and it seemed better to group related 
        functionality than to create an extra file.
        2. this mirrors the design of the *Mods classes for the other two tables.
    </p>
    <h2><a id="chal1">My Challenge</a></h2>
    <p>
        For the challenge I opted to do the CSS challenge because that I felt that
        was the part of web programming that I was least familar with after this
        pas semester. Betweent the documentation and the wc3 resources, I did not
        have any issues implementing this challenge. I estimate that it probably 
        took me about 90 minutes, not counting the selection of colors that 
        matched the existing style sheets.
    </p>

    <jsp:include page="post-content.jsp" />
