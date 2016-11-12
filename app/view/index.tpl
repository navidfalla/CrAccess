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
			<a href="map.html">
			<img class="main-image" src="public/img/map.png" alt="Accessibility Issue Map" /></a>
			<br>
			<a href="map.html">
			<b>Accessibility Issue Map</b>
		</a>
		</div>
		<?php
				if(isset($_SESSION['user'])) {
		?>
		<div id="activity-view">
			<h3>Activity Feed</h3>
		</div>
	</div>
	<div id="follow-view">
		<h3>Who to follow</h3>
		<div id="follow-users">
			<?php
			foreach ($users as $user) {
				echo '<div id='.$user[0].'><label>'.$user[1].'</label><button class="btn btn-info">Follow</button></div>';
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
