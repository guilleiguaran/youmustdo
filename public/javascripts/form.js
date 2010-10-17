function selectCategory(value){
	hideAll();
	switch(value){
		case "Read" :
			readForm();
		break;
		case "read" :
			readForm();
		break;
		default:
		  alert(value);
	}
}


function hideAll(){
 $('#new_must ul li').each(function(index,element){$(element).hide()})
}

function readForm(){
	var valids = ["category", "url", "url_button", "url_loader", "name", "description", "submit", "external_images"];
	for(i=0; i<8;i++){
		$('#'+valids[i]).show();
	}
}