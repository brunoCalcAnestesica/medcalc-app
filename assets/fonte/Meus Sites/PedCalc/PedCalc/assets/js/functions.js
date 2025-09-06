$(function() {
    
    $('a.menu-trigger').click(function(){
        $('ul.nav').slideToggle();
    });
    
    $('li.submenu a').click(function(e) { // limit click to children of mainmenue
        var lista = $('li.submenu ul');
        var status = lista.hasClass("active");
        
        if(status == false) {
            lista.addClass("active");
        } else {
            lista.removeClass("active");
        }
    });
    
});

function scrollTo(div) {
    $('html, body').animate({
        scrollTop: $(div).offset().top - 100
    }, 1000);
}

$("a.menu-trigger").click(function() {
    $(".menu-trigger").toggleClass("active");
});

$(window).on('load', function() {

    document.querySelector(".loader-wrapper").classList.add("animated", "fadeOut");
    setTimeout(function() {
        $(".loader-wrapper").css('display', 'none');
    }, 800);
    
});