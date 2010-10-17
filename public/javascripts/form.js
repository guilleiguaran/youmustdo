function selectCategory(value){
	hideAll();
	switch(value.toLowerCase()){
		case "Read" :
		case "read" :
		case "see" :
			readForm();
		break;
		case "Watch" :
		case "watch" :
			watchForm();
		break;
		case "Have" :
		case "have" :
			haveForm();
		break;
		case "listen":
			listenForm();
  		break;
		case "Visit" :
		case "visit" :
			haveVisit();
		break;
		default:
		  doForm();
	}
}

function addNewFile() {
  var new_item = $("#files span:last").html();
  $("#files").append(new_item)
}

function hideAll(){
 $('#new_must ul li').each(function(index,element){$(element).hide()});
 $('#new_must ul li#fb_share').show();
 $('#new_must ul li#tw_share').show();
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

function listenForm(){
  var valids = ["category", "attachments", "name", "description", "submit",  "external_images","external_video"];
	for(i=0; i<9;i++){
		$('#'+valids[i]).show();
	}
}

function doForm(){
  var valids = ["category", "attachments", "name", "description", "submit",  "external_images","external_video", "url", "url_button", "url_loader", "tag_list", "google_map", "latitude", "longitude"];
	for(i=0; i<valids.length;i++){
		$('#'+valids[i]).show();
	}
}
