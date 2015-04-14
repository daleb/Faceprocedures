
setInterval(function(){
if ($("#adjusting_camera").val() !="adjsut_cam" && (window.location.pathname == '/participant/' || window.location.pathname == '/participant')){
$.ajax({
       url: window.location.pathname + window.location.search,
       type: 'get'
   })
}
}, 10000);

$(document).ready(function(){
$('.exit_button').click(function() {
	window.location.href="/get_participant_info";
});
});