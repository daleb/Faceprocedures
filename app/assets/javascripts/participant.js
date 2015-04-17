
setInterval(function(){
if ($("#adjusting_camera").val() !="adjsut_cam" && (window.location.pathname == '/participant/' || window.location.pathname == '/participant')){
$.ajax({
	   data: { coming_from: "page_update"},
       url: window.location.pathname + window.location.search,
       type: 'get'
   })
}
}, 5000);

$(document).ready(function(){
$('.exit_button').click(function() {
	window.location.href="/get_participant_info";
});

$("#adjust").on('click', function(){
     $.ajax({
     	type: 'GET',
     	url: "/participant", 
     	data : {"from" : "adjust_page"}
     	});
})
});

