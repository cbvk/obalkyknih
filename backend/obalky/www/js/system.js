
/* view */
function view_abuse_onsubmit() {
	var textarea = document.getElementById("abuse_comment");
	if(textarea.style.display == 'none') {
		textarea.style.display = 'block';
		return false;
	} else {
		if(textarea.value.length < 10) {
			alert('Zadejte prosím popis chyby.');
			return false;
		}
		return true;
	}
}

function view_abuse_toc_onsubmit() {
	var textarea = document.getElementById("abuse_toc_comment");
	if(textarea.style.display == 'none') {
		textarea.style.display = 'block';
		return false;
	} else {
		if(textarea.value.length < 10) {
			alert('Zadejte prosím popis chyby.');
			return false;
		}
		return true;
	}
}

/* view */
function view_review_onsubmit() {
	var name   = document.getElementById("review_name");
	var text   = document.getElementById("review_text");
	var rating = document.getElementById("review_rating");
	if(name.value == '') {
		alert('Do pole "Od" zadejte Vaše jméno.');
		return false;
	}
	var textLength = text.value.length;
	alert(textLength);
	if(textLength && textLength < 30) {
		alert('Napište recenzi k dané knížce (alespoň 30 znaků).');
		return false;
	}
	return true;
}

function vote(obj,id,amnt){
	$('#review_rating').val(amnt);
	$('.star-rating a').removeClass('active');
	$('#review_recaptcha').show();
	for (i=amnt; i>0; i--) {
		$('.star-rating a.s' + i).addClass('active');
	}
}

function starsOver(amnt){
	$('.star-rating a').removeClass('hover');
	for (i=amnt; i>0; i--) {
		el = '.star-rating a.s' + i;
		if (!$(el).is('.active')) {
			$(el).addClass('hover');
		}
	}
}

function showRecaptcha(){
	if (!$('#review_recaptcha').is(':visible')) {
		$('#review_recaptcha').toggle("highlight");
	}
}
