
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

$("#adjust").on('click', function(){
     $.ajax({
     	type: 'GET',
     	url: "/participant", 
     	data : {"from" : "adjust_page"}
     	});
})
    getcontrollername();
});

