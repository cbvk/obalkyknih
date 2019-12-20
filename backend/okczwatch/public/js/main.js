$( document ).ready(function() {

    var task_code = "";

    $('.edit').each(function(index, el) {
        
        // udalost kliknutia na odkaz edit
        $(el).click(function() {
            var prem = $(el).parent().siblings(":first").text();
            task_code = prem;
            $('#modal').modal();
            return false;
        });

        
        
    });
    
    // po zobrazeni modalneho okna nacitaj obsah na pozadi a potom zobraz v okne
    $('#modal').on('show.bs.modal', function(e) {
        var task = task_code;
        $.get( "task/find", {task : task} ).done(function( data ) {
            $('#modal .modal-body').html(data);
          });
    });

    $('#save_button').click(function(){
        var data = $( "form" ).serialize();
        $.post("task/update", {data: data, task_code: task_code}, function(result){
            // alert('success ' + result);
        });
    });

});
