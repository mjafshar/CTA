$(function() {
  function initialize() {
    var coords = $('#stop_coords').data('info')
    var myLatlng = new google.maps.LatLng(coords[0],coords[1]);
    var mapOptions = {
      zoom: 16,
      center: myLatlng
    }
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);

    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: 'Hello World!'
    });
  }

  google.maps.event.addDomListener(window, 'load', initialize);
})
