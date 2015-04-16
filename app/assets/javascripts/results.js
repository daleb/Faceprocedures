
$(document).ready(function(){
	$('.survey').hide();
	$('.results').hide();
});

setTimeout(function() {
		$('.score').hide();
		if($('#exit_flag').val()=="exit_poll"){
			$('.exit_button').show();
			$('.survey').hide();
		}
		else{
        if($('#com_from').val()!="waiting_after_pick"){
		$('.survey').show();
		}
		}
}, 10000);

$('.click').click(function() {
	$('.results').show();
	$('.click').hide();
	$('.alert').hide();
});

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
           window.location.href="/participant?from=Waiting after emotion survey";
    }
        });
	}
});

$('input[type="submit"]').click(function() {
	if($('#name').val()=='')
	{
		alert("Please enter atleast 4 characters for Name!")
		return false;
	}
	else if($('#age').val()=='')
	{
		alert("Please Enter your age!")
		return false;
	}
	
});
