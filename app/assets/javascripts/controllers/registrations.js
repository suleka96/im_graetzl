APP.controllers.registrations = (function() {

    function init() {

        APP.components.inputTextareaMovingLabel();

        $('#user_birthday').mask('00/00/0000');

    }


// ---------------------------------------------------------------------- Public

    return {
        init: init
    }

})();