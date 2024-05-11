$(function() {
  $(".btn").click(function() {
    $(".form-masuk-anggota").toggleClass("form-masuk-anggota-left");
    $(".form-masuk-pustakawan").toggleClass("form-masuk-pustakawan-left");
    $(".daftar").toggleClass("daftar-fade");
    $(".frame-anggota").toggleClass("frame-pustakawan");
    $(".masuk-anggota-active").toggleClass("masuk-anggota-inactive");
    $(".masuk-pustakawan-inactive").toggleClass("masuk-pustakawan-active");
    $(this).removeClass("idle").addClass("masuk-pustakawan-active");
  });
});