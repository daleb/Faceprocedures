// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery_v1.11.2
//= require_tree .
// require recordrtc
//= require bootstrap
//= require bootstrap.min





function change_status(id){
    var computer_id = id
    $.ajax({
        url: "/change_status?computer_id="+computer_id,
        type: 'get'
    //        success: function(html){
    //            $("#dispaly_user_message_"+user_id).html(html);
    //        }
    });
    
}



function change_experiment_status(status){
    var exp_status = status
    if(exp_status == "start"){
    	$("#start").attr("disabled", "disabled");
    	$("#stop").removeAttr("disabled");
    	$("#reset").removeAttr("disabled");
    }
    else if(exp_status == "stop"){
    	$("#stop").attr("disabled", "disabled");
    	$("#reset").removeAttr("disabled");
    	$("#start").removeAttr("disabled");
    }
    else{
    	$("#reset").attr("disabled", "disabled");
    	$("#start").removeAttr("disabled");
    	$("#stop").removeAttr("disabled");
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
	$.ajax({
        url: "/change_enable_status?status="+enable_status,
        type: 'get'
    });
}



setInterval(function(){
$.ajax({
       url: "/participant",
       type: 'get'
   })

}, 10000);


setInterval(function(){
    $.ajax({
       url: "/control",
       type: 'get'
   })
}, 10000);

setTimeout(function() {
    $('.animated_image').fadeOut('fast');
    $('.score').show();
    $('.exit_button').show();
}, 10000);
