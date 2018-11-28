(function($) {

    $(document).ready(function() {

        jQuery('.crc-tabs .crc-tabs__items a').on('click', function(e)  {
            var currentAttrValue = jQuery(this).attr('href');

            jQuery('.crc-tabs ' + currentAttrValue).show().siblings().hide();

            jQuery(this).parent('li').addClass('crc-tabs__item--active').siblings().removeClass('crc-tabs__item--active');

            e.preventDefault();
        });

        $('.crc-message__close').click(function(e) {
            $(this).parent().remove();
        });

        function close_accordion_section() {
            $('.crc-accordion .crc-accordion__section-title').removeClass('crc-accordion__section-title--active');
            $('.crc-accordion .crc-accordion__section-content').slideUp(300).removeClass('crc-accordion__section-content--open');
        }

        $('.crc-accordion__section-title').click(function(e) {
            var currentAttrValue = $(this).attr('href');

//            if($(e.target).is('.crc-accordion__section-title--active')) {
//                close_accordion_section();
//            }else {
//                close_accordion_section();
//
//                $(this).addClass('crc-accordion__section-title--active');
//                $('.crc-accordion ' + currentAttrValue).slideDown(300).addClass('crc-accordion__section-content--open');
//            }

            if ($(this).hasClass('crc-accordion__section-title--active')) {
                $(this).removeClass('crc-accordion__section-title--active');
                $('.crc-accordion ' + currentAttrValue).slideUp(300).removeClass('crc-accordion__section-content--open');
            } else {
                $(this).addClass('crc-accordion__section-title--active');
                $('.crc-accordion ' + currentAttrValue).slideDown(300).addClass('crc-accordion__section-content--open');
            }

            e.preventDefault();
        });

        //  Toggle body class
        var toggleBodyClass = function(){
            // $('body').toggleClass('crc-popup-active');
        };

        //  Toggle popup
        var togglePopup = function(popupClass) {
            $(popupClass).toggle();
            toggleBodyClass();
        };

       $('.js-toggle-video-popup').click(function(){
           togglePopup(
               '.js-video-popup'
           );
       });

       $('.js-toggle-help-popup').click(function(){
           togglePopup(
               '.js-help-popup'
           );
       });

        $('.js-toggle-funds-popup').click(function() {
            togglePopup(
                '.js-funds-modal-popup'
            );
        });

//        $('.js-toggle-password-popup').click(function(){
//            togglePopup(
//                '.js-password-popup'
//            );
//        });

//        $('.js-toggle-deposit-popup').click(function(){
//            togglePopup(
//                '.js-deposit-popup'
//            );
//        });

//        $('.js-toggle-withdraw-popup').click(function(){
//            togglePopup(
//                '.js-withdraw-popup'
//            );
//        });

//        $('.crc-qrcode__toggle').click(function(){
//            $('.crc-qrcode__code').toggle();
//        });

    });

}(jQuery));
//# sourceMappingURL=app.js.map