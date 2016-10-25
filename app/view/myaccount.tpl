<div id="content">
<br>
<form id="account">
	<table>
  <tr><td>User Name:</td><td><input type="text" name="username" title="User Name" style="color:#888;"
	    value="<?= $user['username'] ?>" onfocus="inputFocus(this)" onblur="inputBlur(this)" disabled="disabled"/></td>
			<tr><td></td><td><input class="submit" type="button" value="Edit Profile"></td></tr>
  <tr><td>Points:</td><td> <input type="text" name="points" title="Points" style="color:#888;"
	    value="12500" onfocus="inputFocus(this)" onblur="inputBlur(this)" disabled="disabled"/></td>
			<tr><td></td><td><input class="submit" type="button" value="Redeem Your Points"></td></tr>
		</table>
</form>
<form id="logout" action="<?= BASE_URL ?>/logout" method="POST">
	<button type="submit">Logout</button>
	</form>

<br>


<div id="your_img">
	<p> Recently Added By You </p>

	<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp.jpg" alt="this ramp is broken" />
	<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp2.jpg" alt="this ramp is broken" />
	<img class="your_image" src="<?= BASE_URL ?>/public/img/noramp3.jpg" alt="this ramp is broken" />



</div>
</div>
