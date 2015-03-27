  function cycleItems() {
    var item = $('.container div').eq(currentIndex);
    items.hide();
    item.css('display','inline-block');
  }

$(document).ready(function(){
  $('.next').click(function() {
    currentIndex += 1;
    if (currentIndex > itemAmt - 1) {
      currentIndex = 0;
    }
    cycleItems();
  });
  });

