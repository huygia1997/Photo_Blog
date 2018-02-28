document.addEventListener("turbolinks:load", function(event) { 
 // your jquery code
 // menu
    $('#drop_trigger').mouseenter(function(){
                                $('#drop_show').show(300);
                            });
    $('#drop_show').mouseleave(function(){
        $('#drop_show').hide(300);
    });

    // back to top
    $(window).scroll(function () {
            if ($(this).scrollTop() > 150) {
                $('#back_to_top').fadeIn();
            } else {
                $('#back_to_top').fadeOut();
            }

            if ($(this).scrollTop() > 300) {
                $('#login_div').animate({
                    left: '30%'
                }, 200).show(200);

            }

            if ($(this).scrollTop() > 800) {
                $('#user_div').animate({
                    right: '30%'
                }, 200).show(200);

            }

            if ($(this).scrollTop() > 1300) {
                $('#about_div').animate({
                    left: '30%'
                }, 200).show(200);

            }
        });
        // scroll body to 0px on click
        $('#back_to_top').click(function () {
            // $('#back_to_top').tooltip('hide');
            $('body,html').animate({
                scrollTop: 0
            }, 800);
            return false;
        });
        
        // $('#back_to_top').tooltip('show');

        // image size
        $('#ava_size').bind('change', function() {
            var size_in_megabytes = this.files[0].size/1024/1024;
            if (size_in_megabytes > 5) {
              alert('Maximum file size is 5MB. Please choose a smaller file.');
            }
          });

});