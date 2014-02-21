/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $("#clickableHeaderOne").click(function() {
        $("#pOne").slideToggle();
    });
    $("#clickableHeaderTwo").click(function() {
        $("#pTwo").slideToggle();
    });
});

function setTheme() {
    styleSheetName = readCookie("theme");
    if (styleSheetName) {
        document.getElementById("cssLinkID").href = styleSheetName;
    };
}

function changeTheme(styleSheetFileName) {
    document.getElementById("cssLinkID").href = styleSheetFileName;
    createCookieNoPopUp("theme", styleSheetFileName, 30);
}

//an attempt to get the selector to default to the current theme. Borrowed from
//http://stackoverflow.com/questions/7373058/how-to-change-the-selected-option-of-html-select-element
//currently not working; to be properly implemented.
$('#themeSelector').each(function() {
    var $this = $(this); // cache this jQuery object to avoid overhead

    if ($this.val() === styleSheetName) { // if this option's value is equal to our value
        $this.prop('selected', true); // select this option
        return false; // break the loop, no need to look further
    }
});

function createCookie(name, value, days) {
    alert("Creating a cookie with name " + name + " and value " + value + " that will last " + days + " days");
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else
        var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function createCookieNoPopUp(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else
        var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ')
            c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0)
            return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}
function showCookie(name) {
    var cookieVal = readCookie(name);
    if (cookieVal === null) {
        alert("No cookie value was stored with name " + name);
    } else {
        alert("The cookie named " + name + " has value " + cookieVal);
    }
}