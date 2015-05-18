/**
 * Created by Dale on 5/2/2015.
 */

var timerint;
var controllername;
var clickquiz;
var clickrecord;
var clicksplit;
var takeall;
var clickreadytosee;
var clickreadytosee2;
var clickreadytosee3;
var clickokbutton;
var clickadjust;
var autoplay;



$((function () {
    clickquiz = true;
    clickrecord = true;
    clicksplit = true;
    takeall = true;
    clickreadytosee = true;
    clickreadytosee2 = true;
    clickreadytosee3 = true;
    clickokbutton = true;
    clickadjust = true;
    var autoplayraw = jQuery.trim($("#autoplayflag").html());
    if (autoplayraw == null){
        autoplay = false;
    }else if (autoplayraw == "false"){
        autoplay = false;
    }else if (autoplayraw == "true"){
        autoplay = true;
    }else{
        autoplay = false;
    }

    startautoplay();
}));


function startautoplay() {

    //var newtime = Math.floor(Math.random() * 8000) + 2;
    var newtime = 10000;
    setTimeout("autoplayscreen()", newtime);
}

function autoplayscreen() {
    if (autoplay) {
        if (controllername == "questions") {
            autoplayquiz();
        }
        if (controllername == "statements") {
            autoplaystatements();
        }
        if (controllername == "participant") {
            autoplayparticipant();
        }
        if (controllername == "results") {
            autoplayresuts();
        }
        if (controllername == "survey"){
            autoplaysurvey();
        }
        if (controllername == "participantinfo"){
            autoplayinfo();
        }
    }
    startautoplay();
}


function autoplayquiz() {
    if ($("#question_1_1").is(":visible")) {
        $("#question_1_1").click();
        clickbtn();
    } else if ($("#question_2_1").is(":visible")) {
        $("#question_2_1").click();
        clickbtn();
    } else if ($("#question_3_1").is(":visible")) {
        $("#question_3_1").click();
        clickbtn();
    } else if ($("#question_4_1").is(":visible")) {
        $("#question_4_1").click();
        clickbtn();
    } else if ($("#question_5_1").is(":visible")) {
        $("#question_5_1").click();
        clickbtn();
    } else if ($("#question_6_1").is(":visible")) {
        $("#question_6_1").click();
        clickbtn();
    }
}

function clickbtn() {
    if ($('.save_button').is(":visible")) {
        if (clickquiz){
            $("#quizform").submit();
            clickquiz = false;
        }
    }
    else {
        $(".next").click();
    }
}

function autoplaystatements() {
    if ($("#record").is(":visible")) {
        if (clickrecord){
            $("#record").click();
            clickrecord = false;
        }
    }
}

function autoplayparticipant()
{
    if ($("#adjust").is(":visible")){
        if (clickadjust){
            $("#adjbtn")[0].click()
            clickadjust = false;
        }
     }

    if ($("#split").is(":visible")) {
        if (clicksplit){
            $("#split").click();
            clicksplit = false;
        }
    }
    else if ($("#takeall").is(":visible")) {
        if (clicktakeall){
            $("#takeall").click();
            clicktakeall = false;
        }
    }
    else if($("#readytosee").is(":visible")) {
        if (clickreadytosee) {
            $("#readytosee").click();
            clickreadytosee = false;
        }
    }
}

function autoplayresults()
{

   if($("#readytosee").is(":visible")){
       if (clickreadytosee2) {
           $("#readytosee").click();
           clickreadytosee2 = false;
       }
    }
}


function autoplaysurvey(){
    if ($("#moderately_1").is(":visible")){
        $("#moderately_1").click();
    }
    if ($("#moderately_2").is(":visible")){
        $("#moderately_2").click();
    }
    if ($("#moderately_3").is(":visible")){
        $("#moderately_3").click();
    }
    if ($("#moderately_4").is(":visible")){
        $("#moderately_4").click();
    }
    if ($("#moderately_5").is(":visible")){
        $("#moderately_5").click();
    }
    if ($("#moderately_6").is(":visible")){
        $("#moderately_6").click();
    }
    if ($("#moderately_7").is(":visible")){
        $("#moderately_7").click();
    }
    if ($("#moderately_8").is(":visible")){
        $("#moderately_8").click();
    }
    if ($("#moderately_9").is(":visible")){
        $("#moderately_9").click();
    }
    if ($("#moderately_10").is(":visible")){
        $("#moderately_10").click();
    }
    if ($("#moderately_11").is(":visible")){
        $("#moderately_11").click();
    }
    if ($("#moderately_12").is(":visible")){
        $("#moderately_12").click();
    }
    if ($("#moderately_13").is(":visible")){
        $("#moderately_13").click();
    }
    if ($("#moderately_14").is(":visible")){
        $("#moderately_14").click();
    }
    if ($("#moderately_15").is(":visible")){
        $("#moderately_15").click();
    }
    if ($("#moderately_16").is(":visible")){
        $("#moderately_16").click();
    }
    if ($("#moderately_17").is(":visible")){
        $("#moderately_17").click();
    }
    if ($("#moderately_18").is(":visible")){
        $("#moderately_18").click();
    }
    if ($("#moderately_19").is(":visible")){
        $("#moderately_19").click();
    }
    if ($("#moderately_20").is(":visible")){
        $("#moderately_20").click();
    }
    if ($("#okbutton").is(":visible")){
        if (clickokbutton) {
            $("#okbutton").click();
            clickokbutton = false;
        }
    }
    if($("#readytosee").is(":visible")){
        if (clickreadytosee3) {
            $("#readytosee").click();
            clickreadytosee3 = false;
        }
    }

}

function autoplayinfo()
{
    if($("#submitbutton").is(":visible")){
        $("#namef").val("USERS FIRST NAME");
        $("#namel").val("USERS LAST NAME");
        $("#age").val("25");
        $("#submitbutton").click();
    }

}