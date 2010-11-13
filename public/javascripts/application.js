
must_timer='';

function change_profile_tabs(id){
	$('#errorExplanation').hide();
	$('#avatar').hide();
	$('#info').hide();
	$('#password').hide();
	$('#menu_lower a').removeClass();
	$("#link_"+id).addClass('selected');
    $("#"+id).show();
}

function new_notification(message, class_name){
	$('#flash').html('');	
	$('#flash').append("<p class='"+class_name+"'><img src='/images/icons/"+class_name+".png'>"+message+"</p>");
	$('#flash').hide();
	$('#flash').fadeIn(500).delay(5000).fadeOut(400);
}