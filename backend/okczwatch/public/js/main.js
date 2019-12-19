$( document ).ready(function() {

    var task_code = "";

    $('.edit').each(function(index, el) {
        
        // udalost kliknutia na odkaz edit
        $(el).click(function() {
            var prem = $(el).parent().siblings(":first").text();
            task_code = prem;
            // $('#modal .modal-body').html(prem);
            $('#modal').modal();
            return false;
        });

        
        
    });
    
    // po zobrazeni modalneho okna nacitaj obsah na pozadi a potom zobraz v okne
    $('#modal').on('show.bs.modal', function(e) {
        var task = task_code;
        $.get( "task/find", {task : task} ).done(function( data ) {
            // alert( "Data Loaded: " + data );
            $('#modal .modal-body').html(data);
          });
        
        //console.log(el);
        // console.log(prem);
    });

    $('#save_button').click(function(){
        // if ($('#modal #checkbox_monday').is(":checked"))
        // {
        //     alert('is checked')
        // }
        // var str = $("#modal #checkbox_monday").val();
        // alert(str);
        var str = $( "form" ).serialize();
        alert(str);
    });

});
