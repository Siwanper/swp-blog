$(document).ready(function () {
    // hide / show
    $("#hideBtn").click(function () {
        $(".hideView").hide();
    })
    $("#showBtn").click(function () {
        $(".hideView").show();
    })
    $("#toggle").click(function () {
        $(".toggleView").toggle();
    })

    // fadeIn / fadeOut
    $("#fadeInBtn").click(function () {
        $(".fadeView").fadeIn();
    })
    $("#fadeOutBtn").click(function () {
        $(".fadeView").fadeOut();
    })
    $("#fadeToggle").click(function () {
        $(".fadeToggleView").fadeToggle();
    })

    // slideDown / slideUp
    $("#slideDownBtn").click(function () {
        $(".slideView").slideDown();
    })
    $("#slideUpBtn").click(function () {
        $(".slideView").slideUp();
    })
    $("#slideToggle").click(function () {
        $(".slideToggleView").slideToggle();
    })

})