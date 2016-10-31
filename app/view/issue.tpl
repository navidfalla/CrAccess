<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
<script type="text/javascript" src="<?= BASE_URL ?>/public/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="<?= BASE_URL ?>/public/js/map.js"></script>
<script async defer
	 src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAla7FkKwsq9PehjiZ9gBEGq5xo-xEU_9E&callback=initMap">
</script>
<script>
var not_accessible_images = ["<?php echo implode('","', explode(", ", $issue['img'])); ?>"];
</script>

<div id="content">

	<div class="main">
		<table align="center">
			<tr>
				<td><button id="rotate_left" class="submit"><<</button></td>
				<td><div class="container" style="display: inline-block;">
				      <img id="not_accessible_image" src="<?= BASE_URL ?>/public/img/<?= explode(",", $issue['img'])[0]; ?>" alt="<?= $issue['summary'] ?>">
				  </div></td>
				<td><button id="rotate_right" class="submit">>></button></td>
			</tr>
		</table>
	</div>

	<div>
	<table>
		<tr>
		<td>
		<!-- <td><img class="issue-image" src="<?= BASE_URL ?>/public/img/<?= explode(",",$issue['img'])[0]; ?>" alt="<?= $issue['summary'] ?>" /></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td> -->
		<div id="map"></div><input id="address" type="textbox" value="<?= $issue['address'] ?>" style="display: none;"></div><div>
   </td>
		<td>
		<b>Address</b>: <a href="<?= BASE_URL ?>/issues/view/<?= $issue['id'] ?>/map"> <?= $issue['address'] ?> </a> <br />
		<b>Description</b>: <?= $issue['description'] ?><br />
		<b>Reporter</b>: <a href="account12.html"> <?= $issue['added_by'] ?> </a><br />
		<b>Date Added</b>: <a href="91516.html"> <?= $issue['date_added'] ?> </a><br />
		<button class="report-solved" id="<?= 'solve-'.$issue['id'] ?>">Report Solved</button><span class="note"><em class="num-reports"><?= $issue['solved'] ?></em> reports solved</span><br/>
	  </td>

	</tr>
	</table>
<br>
<br>
</div>

</div>
