<?php

function isSelected($pn, $link) {
	if($pn == $link) {
		return ' id="selected-nav" ';
	}
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
  <meta name="description" content="Wheels is a website for reporting accesibility issues on Virginia Tech's campus">
	<title>Hokie Gear | <?= $pageName ?></title>


	<style type="text/css">


	</style>

	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
  <script type="text/javascript" src="<?= BASE_URL ?>/public/js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript">
	  var baseURL = '<?= BASE_URL ?>';
  </script>
  <script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>

</head>

<body>

	<div id="header">

	<h1>Wheels</h1>

	<hr>
	<br>

	<ul id="primary-nav">
		<li><a <?= isSelected($pageName, 'Home') ?> href="<?= BASE_URL ?>/">Home</a></li>
		<li><a <?= isSelected($pageName, 'Issues') ?> href="<?= BASE_URL ?>/issues">Issues</a></li>
		<li><a <?= isSelected($pageName, 'Who Are We?') ?> href="<?= BASE_URL ?>/whoarewe">Who Are We?</a></li>
		<li><a <?= isSelected($pageName, 'How To') ?> href="<?= BASE_URL ?>/howto">How To</a></li>
<?php
		if(!isset($_SESSION['user'])) {
?>
		<li><a <?= isSelected($pageName, 'Login') ?> href="<?= BASE_URL ?>/login">Log In</a></li>
<?php
	} else {
?>
		<li><a <?= isSelected($pageName, 'My Account') ?> href="<?= BASE_URL ?>/myaccount">My Account</a></li>
<?php
	}
?>
		<li style="border-style: none; text-align: left;"><div style="width: 250px; display: inline-block;"><input style="border: 2px solid; border-color: #CCC;" id="search_bar" type="text" name="search" placeholder="Search Issues.."></div></li>
	</ul>

	</div>
