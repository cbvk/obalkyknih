
/**
 * jQuery.ScrollTo - Easy element scrolling using jQuery.
 * Copyright (c) 2007-2009 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 5/25/2009
 * @author Ariel Flesler
 * @version 1.4.2
 *
 * http://flesler.blogspot.com/2007/10/jqueryscrollto.html
 */
;(function(d){var k=d.scrollTo=function(a,i,e){d(window).scrollTo(a,i,e)};k.defaults={axis:'xy',duration:parseFloat(d.fn.jquery)>=1.3?0:1};k.window=function(a){return d(window)._scrollable()};d.fn._scrollable=function(){return this.map(function(){var a=this,i=!a.nodeName||d.inArray(a.nodeName.toLowerCase(),['iframe','#document','html','body'])!=-1;if(!i)return a;var e=(a.contentWindow||a).document||a.ownerDocument||a;return d.browser.safari||e.compatMode=='BackCompat'?e.body:e.documentElement})};d.fn.scrollTo=function(n,j,b){if(typeof j=='object'){b=j;j=0}if(typeof b=='function')b={onAfter:b};if(n=='max')n=9e9;b=d.extend({},k.defaults,b);j=j||b.speed||b.duration;b.queue=b.queue&&b.axis.length>1;if(b.queue)j/=2;b.offset=p(b.offset);b.over=p(b.over);return this._scrollable().each(function(){var q=this,r=d(q),f=n,s,g={},u=r.is('html,body');switch(typeof f){case'number':case'string':if(/^([+-]=)?\d+(\.\d+)?(px|%)?$/.test(f)){f=p(f);break}f=d(f,this);case'object':if(f.is||f.style)s=(f=d(f)).offset()}d.each(b.axis.split(''),function(a,i){var e=i=='x'?'Left':'Top',h=e.toLowerCase(),c='scroll'+e,l=q[c],m=k.max(q,i);if(s){g[c]=s[h]+(u?0:l-r.offset()[h]);if(b.margin){g[c]-=parseInt(f.css('margin'+e))||0;g[c]-=parseInt(f.css('border'+e+'Width'))||0}g[c]+=b.offset[h]||0;if(b.over[h])g[c]+=f[i=='x'?'width':'height']()*b.over[h]}else{var o=f[h];g[c]=o.slice&&o.slice(-1)=='%'?parseFloat(o)/100*m:o}if(/^\d+$/.test(g[c]))g[c]=g[c]<=0?0:Math.min(g[c],m);if(!a&&b.queue){if(l!=g[c])t(b.onAfterFirst);delete g[c]}});t(b.onAfter);function t(a){r.animate(g,j,b.easing,a&&function(){a.call(this,n,b)})}}).end()};k.max=function(a,i){var e=i=='x'?'Width':'Height',h='scroll'+e;if(!d(a).is('html,body'))return a[h]-d(a)[e.toLowerCase()]();var c='client'+e,l=a.ownerDocument.documentElement,m=a.ownerDocument.body;return Math.max(l[h],m[h])-Math.min(l[c],m[c])};function p(a){return typeof a=='object'?a:{top:a,left:a}}})(jQuery);


$(function () {


/* Glider
------------------------------------------------------------------------------*/

var topLinks = $(".topLinks > ul > li > a", "#blackbox");
var topLinksEl;
topLinks.on("click", function(event) {
	event.preventDefault();
	topLinks.removeClass("active");
	$(this).addClass("active");
	topLinksEl = $($(this).attr("href"));
	$("#section").scrollTo(topLinksEl, 500);
});


var glider = $(".glider", "#blackbox");
var gliderLiWidth = 170;
var gliderUlWidth = 680;
var gliderCount = 4;

if(glider.length) {
	glider.each(function() {
		var gliderHolder = $(this);
		var gliderUl = $("ul", gliderHolder);
		var gliderNav = $(".gliderNav", gliderHolder);

		/* Points in glider controls */
		var gliderPoints = "";
		var gliderSections = Math.ceil($("li", gliderHolder).size() / gliderCount);
		for (var i = 1; i <= gliderSections; i++) {
			gliderPoints += '<a class="replace point" href="#">' + i + '<span></span></a>';
		}


		/* Glider controls = points and arrows */
		gliderNav.append('<p class="squares">' + gliderPoints +'</p> <p class="arrows"><a class="prevSlide replace" href="">&lt;<span></span></a> <a class="nextSlide replace" href="">&gt;<span></span></a></p>');
		$("ul", gliderHolder).width($("li", gliderHolder).size() * gliderLiWidth);

		var gliderNavPrev = $(".prevSlide", gliderNav);
		var gliderNavNext = $(".nextSlide", gliderNav);

		$('.point:first', gliderNav).addClass('active');

		/* Check previous/next arrows */
		function checkArrows() {
			/* If is first item active, stop clickable */
			if($(".squares a.point:first", gliderNav).hasClass("active")) {
				gliderNavPrev.addClass("disabled");
			} else {
				gliderNavPrev.removeClass("disabled");
			}

			/* If is last item active, stop clickable */
			if($(".squares a.point:last", gliderNav).hasClass("active")) {
				gliderNavNext.addClass("disabled");
			} else {
				gliderNavNext.removeClass("disabled");
			}
		}


		/* Next arrow
			- show previous 3 items
		*/
		gliderNavNext.click(function(event) {
			event.preventDefault();
			if(!$(this).hasClass("disabled")) {
				gliderNavPrev.removeClass("active");
				gliderUl.animate({marginLeft: -gliderUlWidth * parseInt($(".squares .active", gliderNav).html())}, {queue: false, duration: 250});
				$(".squares .active", gliderNav).removeClass("active").next().addClass("active");

				if($(".squares .point:nth-child(" + (gliderSections) + ")", gliderNav).hasClass("active")) {
					$(this).addClass("disabled");
				}
			}
			checkArrows();
		});


		/* Previous arrow
			- show next 3 items
		*/
		gliderNavPrev.click(function(event) {
			event.preventDefault();
			if(!$(this).hasClass("disabled")) {
				gliderNavNext.removeClass("active");
				gliderUl.animate({marginLeft: -gliderUlWidth * (parseInt($(".squares .active", gliderNav).html())-2)}, {queue: false, duration: 250});
				$(".squares .active", gliderNav).removeClass("active").prev().addClass("active");

				if($(".squares .point:nth-child(1)").hasClass("active")) {
					$(this).addClass("disabled");
				}
			}
			checkArrows();
		});


		/* Points in glider controls
			- shows selected 3 items
		*/
		$(".point", gliderNav).click(function(event) {
			event.preventDefault();
			gliderUl.animate({marginLeft: -gliderUlWidth * (parseInt($(this).html())-1)}, {queue: false, duration: 250});
			$(".squares .active", gliderNav).removeClass("active");
			$(this).addClass("active");
			checkArrows();
		});

		checkArrows();
	});
}

});



$(function () {

	$('a.print').click(function(){
		window.print();
	});
	
	
   // SHP form labels
   $('#blue form input').focus(function () {
       $(this).prev('label').fadeOut('fast');
   }).blur(function () {
       if ($(this).val() == '' & $(this).text() == '') $(this).prev('label').fadeIn('fast');
   });
   $('#blue form input').each(function () {
       if ($(this).val() != '' || $(this).text() != '') $(this).prev('label').remove();
   });


	// Footer logos hover effect
	$('#foot .author').hover(function(){
		$(this).find('span').stop(true,true).fadeOut('fast');
	},function(){
	   $(this).find('span').stop(true,true).fadeIn('slow');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ('slow');
	});
    
    
	$('#fading').cycle({ 
	    delay:  6000, 
	    speed:  1000 
	}); 
	

});

			
