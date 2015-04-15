
$(document).ready(function(){
	$('.survey').hide();
});

setTimeout(function() {
		$('.score').hide();
		if($('#exit_flag').val()=="exit_poll"){
			alert("hii")
			$('.exit_button').show();
			$('.survey').hide();
		}
		else{
		$('.survey').show();
		}
}, 10000);


$('button').click(function() {
	$('.score').hide();
	$('.exit_button').hide();
	if ($(this).val() == "submit"){
		var option=($('input[name=user_option]:checked').val());
		$.ajax({
        url: "/save_survey_details",
        data: { value: option},
        type: 'get', 
        success: function(result){
           window.location.href="/calculate_round";
    }
        });
	}
});
