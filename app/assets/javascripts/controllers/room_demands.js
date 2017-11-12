APP.controllers.room_demands = (function() {

    function init() {
        if ($("section.room-offer-form").exists()) initRoomForm();
    }

    function initRoomForm() {
        APP.components.graetzlSelectFilter.init($('.district-select'), $('.graetzl-select'));

        $('#custom-keywords').tagsInput({
            'defaultText':'Kurz in Stichworten ..'
        });
    }

    return {
        init: init
    }

})();