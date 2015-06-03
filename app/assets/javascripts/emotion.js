var recording_for=$('#recording_time').val()
setTimeout(function() {
    $('#video-btn').show();
    $('.action_note').show();
    $('.note').hide();
}, (parseInt(recording_for) + 1) * 1000);


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