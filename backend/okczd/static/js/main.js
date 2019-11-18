(function ($) {
 "use strict";

		$(".chosen")[0] && $(".chosen").chosen({
            width: "100%",
            allow_single_deselect: !0
        });
		/*--------------------------
		 auto-size Active Class
		---------------------------- */
		$(".auto-size")[0] && autosize($(".auto-size"));
		/*--------------------------
		 Collapse Accordion Active Class
		---------------------------- */
		$(".collapse")[0] && ($(".collapse").on("show.bs.collapse", function(e) {
            $(this).closest(".panel").find(".panel-heading").addClass("active")
        }), $(".collapse").on("hide.bs.collapse", function(e) {
            $(this).closest(".panel").find(".panel-heading").removeClass("active")
        }), $(".collapse.in").each(function() {
            $(this).closest(".panel").find(".panel-heading").addClass("active")
        }));
		/*----------------------------
		 jQuery tooltip
		------------------------------ */
		$('[data-toggle="tooltip"]').tooltip();
		/*--------------------------
		 popover
		---------------------------- */
		$('[data-toggle="popover"]')[0] && $('[data-toggle="popover"]').popover();
		/*--------------------------
		 File Download
		---------------------------- */
		$('.btn.dw-al-ft').on('click', function(e) {
			e.preventDefault();
		});
		/*--------------------------
		 Sidebar Left
		---------------------------- */
		$('#sidebarCollapse').on('click', function () {
			 $('#sidebar').toggleClass('active');

		 });
		$('#sidebarCollapse').on('click', function () {
			$("body").toggleClass("mini-navbar");
			SmoothlyMenu();
		});
		$('.menu-switcher-pro').on('click', function () {
			var button = $(this).find('i.nk-indicator');
			button.toggleClass('notika-menu-befores').toggleClass('notika-menu-after');

		});
		$('.menu-switcher-pro.fullscreenbtn').on('click', function () {
			var button = $(this).find('i.nk-indicator');
			button.toggleClass('notika-back').toggleClass('notika-next-pro');
		});
		/*--------------------------
		 Button BTN Left
		---------------------------- */

		$(".nk-int-st")[0] && ($("body").on("focus", ".nk-int-st .form-control", function() {
            $(this).closest(".nk-int-st").addClass("nk-toggled")
        }), $("body").on("blur", ".form-control", function() {
            var p = $(this).closest(".form-group, .input-group"),
                i = p.find(".form-control").val();
            p.hasClass("fg-float") ? 0 == i.length && $(this).closest(".nk-int-st").removeClass("nk-toggled") : $(this).closest(".nk-int-st").removeClass("nk-toggled")
        })), $(".fg-float")[0] && $(".fg-float .form-control").each(function() {
            var i = $(this).val();
            0 == !i.length && $(this).closest(".nk-int-st").addClass("nk-toggled")
        });
		/*--------------------------
		 mCustomScrollbar
		---------------------------- */
		$(window).on("load",function(){
			$(".widgets-chat-scrollbar").mCustomScrollbar({
				setHeight:460,
				autoHideScrollbar: true,
				scrollbarPosition: "outside",
				theme:"light-1"
			});
			$(".notika-todo-scrollbar").mCustomScrollbar({
				setHeight:445,
				autoHideScrollbar: true,
				scrollbarPosition: "outside",
				theme:"light-1"
			});
			$(".comment-scrollbar").mCustomScrollbar({
				autoHideScrollbar: true,
				scrollbarPosition: "outside",
				theme:"light-1"
			});
		});
	/*----------------------------
	 jQuery MeanMenu
	------------------------------ */
	jQuery('nav#dropdown').meanmenu();

	/*----------------------------
	 wow js active
	------------------------------ */
	 new WOW().init();

	/*----------------------------
	 owl active
	------------------------------ */
	$("#owl-demo").owlCarousel({
      autoPlay: false,
	  slideSpeed:2000,
	  pagination:false,
	  navigation:true,
      items : 4,
	  /* transitionStyle : "fade", */    /* [This code for animation ] */
	  navigationText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
      itemsDesktop : [1199,4],
	  itemsDesktopSmall : [980,3],
	  itemsTablet: [768,2],
	  itemsMobile : [479,1],
	});

	/*----------------------------
	 price-slider active
	------------------------------ */
	  $( "#slider-range" ).slider({
	   range: true,
	   min: 40,
	   max: 600,
	   values: [ 60, 570 ],
	   slide: function( event, ui ) {
		$( "#amount" ).val( "£" + ui.values[ 0 ] + " - £" + ui.values[ 1 ] );
	   }
	  });
	  $( "#amount" ).val( "£" + $( "#slider-range" ).slider( "values", 0 ) +
	   " - £" + $( "#slider-range" ).slider( "values", 1 ) );

	/*--------------------------
	 scrollUp
	---------------------------- */
	$.scrollUp({
        scrollText: '<i class="fa fa-angle-up"></i>',
        easingType: 'linear',
        scrollSpeed: 900,
        animation: 'fade'
    });

  /*--------------------------
   book recommender
  ---------------------------- */
	if ($('#apiresp').length) {
    var isbn = $('#isbn').val();
    var nbn = $('#nbn').val();
    var oclc = $('#oclc').val();
    if (isbn!='' || nbn!='' || oclc!='') {
      var multi = {};
      if (isbn!='') multi['isbn'] = isbn;
      if (nbn!='') multi['nbn'] = nbn;
      if (oclc!='') multi['oclc'] = oclc;
      $.ajax({
        url: '/api/doporuc?multi=' + JSON.stringify(multi),
        success: function(result) {
          if (result.length && result != '[]') {
            // book info
            console.log('/info?multi=' + JSON.stringify(multi));
            $.ajax({
              url: '/info?multi=' + JSON.stringify(multi),
              success: function(resinfo) {
                if (resinfo.length && resinfo != '[]') {
                  $('#book-info .well').append(resinfo);
                }
              }
            });

            // recommendation results
            for (var i=0; i<=result.length; i++) {
              var item = result[i];
              if (item) {
                var multiCover = {};
                if (item['isbn']) multiCover['isbn'] = item['isbn'];
                if (item['nbn']) multiCover['nbn'] = item['nbn'];
                if (item['oclc']) multiCover['oclc'] = item['oclc'];
                $('#apiresp').append('<div class="item col-lg-2 col-md-3 col-sm-4 col-xs-6" data-id="' + item['id'] + '"><img src="https://cache.obalkyknih.cz/api/cover/?multi=' + encodeURI(JSON.stringify(multiCover)) + '" alt="' + item['title'] + '" title="' + item['title'] + '" /><div><label>' + item['title'] + '</label></div></div>');
              }
            }
            $('#apiresp div.item').click(function(){
              $('.info-panel').remove();
              var pos = $(this).position();
              var id = $(this).data('id');
              var itemsCount = $('#apiresp div.item').length;
              var neighborEl = $(this);
              var el = $(this);
              for (var i=0; i<itemsCount; i++) {
                if (!neighborEl.next().length) {
                  el = neighborEl;
                  break;
                }
                var neighborEl = neighborEl.next();
                var neighborPos = neighborEl.position();
                if (neighborPos.top != pos.top) {
                  el = neighborEl.prev();
                  break;
                }
              }
              $.ajax({
                url: '/info?id=' + id,
                success: function(result) {
                  el.after('<div class="row info-panel"><div class="col-xs-12">' + result + '</div></div>');
                }
              })
            });
          }
        }
      });
    }
  }

})(jQuery);
