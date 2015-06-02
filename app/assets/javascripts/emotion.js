var recording_for=$('#recording_time').val()
setTimeout(function() {
    $('#video-btn').show();
    $('.action_note').show();
    $('.note').hide();
}, (parseInt(recording_for) + 1) * 1000);


$('#okbutton').click(function() {
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

setTimeout(function() {
    if ($('#coming_from').val() == "result"){
    	    $('.hourclass').hide();
        	$('.score').show();
    }
}, (recording_for / 2) * 1000);

setTimeout(function() {
    if ($('#coming_from').val() == "result"){
    	$('#waitmsgone').show();
         window.location.href="/participant?from=vdo";
    }
}, (parseInt(recording_for) + 2) * 1000);