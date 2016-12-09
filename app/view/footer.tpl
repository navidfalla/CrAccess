<div id="footer">
	<a href="<?= BASE_URL ?>/about.html">About Us</a> | <a href="<?= BASE_URL ?>/contact.html">Contact Us</a> | <a href="<?= BASE_URL ?>/privacy.html">Privacy Policy</a> | <a href="<?= BASE_URL ?>/index.html">Back to Top</a>
</div>
<?php
		if($pageName == 'Visualisation') {
?>
<script src="http://d3js.org/d3.v2.js"></script>
<script type="text/javascript" src="<?= BASE_URL ?>/public/js/vis.js"></script>
<style type="text/css">
  svg {
    border: 1px solid #ccc;
  }
  body {
    font: 10px sans-serif;
  }
  .node circle {
    fill: lightsteelblue;
    stroke: #555;
    stroke-width: 3px;
  }
  circle.leaf {
    stroke: #fff;
    stroke-width: 1.5px;
  }
  path.hull {
    fill: lightsteelblue;
    fill-opacity: 0.3;
  }
  line.link {
    stroke: #333;
    stroke-opacity: 0.5;
    pointer-events: none;
  }
</style>
<?php
		}
?>
</body>
</html>
