function startautoplay(){var e=Math.floor(5e3*Math.random())+2;setTimeout("autoplayscreen()",e)}function autoplayscreen(){autoplay&&("questions"==controllername&&autoplayquiz(),"statements"==controllername&&autoplaystatements(),"participant"==controllername&&autoplayparticipant(),"results"==controllername&&autoplayresuts(),"survey"==controllername&&autoplaysurvey()),startautoplay()}function autoplayquiz(){$("#question_1_1").is(":visible")?($("#question_1_1").click(),clickbtn()):$("#question_2_1").is(":visible")?($("#question_2_1").click(),clickbtn()):$("#question_3_1").is(":visible")?($("#question_3_1").click(),clickbtn()):$("#question_4_1").is(":visible")?($("#question_4_1").click(),clickbtn()):$("#question_5_1").is(":visible")?($("#question_5_1").click(),clickbtn()):$("#question_6_1").is(":visible")&&($("#question_6_1").click(),clickbtn())}function clickbtn(){$(".save_button").is(":visible")?$("#quizform").submit():$(".next").click()}function autoplaystatements(){$("#record").is(":visible")&&$("#record").click()}function autoplayparticipant(){$("#split").is(":visible")?$("#split").click():$("#takeall").is(":visible")?$("#takeall").click():$("#readytosee").is(":visible")&&$("#readytosee").click()}function autoplayresults(){$("#readytosee").is(":visible")&&$("#readytosee").click()}function autoplaysurvey(){$("#moderately_1").is(":visible")&&$("#moderately_1").click(),$("#moderately_2").is(":visible")&&$("#moderately_2").click(),$("#moderately_3").is(":visible")&&$("#moderately_3").click(),$("#moderately_4").is(":visible")&&$("#moderately_4").click(),$("#moderately_5").is(":visible")&&$("#moderately_5").click(),$("#moderately_6").is(":visible")&&$("#moderately_6").click(),$("#moderately_7").is(":visible")&&$("#moderately_7").click(),$("#moderately_8").is(":visible")&&$("#moderately_8").click(),$("#moderately_9").is(":visible")&&$("#moderately_9").click(),$("#moderately_10").is(":visible")&&$("#moderately_10").click(),$("#moderately_11").is(":visible")&&$("#moderately_11").click(),$("#moderately_12").is(":visible")&&$("#moderately_12").click(),$("#moderately_13").is(":visible")&&$("#moderately_13").click(),$("#moderately_14").is(":visible")&&$("#moderately_14").click(),$("#moderately_15").is(":visible")&&$("#moderately_15").click(),$("#moderately_16").is(":visible")&&$("#moderately_16").click(),$("#moderately_17").is(":visible")&&$("#moderately_17").click(),$("#moderately_18").is(":visible")&&$("#moderately_18").click(),$("#moderately_19").is(":visible")&&$("#moderately_19").click(),$("#moderately_20").is(":visible")&&$("#moderately_20").click(),$("#okbutton").is(":visible")&&$("#okbutton").click(),$("#readytosee").is(":visible")&&$("#readytosee").click()}var timerint,controllername;$(function(){startautoplay()});