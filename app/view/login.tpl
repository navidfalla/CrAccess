<div id="content">
<br>
<p id="logindes">Sign In using your PID if you have one, or sign up using your email.</p>
<form id="form-email" action="<?= BASE_URL ?>/login/process" method="POST">
	<p>Sign In Using Your Username</p>
	<table>
  <tr><td>Username:</td><td> <input type="text" name="un"></td></tr>
  <tr><td>Password:</td><td> <input type="password" name="pw"></td><tr>

  <tr><td><a class="btn btn-info" href="<?= BASE_URL ?>/signup">Sign Up</a></td><td><input class="submit btn btn-info" type="submit" value="Sign In"></td></tr>
</table>
</form>

<form id="form-pid">
	<p>Sign In Using Your PID [Coming Soon]</p>
	<table>
  <tr><td>PID:</td><td> <input type="text" name="address"></td></tr>
  <tr><td>Password:</td><td> <input type="password" name="description"></td><tr>
  <tr><td></td><td><input class="submit btn btn-info" type="submit" value="Sign In" disabled></td></tr>
</table>
</form>

<br>
</div>
