var recording_for=$('#recording_time').val()
setTimeout(function() {
    $('#video-btn').show();
    $('.action_note').show();
    $('.note').hide();
}, (parseInt(recording_for) + 1) * 1000);