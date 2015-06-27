/**
 * Created by Dale on 6/23/2015.
 */

var updatedatahash = {};
var timerint;


$((function () {
    $(function () {
            timerint = self.setInterval("remoteupdate()", 10000);
        }
    );
}));

function stopremoteupdate(){
    clearInterval(timerint);
}

function remoteupdatereturn(data){
    console.log("Enter remoteupdatereturn  partid = " + data.partid);
    console.log("localStorage partid = " + localStorage.getItem('partid'));
    console.log("uploaddone = " + uploaddone);
    console.log("sendfilerunning = " + sendfilerunning);
    if(data.partid == localStorage.getItem('partid') ){
        if (!uploaddone && !sendfilerunning){
            sendfilerunning = true;
            setTimeout(sendfiles(), 1000);
        }
    }
    else{
        if (uploaddone && !sendfilerunning){
            stopremoteupdate();
        }
    }
}

function remoteupdate(){
    console.log("Enter remoteupdate ");
    // This function is called as a periodic update of the page.
    // It sends and receives JSON onject and is not intended to do general
    // DOM update using RJS.
    updateremoteprep();
//    alert("controllername = [" + controllername + "]");
    $.post( "participant/fileupload", updatedatahash , function(data){
        remoteupdatereturn(data);}, "json" );
    updateremotesent();
}


function updateremoteprep(){
    //updatedatahash = {"item1" : 1, "item2" : [33,22,66] }
    updatedatahash.partid = localStorage.getItem('partid');
    updatedatahash.done = uploaddone;
}

function updateremotesent(){
    updatedatahash = {};
}