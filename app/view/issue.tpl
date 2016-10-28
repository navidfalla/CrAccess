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
		<tr><td><img class="issue-image" src="<?= BASE_URL ?>/public/img/<?= explode(",",$issue['img'])[0]; ?>" alt="<?= $issue['summary'] ?>" /></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
		<b>Address</b>: <a href="<?= BASE_URL ?>/issues/view/<?= $issue['id'] ?>/map"> <?= $issue['address'] ?> </a> <br />
		<b>Description</b>: <?= $issue['description'] ?><br />
		<b>Reporter</b>: <a href="account12.html"> <?= $issue['added_by'] ?> </a><br />
		<b>Date Added</b>: <a href="91516.html"> <?= $issue['date_added'] ?> </a><br />
		<a href="solved.html"><b>This issue has not been solved yet.</b></a></td></tr>
	</table>
<br>
<br>
</div>

</div>
