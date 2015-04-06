setInterval(function(){
if (window.location.pathname == '/participant'){
	//location.reload();
$.ajax({
       url: "/participant",
       type: 'post'
   })
}
}, 20000);