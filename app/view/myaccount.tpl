<div id="content">
<br>
<?php
	$a = "";
	$m = "";
	$u = "";
	$edit = "";
	if ($user['privilege'] == 1){
		#normal user
		$edit = "disabled";
		$u = "selected";
	}
	if ($user['privilege'] == 0){
		#moderators
		$edit = "disabled";
		$m = "selected";
	}
	if ($user['privilege'] == 2){
		#admin
		$a = "selected";
	}
?>
<div id="<?= $_SESSION['user_id'] ?>" class="profile">
	<label>Username: </label><input type='text' name='username' class="form-control" value="<?= $user['username']?>" disabled/>
	<label>User Type: </label>
	<select class="form-control" name='usertype' <?= $edit?> >
		<option id='admin' <?= $a?>>Admin</option>
		<option id='moderator' <?= $m?>>Moderator</option>
		<option id='user' <?= $u?>>User</option>
	</select>
	<label>First Name: </label><input type='text' name='first_name' class="form-control" value="<?= $user['firstname']?>" disabled/>
	<label>Last Name: </label><input type='text' name='last_name' class="form-control" value="<?= $user['lastname']?>" disabled/>
	<label>Email Address: </label><input type='email' name='email' class="form-control" value="<?= $user['email']?>" disabled/>
	<label>Password: </label><input type='password' name='password' class="form-control" value="<?= $user['password']?>" disabled/>
	<label>Point Balance: <span class="badge">150</span></label><br>
	<button id='edit-profile' class="btn btn-default">Edit Profile</button>
	<button id='edit-profile' class="btn btn-default">Redeem Points</button>

	<form id="logout" action="<?= BASE_URL ?>/logout" method="POST">
		<button type="submit" class="btn btn-primary">Logout</button>
	</form>
</div>
<div id="activity-feed">
	<div id="activity-view">
		<?php if(isset($events)): ?>

		<h3>Recent Activity</h3>
			<?php if(count($events) == 0): ?>
		<div class="well"> <p>No recent activity.</p> </div>
			<?php else: ?>

		<div class="well activity-feed">
			<?php foreach($events as $event): ?>
				<p><?= formatEvent($event) ?></p>
			<?php endforeach; ?>
		</div>

			<?php endif; ?>

		<?php endif; ?>
	</div>
	<div id="your_img">
		<p> Recently Added By You </p>

		<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp.jpg" alt="this ramp is broken" />
		<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp2.jpg" alt="this ramp is broken" />
		<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp3.jpg" alt="this ramp is broken" />

	</div>
</div>

</div>
