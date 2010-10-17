function selectCategory(value){
	hideAll();
	switch(value){
		case "Read" :
			readForm();
		break;
		case "read" :
			readForm();
		break;
		case "Watch" :
			watchForm();
		break;
		case "watch" :
			watchForm();
		break;
		case "Have" :
			haveForm();
		break;
		case "have" :
			haveForm();
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

function watchForm(){
	var valids = ["category", "url", "url_button", "url_loader", "name", "description", "submit",  "external_video"];
	for(i=0; i<8;i++){
		$('#'+valids[i]).show();
	}
}
	
function haveForm(){
	var valids = ["category", "url", "url_button", "url_loader", "name", "description", "submit",  "external_images","external_video"];
	for(i=0; i<9;i++){
		$('#'+valids[i]).show();
	}
}