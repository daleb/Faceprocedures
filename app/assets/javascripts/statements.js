 $(document).ready(function(){
$('.container div').eq(0).css('display','inline-block');
$('#split, #takeall').click(function() {
	value = ($(this).attr("value"));
	  $.ajax({
        url: "/payments",
        data: { value: value},
        type: 'get', 
        success: function(result){
        window.location.href="/participant?from=picked_action";
        //window.location.href="/results";
        //$('.options').hide();
	    //$('.survey').show();
    }
        });
    });
	
	
  });

  
 function cycleItems() {
    var item = $('.container div').eq(currentIndex);
    items.hide();
    item.css('display','inline-block');
  }

$(document).ready(function(){
$('#record').click(function() {
	window.location.href="participant/sample_video";
});
$('.results').click(function() {
	window.location.href="participant/sample_video?from=result";
});
});