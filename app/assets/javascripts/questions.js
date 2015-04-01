  // function cycleItems() {
    // var item = $('.container div').eq(currentIndex);
    // alert(currentIndex);	
    // items.hide();
    // item.css('display','inline-block');
  // }

$(document).ready(function(){
	$('.container div').eq(0).css('display','inline-block');
  $('.next').click(function() {
    currentIndex += 1;
    if (currentIndex > itemAmt - 2) {
      currentIndex = 0;
    }
    var item = $('.container div').eq(currentIndex);
    items.hide();
    item.css('display','inline-block');
  });
  });

