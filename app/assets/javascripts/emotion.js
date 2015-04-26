setTimeout(function() {
    $('#video-btn').show();
}, parseInt('<%= $gConfigData.time %>') * 1000);