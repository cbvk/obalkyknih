$( document ).ready(function() {

    $('.edit').each(function(index, el) {

        // udalost kliknutia na odkaz edit
        $(el).click(function() {
            $('#modal').modal();
            return false;
        });

        // po zobrazeni modalneho okna nacitaj obsah na pozadi a potom zobraz v okne
        $('#modal').on('show.bs.modal', function(e) {
            $('#modal .modal-body').html('Sem vypisat odpoved ziskanu na pozadi z backendu pomocou $.ajax({... z requestu na jeden zaznam - zobrazi sa formular.');
            console.log(Object.keys(object1));
        });
    });

});
