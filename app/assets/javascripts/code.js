var pathArray;
var myURL = window.location.hostname;

function expandAll() {
    $('.panel-collapse:not(".in")').collapse('show');
    $('.panel-collapse').addClass('in');

}

$(document).on('turbolinks:load', function(){
    if(navigator.platform.match('Mac') !== null) {
        document.body.setAttribute('class', 'OSX');
    }
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

    // $(".docDelete").click(function(){
    //     $(this).closest("tr").remove();
    //     console.log('deleted');
    //     //$(".alerts").append("<div class='alert alert-success'> Document Successfully Deleted </div>");
    // });

    $("tbody").unbind('click').on("click",'.touch a', function(){
        $(this).closest("tr").remove();
        console.log('deleted');
        $(".alerts").html("<div class='alert alert-success'> Successfully Deleted </div>");
    });


    $('#student_firstName').on('keyup',function(){
        var text = $(this).val();
        $(".side_bar .user h2").html(text);
    });

    $('#course_history_number').on('keyup',function(){
        var text = $(this).val();
        if(text == ""){  console.log('cleaning num'); $('#course_history_name').val("") }

    });

    $('#course_history_name').on('keyup',function(){
        var text = $(this).val();
        alert(text);
        if(text == ""){  console.log('cleaning nam'); $('#course_history_number').val("") }

    });

    $('#student_PID').on('keyup',function(){
        var text = $(this).val();
        $(".side_bar .user h6").html(text);

        if($("#student_PID").val().trim().length == 9){
            $(this).css('background-color', "#CBF3CD");
        } else {
            $(this).css('background-color', "#F7BCD4");
        }

    });

    $('#student_intendedDegree').on('keyup',function(){
        var text = $(this).val();
        $(".side_bar .user h5").html(text);
    });

    $("#jobs_button").click(function(){
        $("#jobs ul.nav li:nth-child(1) a").tab('show');
    });

    $(".searchBox #PID").click(function() {
        $('.searchBox #lastName').val('');
    });

    $(".searchBox #lastName").click(function() {
        $('.searchBox #PID').val('');
    });


    // Document form doesn't always reset, so this forces a reset on page load.
    $('#new_document')[0].reset();

});





