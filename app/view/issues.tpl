<div id="content">

<div class="report-btn">
Report issue
	<a class="btn btn-info linkbutton" href="<?= BASE_URL ?>/report">
		<span class="glyphicon glyphicon-plus"></span></a>
	</button>
</div>
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
			<b>Last Modified</b>: <span><?= $issue['date_added'] ?></span> <br />
			<a class="btn btn-default linkbutton" href="<?= BASE_URL ?>/issues/view/<?= $issue['id'] ?>">View</a>
			<button class="btn btn-default report-solved" id="<?= 'solve-'.$issue['id'] ?>">Report Solved</button><span class="note"><em class="num-reports"><?= $issue['solved'] ?></em> reports solved</span><br/>
	<?php
			if(isset($_SESSION['user'])){
				if ($_SESSION['privilege'] != 1){
					echo '<button class="btn btn-default edit-issue" id = edit-'.$issue['id'].'>Edit</button><button class = "btn btn-default delete-issue" id = delete-'.$issue['id'].'>Delete</button></td></tr>';
				}else if ($_SESSION['user'] == $issue['username']){
					echo '<button class="btn btn-default edit-issue" id = edit-'.$issue['id'].'>Edit</button></td></tr>';
				}else{
					echo '</td></tr>';
				}
			}
	?>
</table>




<?php }; ?>


</div>
