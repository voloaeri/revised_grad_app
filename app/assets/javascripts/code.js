var pathArray;
var myURL = window.location.hostname;

function expandAll() {
    $('.panel-collapse:not(".in")').collapse('show');
    $('.panel-collapse').addClass('in');

}

$(document).ready(function(){
    var hash = window.location.hash.replace('#/', '');
    $(hash).click();
    $("#personal").click(function(){
        window.location.hash = "personal";
    });
    $("#reqs").click(function(){
        window.location.hash = "reqs";
    });
    $("#history").click(function(){
        window.location.hash = "history";
    });
    $("#docs").click(function(){
        window.location.hash = "docs";
    });
    $("#work").click(function(){
        window.location.hash = "jobs";
    });
    $("#button").click(function(){
        $("#documents ul.nav li:nth-child(1) a").tab('show');
    });

    $(".click").click(function(){
        $(".alerts").html("");
        $(".alert").html("");
    });
    
});



