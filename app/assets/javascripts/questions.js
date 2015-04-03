$(document).ready(function(){
	$('.container div').eq(0).css('display','inline-block');
  $('.next').click(function() {
  	val= "question_" + (currentIndex + 1)
  	if ($("input:radio[name=" + val + "]").is(":checked") == false) {
  		alert("Please select an Answer!!")
  		return false;
  	}
    currentIndex += 1;
    if (currentIndex > itemAmt - 2) {
      currentIndex = 0;
    }
    var item = $('.container div').eq(currentIndex);
    items.hide();
    item.css('display','inline-block');
  });
  });
  

