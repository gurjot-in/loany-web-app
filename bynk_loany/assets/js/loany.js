$(document).ready(function() {
  onSubmitLoanyForm = () => {
    $(".loanyApplicationForm").hide();
    $(".loanyLoader").show();
    var form_data = $("form").serialize();
    var $form = $("form");
    var data = getFormData($form);
    $.ajax({
      type: "POST",
      url: "/api/users",
      data: data,
      success: function(response) {
        const {
          is_approved,
          rate_of_interest,
          email,
          phone_number,
          loan_amount,
          name
        } = response.data;
        if (is_approved) {
          $(".loanyLoader").hide();
          $(".loanySuccessFormContent").show();
          // Filling server Info
          $(
            ".loanySuccessFormContent .loanySuccessFormContentLoanAmount h3"
          ).append(`${rate_of_interest}%`);
          $(
            ".loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(1)"
          ).append(`${name}`);
          $(
            ".loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(2)"
          ).append(`${email}`);
          $(
            ".loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(3)"
          ).append(`${phone_number}`);
          $(
            ".loanySuccessFormContent .loanySuccessUserDetailsInfo h4:nth-child(4)"
          ).append(`SEK ${loan_amount}`);
        } else {
          showErrorPage();
        }
      },
      error: function(errorRes) {
        const { statusText } = errorRes;
        showErrorPage(statusText);
      }
    });
  };

  tryAgain = () => {
    //Only show from
    $(".loanyFailureFormContent").hide();
    $(".loanySuccessFormContent").hide();
    $(".loanyApplicationForm").show();
    $("#loanyForm").trigger("reset");
  };

  showErrorPage = (message = "It seems like we couldn't grant loan") => {
    $(".loanyLoader").hide();
    $(".loanyFailureFormContent").show();
    $(".loanyfailureFormContentLoanAmount h4").html(message);
    setTimeout(() => tryAgain(), 3000);
  };

  getFormData = ($form) => {
    var unindexed_array = $form.serializeArray();
    var indexed_array = {};

    $.map(unindexed_array, function(n, i) {
      indexed_array[n["name"]] = n["value"];
    });

    final_arr = { user: indexed_array };
    return final_arr;
  }
});
