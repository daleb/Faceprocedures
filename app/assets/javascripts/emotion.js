var recording_for=$('#recording_time').val()
setTimeout(function() {
    $('#video-btn').show();
}, (parseInt(recording_for) + 1) * 1000);