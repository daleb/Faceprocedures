
$(document).ready(function(){
	$('.survey').hide();
	$('.results').show();
	$('.score').hide();
});

setTimeout(function() {
		$('.score').hide();
		if($('#exit_flag').val()=="exit_poll"){
			$('.exit_button').show();
			$('.survey').hide();
		}
		else if($('#com_from').val()!="waiting_after_pick" || $('#com_from').val()=="vdo"){
		$('.survey').show();
		}
}, 100);

// $('.click').click(function() {
	// $('.results').show();
	// $('.click').hide();
	// $('.alert').hide();
// });

$('button').click(function() {
	$('.score').hide();
	$('.exit_button').hide();
	if ($(this).val() == "submit"){
		var survey_count= parseInt($('#survey_length').val())
		flag=true
		var options=[]
		for(var i=1; i <= survey_count;i+=1){
		var option=($('input[name=user_' + i + '_option]:checked').val());
		if (option==undefined){
			flag=false
		}
		else{
			options.push(option)
		}
		};
		if (flag==false){
			alert("Please choose option for all the statements to complete survey!")
            return false;			
		}
		
		$.ajax({
        url: "/save_survey_details",
        data: { value: options},
        type: 'get', 
        success: function(result){
           window.location.href="/participant?from=Waiting after emotion survey";
    }
        });
	}
});

$('input[type="submit"]').click(function() {
	if($('#name').val()=='' || $('#name').val().length< 1)
	{
		alert("Please enter your name!")
		return false;
	}
	else if($('#age').val()=='' || $.isNumeric($('#age').val())==false)
	{
		alert("Please Enter your age in Numeric!")
		return false;
	}
	else if ($('#language').val()==''){
		alert("Please enter your first language!")
		return false;
	}
	
});
