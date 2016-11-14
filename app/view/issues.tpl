<div id="content">
<br>
<br>

<?php foreach($results as $issue){ ?>

<?php 
	$myimg = explode(",", $issue['img'])[0];
	if ($myimg == ""){
		$myimg = 'no-image-found.gif';
	}
?>

<table>
	<tr id="<?= 'issue-'.$issue['id'] ?>">
	<td><img class="issue-image" src="<?= BASE_URL ?>/public/img/<?= $myimg ?>" alt="<?= $issue['summary'] ?>" /></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class="fields" id="<?= 'fields-'.$issue['id'] ?>">
			<!-- <b>Address</b>: <a href="<?= BASE_URL ?>/issues/view/<?= $issue['id'] ?>"><?= $issue['address'] ?></a> <br /> -->
			<b>Address</b>: <span><?= $issue['address'] ?></span> <br />
			<b>Summary</b>: <span><?= $issue['summary'] ?></span> <br />
			<b>Reporter</b>: <span><?= $issue['username'] ?></span> <br />
			<b>Date Added</b>: <span><?= $issue['date_added'] ?></span> <br />
			<a class="linkbutton" href="<?= BASE_URL ?>/issues/view/<?= $issue['id'] ?>">View</a>
			<button class="report-solved" id="<?= 'solve-'.$issue['id'] ?>">Report Solved</button><span class="note"><em class="num-reports"><?= $issue['solved'] ?></em> reports solved</span><br/>
			<!-- <form action="<?= BASE_URL ?>/issues/edit/<?= $issue['id'] ?>" method="POST"> -->
	<?php
			if(isset($_SESSION['user'])){
				if ($_SESSION['user'] == $issue['username'] || $_SESSION['privilege'] == 1){
					echo '<button class="edit-issue" id = edit-'.$issue['id'].'>Edit</button><button class = "delete-issue" id = delete-'.$issue['id'].'>Delete</button></td></tr>';
				}else{
					echo '</td></tr>';
				}
			}
	?>
</table>




<?php }; ?>


</div>
