$(document).on('turbolinks:load', function() {
  title.innerHTML = "Timer server";

  function time() {
    var time = new Date();
    var n = time.toLocaleTimeString();
    document.getElementById("tx").innerHTML = time.toLocaleTimeString();
  }
  setInterval(time, 1000);

})
