
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
/*	if(rating.value == 0) {
		alert('Klikněte na příslušný počet hvězdiček.');
		return false;
	}*/
	if(text.value.length < 30) {
		alert('Napište recenzi k dané knížce (alespoň 30 znaků).');
		return false;
		
	}
	return true;
}


function vote(id,amnt){
	$.ajax({
		type: "POST",
		url: "/vote",
		data: "book=" + id + "&vote=" + amnt,
		dataType: "json",
		success: function(res){
			$('#current-rating').width(res.width);
			$('#current-rating-result').html(res.status);
			$('#star-rating').hide();
		}
	});
}
