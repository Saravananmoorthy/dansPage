/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
  $("#clickableHeaderOne").click(function(){
    $("#pOne").slideToggle();
  });
  $("#clickableHeaderTwo").click(function(){
      $("#pTwo").slideToggle();
  });
});


// apply “tab selected” to the element with id “home”
document.getElementById(this).className = "tab selected";

function changeStyle(choice) {
    // choice is the select list, an object, which has a value property
    // alert ("user choice is " + choice.value);
    document.getElementById('cssLinkID').href = choice.value;
}

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