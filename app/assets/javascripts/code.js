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

function validateDocs(){

    var selected =($("#document_title option:selected").text());
    console.log(" s  " + selected)
    $( ".doc_title" ).each(function( index ) {
        console.log(selected == $(this).text());
        var text = $( this ).text();
        if(selected.replace(/\s+/g, '') === text.replace(/\s+/g, '')){
            return confirm("Note that uploading this file will overwrite an existing one!");
        }
    });

    return true;
}

