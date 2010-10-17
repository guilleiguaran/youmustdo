// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

must_timer='';

function load_more_muts(date){
	$.get('musts/load_more/'+date, function (data, responseText){});		
}

function add_must_to_my_bucket_list(id, must_id){
	$.ajax({ url: "/users/"+id+"/buckets/",
	type: "POST",
	data: "must_id="+must_id
});
}

function delete_must_from_my_bucket_list(id, must_id){
	$.ajax({ url: "/users/"+id+"/buckets/",
	type: "DELETE",
	data: "must_id="+must_id
});
}

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
	$('#flash').fadeIn(500).delay(7000).fadeOut(400);
}