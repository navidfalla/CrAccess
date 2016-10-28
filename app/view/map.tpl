<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/map.css">
<script type="text/javascript" src="<?= BASE_URL ?>/public/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="<?= BASE_URL ?>/public/js/map.js"></script>
<div id="map"></div>
<div>
    <input id="address" type="textbox" value="<?= $issueAddress ?>" style="visibility: hidden;">
</div>
<script async defer
   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAla7FkKwsq9PehjiZ9gBEGq5xo-xEU_9E&callback=initMap">
</script>
