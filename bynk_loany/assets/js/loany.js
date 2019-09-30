// console.error("asdadas")

// function getFormData($form) {
//     var unindexed_array = $form.serializeArray();
//     var indexed_array = {};

//     $.map(unindexed_array, function (n, i) {
//         indexed_array[n['name']] = n['value'];
//     });

//     final_arr = { "user": indexed_array }
//     return final_arr;
// }

// $("form").submit(function(e){
//     console.log('here')
//     e.preventDefault();
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
//         success: function (data) {
//             console.error(data)
//             alert("success!");
//         },
//         error: function () {
//             alert('error!');
//         }
//     });
// });

$(document).ready(function(){
    onSubmitLoanyForm = () => {
        $('.loanyApplicationForm').hide();
        $('.loanyLoader').show();
        $.ajax({
            type: 'POST',
            url: "https://reqres.in/api/register", // For 404
            // url: "https://reqres.in/api/user", // For 200
            data: $('#loanyForm').serialize(),
            success: function(response) {
                $('.loanyLoader').hide();
                $('.loanySuccessFormContent').show();
                // Filling server Info
                $('.loanySuccessFormContent .loanySuccessFormContentLoanAmount h3').append(`${response.id}%`)
                $('.loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(1)').append(`${response.name}`)
                $('.loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(2)').append(`${response.email}`)
                $('.loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(3)').append(`${response.phone}`)
                $('.loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(4)').append(`${response.requestAmount}`)
            },
            error: function(errorRes) {
                const {responseJSON:{error}} = errorRes;
                console.log(error);
                $('.loanyLoader').hide();
                $(".loanyFailureFormContent").show();
                setTimeout(() => tryAgain(),3000);
            }
        });
    }

    tryAgain = () => {
        //ONly show from
        $('.loanyFailureFormContent').hide();
        $('.loanySuccessFormContent').hide();
        $('.loanyApplicationForm').show();
        $("#loanyForm").trigger('reset');
    }
});