<div id="content">
<br>
<?php
	$a = "";
	$m = "";
	$u = "";
	$edit = "";
	$makepost = "hidden";
	if ($_SESSION['privilege'] == 1){
		#normal user
		$edit = "disabled";
	}
	if ($_SESSION['privilege'] == 0){
		#moderators
		$edit = "disabled";
	}

	if ($_SESSION['privilege'] == 2){
		#admin
		$makepost = "";
	}

	if ($user['privilege'] == 1){
		#normal user
		$u = "checked";
	}
	if ($user['privilege'] == 0){
		#moderators
		$m = "checked";
	}
	if ($user['privilege'] == 2){
		#admin
		$a = "checked";
	}

?>
<div id="<?= $user['user_id'] ?>" class="profile">
	<label>Username: </label><input type='text' name='username' class="form-control" value="<?= $user['username']?>" disabled/>
	<label>User Type: </label>
	<label class="checkbox-inline"><input name='privilege' type='checkbox' id='admin' value='2' <?= $a?> <?= $edit?>/>Admin</label>
	<label class="checkbox-inline"><input name='privilege' type='checkbox' id='moderator' value='0' <?= $m?> <?= $edit?>/>Moderator</label>
	<label class="checkbox-inline"><input name='privilege' type='checkbox' id='user' value='1' <?= $u?> <?= $edit?>/>User</label>
	<label>First Name: </label><input type='text' name='first_name' class="form-control" value="<?= $user['firstname']?>" disabled/>
	<label>Last Name: </label><input type='text' name='last_name' class="form-control" value="<?= $user['lastname']?>" disabled/>
	<label>Email Address: </label><input type='email' name='email' class="form-control" value="<?= $user['email']?>" disabled/>
	<!-- <label>Password: </label><input type='password' name='password' class="form-control" value="<?= $user['password']?>" disabled/> -->
	<label>Point Balance: <span class="badge">150</span></label><br>

</div>
<div id="activity-feed">
	<!-- <h3>Activity Feed</h3> -->
	<div id="your_img">
		<p> Recently Added By You </p>

		<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp.jpg" alt="this ramp is broken" />
		<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp2.jpg" alt="this ramp is broken" />
		<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp3.jpg" alt="this ramp is broken" />

	</div>
</div>

</div>
