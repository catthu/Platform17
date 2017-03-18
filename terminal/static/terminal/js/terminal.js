// Keep focus on the input field

$(document).ready( function() {
        // After page load, focus on input field
        $("#input-text").focus()

        // Event listener for input submission
        form = document.getElementById("input-form");
        form.onsubmit = function(e) {
            e.preventDefault();
            var xhttp = new XMLHttpRequest();
            query = document.getElementById("input-text").value;
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    res = JSON.parse(xhttp.response);
                    console.log(res.response_text);
                }
            };
            url = "/search/?room=" + query;
            xhttp.open("GET", url, true);
            xhttp.send();
    
};
});


$(document).click( function() {
    // Focus on input field when clicking anywhere on console
    $("#input-text").focus(); 
});


// Print stuff to console

if (typeof console  != "undefined") 
    if (typeof console.log != 'undefined')
        console.olog = console.log;
    else
        console.olog = function() {};

var result = $('#console');

console.log = function(message) {
    console.olog(message);
    $('#console-old').append('<br />' + message + '<br />');
      result.focus();
    placeCaretAtEnd( document.getElementById("console") );
};
console.error = console.debug = console.info =  console.log

function ScrollToBottom() {
            $("html, body, #console").animate({ scrollTop: $(document).height()}, "slow");
            return false;
};

function placeCaretAtEnd(el) {
    var cursor = $('#input-text');
    cursor.val('');
    cursor.focus();
    ScrollToBottom();
}

