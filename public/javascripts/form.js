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
		case "Visit" :
			haveVisit();
		break;
		case "visit" :
			haveVisit();
		break;
		default:
		  alert(value);
	}
}

function hideAll(){
 $('#new_must ul li').each(function(index,element){$(element).hide()})
}

function readForm(){
	var valids = ["category", "url", "url_button", "url_loader", "name", "description", "submit", "external_images", "tag_list"];
	for(i=0; i<9;i++){
		$('#'+valids[i]).show();
	}
}

function watchForm(){
	var valids = ["category", "url", "url_button", "url_loader", "name", "description", "submit",  "external_video", "tag_list"];
	for(i=0; i<9;i++){
		$('#'+valids[i]).show();
	}
}
	
function haveForm(){
	var valids = ["category", "url", "url_button", "url_loader", "name", "description", "submit",  "external_images","external_video","tag_list"];
	for(i=0; i<10;i++){
		$('#'+valids[i]).show();
	}
}

function haveVisit(){
	var valids = ["category",  "name", "description", "submit","tag_list","google_map", "longitude", "latitude"];
	for(i=0; i<8;i++){
		$('#'+valids[i]).show();
	}
}