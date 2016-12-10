$(document).on('turbolinks:load', function() {

    var dropDown;
    //Typeahead stuff. Original framework created and maintained by Twitter
    var courseSearchName = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: document.location.origin + '/course_descriptions/typeahead/%name',
            wildcard: '%name',
            filter: function(response) {
                var results = [];
                dropDown = response;
                console.log(JSON.stringify(response));
                for(var i = 0; i < response.length; i++){
                    results.push(response[i].name);
                }
                console.log(JSON.stringify(results));
                return results;
            }
        },
        limit : 5
    });

    var courseSearchBoth = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: document.location.origin + '/course_descriptions/typeahead/%both',
            wildcard: '%both',
            filter: function(response) {
                var results = [];
                dropDown = response;
                console.log(JSON.stringify(response));
                for(var i = 0; i < response.length; i++){
                    results.push(response[i].course);
                }
                console.log(JSON.stringify(results));
                return results;
            }
        },
        limit : 5
    });

    var courseSearchNumber = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: document.location.origin + '/course_descriptions/typeahead/%QUERY',
            wildcard: '%QUERY',
            filter: function(response) {
                var results = [];
                dropDown = response;
                console.log(JSON.stringify(response));
                for(var i = 0; i < response.length; i++){
                    results.push(response[i].number);
                }
                console.log(JSON.stringify(results));
                return results;
            }
        },
        limit : 5
    });

    $('#course_history_name').typeahead({hint: false}, {
        name: 'countries',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseSearchName.ttAdapter()
    });

    $('#course_history_name').bind('typeahead:select', function(ev, suggestion) {
        console.log(dropDown[0]);
        console.log('Selection: ' + suggestion);
        for(var i = 0; i < dropDown.length; i++){
            console.log(dropDown[i][suggestion]);
            if(dropDown[i].name == suggestion){
                $("#course_history_number").val(dropDown[i].number);
            }
        }

    });

    $('#course_history_number').typeahead({hint: false}, {
        name: 'courseNumbers',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseSearchNumber.ttAdapter()
    });

    $('#course_history_number').bind('typeahead:select', function(ev, suggestion) {
        console.log(dropDown[0]);
        console.log('Selection of Number ' + suggestion);
        for(var i = 0; i < dropDown.length; i++){
            console.log("Possible " + dropDown[i].number);
            if(dropDown[i].number == suggestion){
                //$("#course_history_number").val(dropDown[i].number);
                $("#course_history_name").val(dropDown[i].name);

            }
        }

    });

    $('#job_course').typeahead({hint: false}, {
        name: 'course',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseSearchBoth.ttAdapter()
    });

    var courseFaculty = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        //prefetch: document.location.origin + '/faculties/typeahead/suggestions.json',
        remote: {
            url: document.location.origin + '/faculties/typeahead/%QUERY',
            wildcard: '%QUERY',
            filter: function(response) {
                return response;
            }
        },
        limit : 5
    });

    $('#course_description_teacher').typeahead({minLength: 1,hint: false}, {
        name: 'faculty',
        displayKey: function(countries) {
            //console.log(countries);
            return countries;
        },
        source: courseFaculty.ttAdapter()
    });

    $('#student_advisor').typeahead(null, {
        name: 'advisor',
        displayKey: function(countries) {
            //console.log(countries);
            return countries;
        },
        source: courseFaculty.ttAdapter()
    });
});