<div id="content">
<br>
<br>

<?php while($row = mysql_fetch_assoc($result)): ?>

<table>
	<tr id="<?= 'issue-'.$row['id'] ?>">
	<td><img class="issue-image" src="<?= BASE_URL ?>/public/img/<?= explode(",", $row['img'])[0]; ?>" alt="<?= $row['summary'] ?>" /></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class="fields" id="<?= 'fields-'.$row['id'] ?>">
			<!-- <b>Address</b>: <a href="<?= BASE_URL ?>/issues/view/<?= $row['id'] ?>"><?= $row['address'] ?></a> <br /> -->
			<b>Address</b>: <span><?= $row['address'] ?></span> <br />
			<b>Summary</b>: <span><?= $row['summary'] ?></span> <br />
			<b>Reporter</b>: <span><?= $row['username'] ?></span> <br />
			<b>Date Added</b>: <span><?= $row['date_added'] ?></span> <br />
			<a class="linkbutton" href="<?= BASE_URL ?>/issues/view/<?= $row['id'] ?>">View</a>
			<button class="report-solved" id="<?= 'solve-'.$row['id'] ?>">Report Solved</button><span class="note"><em class="num-reports"><?= $row['solved'] ?></em> reports solved</span><br/>
			<!-- <form action="<?= BASE_URL ?>/issues/edit/<?= $row['id'] ?>" method="POST"> -->
	<?php
			if(isset($_SESSION['user'])){
				if ($_SESSION['user'] == $row['username'] || $_SESSION['privilege'] == 1){
					echo '<button class="edit-issue" id = edit-'.$row['id'].'>Edit</button><button class = "delete-issue" id = delete-'.$row['id'].'>Delete</button></td></tr>';
				}else{
					echo '</td></tr>';
				}
			}
	?>
</table>




<?php endwhile; ?>


</div>
