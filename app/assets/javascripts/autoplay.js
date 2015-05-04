/**
 * Created by Dale on 5/2/2015.
 */

var timerint;
var controllername;

$((function () {
    startautoplay();
}));


function startautoplay() {
    var newtime = Math.floor(Math.random() * 5000) + 2;
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
        $("#quizform").submit();
    }
    else {
        $(".next").click();
    }
}

function autoplaystatements() {
    if ($("#record").is(":visible")) {
        $("#record").click();
    }
}

function autoplayparticipant()
{

    if ($("#split").is(":visible")) {
        $("#split").click();
    }
    else if ($("#takeall").is(":visible")) {
        $("#takeall").click();
    }
    else if($("#readytosee").is(":visible")){
        $("#readytosee").click();
    }
}

function autoplayresults()
{

   if($("#readytosee").is(":visible")){
        $("#readytosee").click();
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
        $("#okbutton").click();
    }
    if($("#readytosee").is(":visible")){
        $("#readytosee").click();
    }

}