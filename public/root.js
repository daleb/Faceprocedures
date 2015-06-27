/**
 * Created by Dale on 5/26/2015.
 */

var indexedDB;
var database;
var refcount;
var part_id;
var roundlist = [];
var recordlist = [];
var uploaddone = false;
var filelist = [];
var sendfilerunning = false;

$(document).ready(function () {
    $('.thanks').hide();
    part_id = localStorage.getItem('partid');
    console.log("Participant ID = " + part_id);
    dataStorageSetup();
    setTimeout(getAllFiles, 5000);
});

function getAllFiles() {
    console.log("Participant ID = " + localStorage.getItem('partid'));
    setTimeout(getAllVideosFromDb, 10000);
    console.log("Done loading page.");
}

function getCallback(fid, vdo, partid, recordfor, round) {
    console.log("getCallback(vdo) fid = " + fid + " partid = " + partid + " recordfor = " + recordfor + " round = " + round);
    roundlist.push(round);
    recordlist.push(recordfor);
    var xhr = new XMLHttpRequest();
    xhr.open('GET', vdo, true);
    xhr.responseType = 'blob';
    xhr.onloadend = function(){
        console.log("Enter xhr.onloadend");
        setTimeout(sendfiles(), 2000);
    };
    xhr.onload = function () {
        console.log("Enter xhr.onload");
        console.log("status = " + this.status);
        console.log("statusText = " + this.statusText);
        console.log("readyState = " + this.readyState);
        if (this.readyState == 4) {
            if (this.status == 200) {
                var myBlob = this.response;
                var round = roundlist.shift();
                var recording_for = recordlist.shift();
                console.log("Blob size = " + myBlob.size / 1024);
                console.log("Blob type = " + myBlob.type);
                var xhr1 = new XMLHttpRequest();
                var fd = new FormData();
                fd.append("video-blob", myBlob);
                console.log("POST", "/participant/save?part_id=" + partid + "&recording_for=" + recordfor + "&round=" + round);
                xhr1.open("POST", "/participant/save?part_id=" + partid + "&recording_for=" + recordfor + "&round=" + round, true);
                console.log("Sending");
                xhr1.send(fd);
            }
        }
        console.log("Leaving xhr.onload");
    };
    xhr.send(null);

}


function dataStorageSetup() {
    console.log("Calling dataStorageSetop function...");
    indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    var request = indexedDB.open("videoFiles", 1);

    request.onupgradeneeded = function (event) {
        console.log("Calling upgrade");
        database = event.target.result;
        var objectStore = database.createObjectStore("videos", {keyPath: "fid"});
        console.log("Success creating IndexedDB database videodb");
    };
    request.onsuccess = function (event) {
        console.log("Success opening IndexedDB database videodb");
        database = event.target.result;
        database.onerror = function (event) {
            console.log("Error creating/opening IndexedDB database videodb");
        };
    };

}

function sendfiles(){
    console.log("Enter sendfiles ");
    if (filelist.length > 0){
        getVideoFromDb(filelist.pop(), getCallback);
    }
    else{
        uploaddone = true;
        sendfilerunning = false;
    }
}

function getAllVideosFromDb(){
    // Retrieve the file that was just stored
    console.log("Calling getAllVideosFromDb");
    var transaction = database.transaction(["videos"], "readwrite");
    var request = transaction.objectStore("videos").openCursor().onsuccess = function(event) {
        var cursor = event.target.result;
        if (cursor) {
            console.log("DB id is " + cursor.key + " vidio id " + cursor.value.fid);
            console.log("filelist size = " + filelist.length);
            filelist.push(cursor.value.fid);
            cursor.continue();
        }
        else {
            console.log("No more entries!");
            console.log("Total number of videos = " + filelist.length);
        }
    };
}

function getVideoFromDb(fid, getCallback){
    // Retrieve the file that was just stored
    var transaction = database.transaction(["videos"], "readwrite");
    var request = transaction.objectStore("videos").get(fid);
    request.onsuccess = function (event) {
        console.log("getVideoFromDB transaction complete.");
        var blob = event.target.result.video;
        var partid = event.target.result.partid;
        var recordfor = event.target.result.recordfor;
        var round = event.target.result.round;
        console.log("Blob size = " + blob.size/1024);
        console.log("Blob type = " + blob.type);
        var blobUrl = URL.createObjectURL(blob);
        console.log("Got video!" + blobUrl);
        setTimeout(getCallback, 1000 ,fid, blobUrl, partid, recordfor, round);
    };
    request.onerror = function (event) {
        console.log("getVideoFromDb failed!!!");
    };
}



setTimeout(function () {
    $('.score_details').hide();
    $('.thanks').show();
}, 10000);