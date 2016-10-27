<div id="content">
<br>
<br>

<?php while($row = mysql_fetch_assoc($result)): ?>


<table>
	<tr id="<?= 'issue-'.$row['id'] ?>">
		<td><img class="issue-image" src="<?= BASE_URL ?>/public/img/<?= explode(",", $row['img'])[0]; ?>" alt="<?= $row['summary'] ?>" /></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td>
			<b>Address</b>: <a href="<?= BASE_URL ?>/issues/view/<?= $row['id'] ?>"><?= $row['address'] ?></a> <br />
			<b>Summary</b>: <?= $row['summary'] ?> <br />
			<b>Reporter</b>: <?= $row['username'] ?> <br />
			<b>Date Added</b>: <?= $row['date_added'] ?> <br />
			<a id="solved-button" href="solved.html">Report Solved</a><br>
			<form action="<?= BASE_URL ?>/issues/edit/<?= $row['id'] ?>" method="POST">
	<?php
			if(isset($_SESSION['user'])){
				if ($_SESSION['user'] == $row['username'] || $_SESSION['privilege'] == 1){
					echo '<button type="submit">Edit</button></form><button class = "delete-issue" id = '.$row['id'].'>Delete</button></td></tr>';
				}else{
					echo '</form></td></tr>';
				}
			}
	?>
</table>




<?php endwhile; ?>


</div>
