<div id="content">
	<div id="main">
		<div id="report-view">
		<a href="<?= BASE_URL ?>/report">
			<img class="main-image" src="public/img/add.png" alt="Report a new issue" /></a>
			<br>
			<a href="<?= BASE_URL ?>/report">
			<b>Report an Issue</b>
			</a>
		<br>
		187 Issues reported so far
		</div>
		<div id="map-view">
			<a href="<?= BASE_URL ?>/map">
			<img class="main-image" src="<?= BASE_URL ?>/public/img/map.png" alt="Accessibility Issue Map" /></a>
			<br>
			<a href="<?= BASE_URL ?>/map">
			<b>Accessibility Issue Map</b>
		</a>
		</div>
		<?php
				if(isset($_SESSION['user'])) {
		?>
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
	</div>
	<div id="follow-view">
		<h3>More people to follow?</h3>
		<div id="follow-users">
			<?php
			foreach ($users as $user) {
				if(in_array($user[0], $followeeIds)){
				echo '<div id='.$user[0].'><a href='.BASE_URL.'/view/profile/'.$user[0].'>'.$user[1].'</a><br><button class="btn btn-primary follow-behavior">Unfollow</button></div>';
				}
				else{
					echo '<div id='.$user[0].'><a href='.BASE_URL.'/view/profile/'.$user[0].'>'.$user[1].'</a><br><button class="btn btn-primary follow-behavior">Follow</button></div>';
				}
			}
			?>
		</div>
	</div>
	<?php
		} else {
	?>
	</div>
	<?php
		}
	?>
</div>

</div>
