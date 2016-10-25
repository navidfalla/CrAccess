<div id="content">
<br>
<br>

<?php while($row = mysql_fetch_assoc($result)): ?>


<table>
	<form action="<?= BASE_URL ?>/issues/edit/<?= $row['id'] ?>" method="POST">

	<tr><td><img class="issue-image" src="<?= BASE_URL ?>/public/img/<?= explode(",", $row['img'])[0]; ?>" alt="<?= $row['summary'] ?>" /></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
	<b>Address</b>: <a href="<?= BASE_URL ?>/issues/view/<?= $row['id'] ?>"><?= $row['address'] ?></a> <br />
	<b>Summary</b>: <?= $row['summary'] ?> <br />
	<b>Reporter</b>: <?= $row['username'] ?> <br />
	<b>Date Added</b>: <?= $row['date_added'] ?> <br />
	<a href="solved.html"><b>This issue has not been solved yet.</b></a><br>
	<button type="submit">Edit</button>
	</form>
	<form class="delete-form" style="display: inline;" action="<?= BASE_URL ?>/issues/delete/<?= $row['id'] ?>" method="POST">
		<button type="submit">Delete</button>
	</form></td></tr>
</table>





<?php endwhile; ?>


</div>
