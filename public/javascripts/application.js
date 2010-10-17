// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

must_timer='';

function load_more_muts(date){
	$.get('musts/load_more/'+date, function (data, responseText){});		
}