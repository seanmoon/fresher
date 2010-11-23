$(function() {
  var once = false;
  function checkForChanges() {
    $.getJSON( "http://localhost:4567/status?callback=?", function(data) {
      if (data[0].match(/true/)) {
        window.location.reload(true);  
      }
      setTimeout(function() { checkForChanges(); }, 500);
    });
  }
  checkForChanges();
});
