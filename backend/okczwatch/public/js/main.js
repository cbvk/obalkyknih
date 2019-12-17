$( document ).ready(function() {

    $('.edit').each(function(index, el) {
        
        // udalost kliknutia na odkaz edit
        $(el).click(function() {
            var prem = $(el).parent().siblings(":first").text();
            $('#modal .modal-body').html(prem);
            $('#modal').modal();
            return false;
        });

        
        
    });
    
    // po zobrazeni modalneho okna nacitaj obsah na pozadi a potom zobraz v okne
    $('#modal').on('show.bs.modal', function(e) {
        var task = $('#modal .modal-body').html();
        $.get( "task/find", {task : task} ).done(function( data ) {
            alert( "Data Loaded: " + data );
            $('#modal .modal-body').html(data);
          });
        
        //console.log(el);
        // console.log(prem);
    });

});
