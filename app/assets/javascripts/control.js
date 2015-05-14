$((function () {
    $("#downloadanswers").click(function () {
        window.open("getanswers", "Data Files", "resizable=1,scrollbars=1,width=900,height=600");
    });

    $("#downloademotions").click(function () {
        window.open("getemotions", "Data Files", "resizable=1,scrollbars=1,width=900,height=600");
    });

    $("#downloadstatements").click(function () {
        window.open("getstatements", "Data Files", "resizable=1,scrollbars=1,width=900,height=600");
    });

    $("#watchpairing").click(function () {
        window.open("getpairing", "Data Files", "resizable=1,scrollbars=1,width=900,height=600");
    });

    $("#downloadpayments").click(function () {
        window.open("getpayments", "Data Files", "resizable=1,scrollbars=1,width=900,height=600");
    });
    $("#downloaduserinfo").click(function () {
        window.open("getuserinfo", "Data Files", "resizable=1,scrollbars=1,width=900,height=600");
    });
    $("#autoplaybutton").click(function () {
        if($("#autoplayvalue").text() == "Disabled"){
            $.post( "control/autoplayenable" );
            $("#autoplayvalue").html("Enabled")
        }
        else{
            $.post( "control/autoplaydisable" );
            $("#autoplayvalue").html("Disabled")
        }

    });
    $("#timebutton").removeAttr("disabled");
    $("#userlimitbutton").removeAttr("disabled");
    $("#reset").attr("disabled", "disabled");
    $("#start").attr("disabled", "disabled");
    $("#stop").attr("disabled", "disabled");
    $("#enable").removeAttr("disabled");
    $("#autoplaybutton").html("Disabled")
    getcontrollername();
}));


setInterval(function(){
	if (window.location.pathname == '/control'){
    $.ajax({
       url: "/control/pageupdate",
       type: 'get',
       success: function(data){
       	 $('.table').html(data);
        }
   })
  }
}, 3000);


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
    	$("#stop").prop("value", "Experiment Stopped");
    	$("#start").prop("value", "Start Experiment");
    }
    else{
    	$("#reset").attr("disabled", "disabled");
    	$("#start").removeAttr("disabled");
    	$("#stop").attr("disabled", "disabled");
    	$("#enable").removeAttr("disabled");
    	$("#timebutton").removeAttr("disabled");
    	$("#userlimitbutton").removeAttr("disabled");
    	$("#stop").prop("value", "Stop Experiment");
    }
    $.ajax({
        url: "/start_experiment?status="+exp_status,
        type: 'get'
     });

}

function enable_users(status){
	var enable_status = status
	status = confirm("Are you sure you want to enable connections?");
    if (status){
	$.ajax({
        url: "/change_enable_status?status=enable",
        type: 'get',
        success: function(data){
        	$("#enable").attr('disabled','disabled');
        	$("#enable").prop('value', 'Connections are enabled');
        	$("#timebutton").attr("disabled", "disabled");
    	    $("#userlimitbutton").attr("disabled", "disabled");
    	    $("#start").removeAttr("disabled");
        }
    });
    }
}

