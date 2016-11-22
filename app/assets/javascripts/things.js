
var substringMatcher = function(strs) {
    console.log("working?");
    return function findMatches(q, cb) {
        var matches, substringRegex;

        // an array that will be populated with substring matches
        matches = [];

        // regex used to determine if a string contains the substring `q`
        substrRegex = new RegExp(q, 'i');

        // iterate through the pool of strings and for any string that
        // contains the substring `q`, add it to the `matches` array
        $.each(strs, function(i, str) {
            if (substrRegex.test(str)) {
                matches.push(str);
            }
        });

        cb(matches);
    };
};

var dropDown;

var courseSearch = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: document.location.origin + '/course_descriptions/typeahead/suggestions.json',
    remote: {
        url: document.location.origin + '/course_descriptions/typeahead/%QUERY',
        wildcard: '%QUERY',
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

var courseSearchNumber = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: document.location.origin + '/course_descriptions/typeahead/suggestions.json',
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


$(function(){
    $('#course_description_name').typeahead({hint: false}, {
        name: 'countries',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseSearch.ttAdapter()
    });
})

$(function(){
    $('#course_description_name').bind('typeahead:select', function(ev, suggestion) {
         console.log(dropDown[0]);
         console.log('Selection: ' + suggestion);
        for(var i = 0; i < dropDown.length; i++){
            console.log(dropDown[i][suggestion]);
           if(dropDown[i].name == suggestion){
               $("#course_description_number").val(dropDown[i].number);
           }
        }

    });
})

$(function(){
    $('#course_description_number').typeahead({hint: false}, {
        name: 'courseNumbers',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseSearchNumber.ttAdapter()
    });
})

$(function(){
    $('#course_description_number').bind('typeahead:select', function(ev, suggestion) {
        console.log(dropDown[0]);
        console.log('Selection of Number ' + suggestion);
        for(var i = 0; i < dropDown.length; i++){
            console.log("Possible " + dropDown[i].number);
            if(dropDown[i].number == suggestion){
                console.log("In the selection");
                $("#course_description_number").val(dropDown[i].number);
                $("#course_description_name").val(dropDown[i].name);

            }
        }

    });
})

$(function(){
    $('#job_course').typeahead(null, {
        name: 'countries',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseSearch.ttAdapter()
    });
})


var courseFaculty = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: document.location.origin + '/faculties/typeahead/suggestions.json',
    remote: {
        url: document.location.origin + '/faculties/typeahead/%QUERY',
        wildcard: '%QUERY',
        filter: function(response) {
            return response;
        }
    },
    limit : 5
});

$(function(){
    $('#course_description_teacher').typeahead(null, {
        name: 'faculty',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseFaculty.ttAdapter()
    });
})

$(function(){
    $('#student_advisor').typeahead(null, {
        name: 'faculty',
        displayKey: function(countries) {
            console.log(countries);
            return countries;
        },
        source: courseFaculty.ttAdapter()
    });
})
