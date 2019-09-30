console.error("asdadas")

var settings = {
    "async": true,
    "crossDomain": true,
    "url": "http://localhost:4005/api/users",
    "method": "POST",
    "headers": {
        "Content-Type": "application/json",
        "cache-control": "no-cache",
        "Postman-Token": "0ea0000f-aa75-4df5-9510-8aa2a98571f9"
    },
    "processData": false,
    "data": "{\"user\": {\"email\": \"some@email.com\", \"password\": \"some password\" }}"
}

function getFormData($form) {
    var unindexed_array = $form.serializeArray();
    var indexed_array = {};

    $.map(unindexed_array, function (n, i) {
        indexed_array[n['name']] = n['value'];
    });

    final_arr = { "user": indexed_array }
    return final_arr;
}

$("form").submit(function(e){
    console.log('here')
    e.preventDefault();
    console.log('clicked')
    var form_data = $('form').serialize()
    console.log(form_data)
    var $form = $("form");
    var data = getFormData($form);
    console.log(data)
    // $.ajax(settings).done(function (response) {
    //     console.log(response);
    // });
    $.ajax({
        type: 'POST',
        url: '/api/users',
        data: data,
        dataType: "json",
        success: function (data) {
            console.error(data)
            alert("success!");
        },
        error: function () {
            alert('error!');
        }
    });
});

// document.getElementById("#submit_button").addEventListener("click", function () {
//     console.log('clicked')
//     var form_data = $('form').serialize()
//     console.log(form_data)
//     var $form = $("form");
//     var data = getFormData($form);
//     console.log(data)
//     // $.ajax(settings).done(function (response) {
//     //     console.log(response);
//     // });
//     $.ajax({
//         type: 'POST',
//         url: '/api/users',
//         data: data,
//         dataType: "json",
//         success: function () {
//             alert("success!");
//         },
//         error: function () {
//             alert('error!');
//         }
//     });
// });
