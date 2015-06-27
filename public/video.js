/**
 * Created by Dale on 5/27/2015.
 */

var counter;
var enableCounter = false;
var recordRTC;
var videoPlayback;
var videoLive;
var refid = 1;
var videoList = [];
var record_time;
var indexedDB;
var db;
var refcount;
var part_id;
var recording_for;
var round;

const MIME_TYPE = "video/webm";

var videoConstraints = {
    video: {
        mandatory: {
            minWidth: 1280,
            minHeight: 720
        }
    },
    audio: true
};

var record_options = {
    type: "video",
    video: {
        width: 1280,
        height: 720,
        framerate: 60
    },
    canvas: {
        width: 1280,
        height: 720
    }
};

navigator.getUserMedia = (navigator.getUserMedia ||
navigator.webkitGetUserMedia ||
navigator.mozGetUserMedia ||
navigator.msGetUserMedia);


// DOM ready for event hooking
$(function () {
    navigator.getUserMedia(videoConstraints, startRecording, onfailure);
    videoLive = document.getElementById("video-view");
    videoPlayback = document.getElementById("video-playback");
    $("#videodiv").hide();
    dataStorageSetup();
    refcount = $('#count_number').val();
    record_time = $('#recording_time').val();
    starttimingfunctions();
    part_id = localStorage.getItem('partid');
    recording_for = $('#recording_for').val();
    round = $('#roundnumber').html();
    console.log("Round from roundnumber = " + round);
});

function start() {
    navigator.getUserMedia(videoConstraints, startRecording, onfailure);
}

function onfailure() {
    console.log("Failed to get camera");
}


function dataStorageSetup() {
    console.log("Calling dataStorageSetop function...");
    indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    var request = indexedDB.open("videoFiles", 1);

    request.onupgradeneeded = function (event) {
        console.log("Calling upgrade");
        db = event.target.result;
        var objectStore = db.createObjectStore("videos", {keyPath: "fid"});
        console.log("Success creating IndexedDB database videodb");
    };
    request.onsuccess = function (event) {
        console.log("Success opening IndexedDB database videodb");
        db = event.target.result;
        db.onerror = function (event) {
            console.log("Error creating/opening IndexedDB database videodb");
        };
    };

}

function addVideoToDb(fid, blob) {
    console.log("Putting video in IndexedDB");
    // Open a transaction to the database
    var transaction = db.transaction(["videos"], "readwrite");
    // Put the blob into the dabase
    var additem = transaction.objectStore("videos").put({fid: fid, video: blob, partid: part_id, recordfor: recording_for, round: round } );
    transaction.oncomplete = function (event) {
        // Must do page navigation outside of transaction
        setTimeout(finishscreen, 5000);
        console.log("Video added into the DB id = " + fid);
    };
}

function finishscreen() {
    // This is run from a setTimeout when the DB transaction finishes.
    // The reason for this is we can not navigate from the transaction complete
    // without aborting the transaction.
    console.log("Finishscreen has been triggered.");
    var xhr = new XMLHttpRequest();
    var sync = $('#coming_from').val() == "result" ? false : true;
    if (recording_for == "statement_recording") {
        console.log("Enableing action buttons.");
        $('#video-btn').show();
        $('.action_note').show();
        $('.note').hide();
    }
    xhr.open("POST", "/participant/savedfilelocal?part_id=" + part_id + "&recording_for=" + recording_for, sync);
    xhr.send();
    if ($('#coming_from').val() == "result") {
        console.log("Leaving results screen.");
        window.location.href = "/participant?from=vdo";
    }

}

function startRecording(mediaStream) {
    console.log("startRecording called with record_time = " + record_time * 1000);
    recordRTC = RecordRTC(mediaStream, record_options);
    setTimeout(stop, record_time * 1000);
    recordRTC.startRecording();
}

function stop() {
    recordRTC.stopRecording(playback);
}
function replay(idx) {
    playvideo(videoList[idx]);
}

function playback(stream) {
    //playvideo(stream);
    console.log("enter playback");
    console.log(stream);
    var recordedBlob = recordRTC.blob;
    console.log("recordedBlob size = " + recordedBlob.size / 1024);
    console.log("recordedBlob type = " + recordedBlob.type);
    addVideoToDb(refcount, recordedBlob);
}


function oldplayback(stream) {
    //playvideo(stream);
    var fileType = 'video';
    var fileName = 'ABCDEF.webm';
    var recordedBlob = recordRTC.getBlob();
    var xhr = new XMLHttpRequest();
    var fd = new FormData();
    var part_id = $('#part_id').val();
    var recording_for = $('#recording_for').val();
    fd.append("video-blob", recordedBlob);
    sync = $('#coming_from').val() == "result" ? true : true;
    xhr.open("POST", "/participant/save?part_id=" + part_id + "&recording_for=" + recording_for, sync);
    xhr.send(fd);

    //var recordedBlob = recordRTC.getBlob();
    //var formData = new FormData();  formData.append(fileType + '-filename', fileName);formData.append(fileType + '-blob', recordRTC.getBlob()); xhr('save', formData, function (fName) { window.open(location.href + fName); }); function xhr(url, data, callback) { var request = new XMLHttpRequest(); request.onreadystatechange = function () { if (request.readyState == 4 && request.status == 200) { callback(location.href + request.responseText); } }; request.open('POST', url,{timeout: 3000}); request.send(data); }
    // $("#links").append("<a id=lk" + refid + " href=" + stream +  "  download= " + fileName + "> Download Video " + refid + " </a> <br>" );
    //videoList[refid]= stream;
    //var bname = "Replay_Video_" + refid;
    // $("#views").append("<input type=button id=vw" + refid + " onclick=replay(" + refid + ") value=" + bname + "> <br>");
    refid += 1;
}


function playvideo(stream) {
    videoPlayback.src = stream;
    videoPlayback.play();
}

$(document).ready(function () {
    $('.score').hide();
    $('.options').hide();
    $('.survey').hide();
    $('#video-btn').hide();
    $('#waitmsgone').hide();
    $('.hourclass').show();
    if ($('#coming_from').val() != "result") {
        $('.hourclass').hide();
    }
    $('.action_note').hide();
    record_time = $('#recording_time').val();
});

$('button').click(function () {
    if ($(this).val() == "submit") {
        var option = ($('input[name=user_option]:checked').val());
        $.ajax({
            url: "/save_survey_details",
            data: {value: option},
            type: 'get',
            success: function (result) {
                window.location.href = "/calculate_round";
            }
        });
    }
});


function starttimingfunctions(){
    setTimeout(showscore, (record_time / 2) * 1000);
    setTimeout(showwaitmsg, (record_time + 2) * 1000);
}

function showscore(){
    console.log("Timeout 1 called - " + $('#coming_from').val());
    if ($('#coming_from').val() == "result") {
        $('.hourclass').hide();
        $('.score').show();
    }
}

function showwaitmsg(){
    console.log("Timeout 2 called - " + $('#coming_from').val());
    if ($('#coming_from').val() == "result") {
        $('#waitmsgone').show();
    }
}

