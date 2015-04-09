$((function (){
 $("#downloadanswers").click(function(){
        window.open ("getanswers", "Data Files","resizable=1,scrollbars=1,width=900,height=600");
 });
 
 $("#downloademotions").click(function(){
        window.open ("getemotions", "Data Files","resizable=1,scrollbars=1,width=900,height=600");
 });
 
 $("#downloadstatements").click(function(){
        window.open ("getstatements", "Data Files","resizable=1,scrollbars=1,width=900,height=600");
 });
 
 $("#watchpairing").click(function(){
        window.open ("getpairing", "Data Files","resizable=1,scrollbars=1,width=900,height=600");
 });
 
}));


setInterval(function(){
	if (window.location.pathname == '/control'){
    $.ajax({
       url: "/control/pageupdate",
       type: 'get',
       success: function(data){
       	 $('.users_table').html(data);
          
        }
   })
  // location.reload();
  }
}, 10000);


function change_experiment_status(status){
    var exp_status = status
    if(exp_status == "start"){
    	$("#start").attr("disabled", "disabled");
    	$("#stop").removeAttr("disabled");
    	$("#reset").attr("disabled", "disabled");
    	$("#start").prop("value", "Experiment Started");
    }
    else if(exp_status == "stop"){
    	$("#stop").attr("disabled", "disabled");
    	$("#reset").removeAttr("disabled");
    	$("#start").removeAttr("disabled");
    }
    else{
    	$("#reset").attr("disabled", "disabled");
    	$("#start").removeAttr("disabled");
    	$("#stop").attr("disabled", "disabled");
    	$("#enable").removeAttr("disabled");
    }
    $.ajax({
        url: "/start_experiment?status="+exp_status,
        type: 'get'
    //        success: function(html){
    //            $("#dispaly_user_message_"+user_id).html(html);
    //        }
    });

}

function enable_users(status){
	var enable_status = status
	status = alert("The connections are disabled. Do you want to enable it?")
	$.ajax({
        url: "/change_enable_status?status="+enable_status,
        type: 'get',
        success: function(html){
        	$("#enable").attr('disabled','disabled');
        	$("#enable").prop('value', 'Connections are enabled');
        }
    });
}
