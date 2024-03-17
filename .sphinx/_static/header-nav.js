$(document).ready(function() {
    $(document).on("click", function () {
        $(".more-links-dropdown").hide();
        $(".more-links-dropdown_cont").hide();
    });

    $('.nav-more-links').click(function(event) {
        $('.more-links-dropdown').toggle();
        event.stopPropagation();
    });
    $('.nav-more-links_cont').click(function(event) {
        $('.more-links-dropdown_cont').toggle();
        event.stopPropagation();
    });
})
