 $(document).ready(function(){
$('.container div').eq(0).css('display','inline-block');
$('.split, .takeall').click(function() {
	//window.location.href="/participant/sample_video";
	//window.location.href="/payments?value=split";
	value = ($(this).attr("value"));
	//val= "#statement_" + '<%$round.to_s%>' + "_round"
	//statement_id = ($(val).val())
	  $.ajax({
        url: "/payments",
        data: { value: value},
        type: 'get', 
        success: function(result){
          //   currentIndex += 1;
  //  if (currentIndex > itemAmt - 1) {
    //  currentIndex = 0;
      window.location.href="/results";
   // }
   // cycleItems();
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
$('.record').click(function() {
	window.location.href="participant/sample_video";
});
});