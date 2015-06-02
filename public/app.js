$(document).ready(function(){
  // config
  var videoWidth = 640;
  var videoHeight = 480;

  // setup
  var stream;
  var audio_recorder = null;
  var video_recorder = null;
  var recording = false;
  var playing = false;
  var formData = null;

  // set the video options
  var videoOptions = {
    type: "video",
    video: {
      width: videoWidth,
      height: videoHeight
    },
    canvas: {
      width: videoWidth,
      height: videoHeight
    }
  };

  navigator.getUserMedia({audio: true, video: { mandatory: {}, optional: []}}, function(pStream) {

    stream = pStream;
    // setup video
    video = $("video.recorder")[0];

    video.src = window.URL.createObjectURL(stream);
    video.width = videoWidth;
    video.height = videoHeight;

    // init recorders
    audio_recorder = RecordRTC(stream, { type: "audio", bufferSize: 16384 });
    video_recorder = RecordRTC(stream, videoOptions);

    // update UI
    $("#record_button").show();
  }, function(){});

});