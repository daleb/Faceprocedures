$(document).ready(function(){$(".results").show(),$(".score").hide(),getcontrollername()}),setTimeout(function(){$(".score").hide(),"exit_poll"==$("#exit_flag").val()||"waiting_after_pick"==$("#com_from").val()?$(".survey").hide():("vdo"==$("#com_from").val()||"?from=vdo"==window.location.search)&&(console.log("i am going to show survey!!"),$(".survey").show())},100),$("button").click(function(){if($(".score").hide(),"submit"==$(this).val()){var e=parseInt($("#survey_length").val());flag=!0;for(var a=[],t=1;e>=t;t+=1){var o=$("input[name=user_"+t+"_option]:checked").val();void 0==o?flag=!1:a.push(o)}if(0==flag)return alert("Please choose option for all the statements to complete survey!"),!1;$.ajax({url:"/save_survey_details",data:{value:a},type:"get",success:function(){window.location.href="/participant?from=Waiting after emotion survey"}})}}),$('input[type="submit"]').click(function(){return""==$("#name").val()||$("#name").val().length<1?(alert("Please enter your name!"),!1):""==$("#age").val()||0==$.isNumeric($("#age").val())?(alert("Please Enter your age in Numeric!"),!1):""==$("#language").val()?(alert("Please enter your first language!"),!1):void 0});