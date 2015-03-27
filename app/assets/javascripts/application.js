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
// require recordrtc
//= require bootstrap
//= require bootstrap.min

//= require_tree .



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
    $.ajax({
        url: "/start_experiment?status="+exp_status,
        type: 'get'
    //        success: function(html){
    //            $("#dispaly_user_message_"+user_id).html(html);
    //        }
    });

}


//
//setInterval(function(){
// $.ajax({
//        url: "/participant",
//        type: 'get'
//    })
//
//
//    
//
//}, 10000);
//
//
//setInterval(function(){
//     $.ajax({
//        url: "/control",
//        type: 'get'
//    })
//}, 10000);
