<div id="content">
<br>
<p id="logindes">Sign In using your PID if you have one, or sign up using your email.</p>
<form id="form-email" action="<?= BASE_URL ?>/login/process" method="POST">
	<p>Sign In Using Your Email</p>
	<table>
  <tr><td>Email:</td><td> <input type="text" name="un"></td></tr>
  <tr><td>Password:</td><td> <input type="password" name="pw"></td><tr>

  <tr><td><a href="signup.html">Sign Up</a></td><td><input class="submit" type="submit" value="Sign In"></td></tr>
</table>
</form>

<form id="form-pid">
	<p>Sign In Using Your PID</p>
	<table>
  <tr><td>PID:</td><td> <input type="text" name="address"></td></tr>
  <tr><td>Password:</td><td> <input type="password" name="description"></td><tr>
  <tr><td></td><td><input class="submit" type="submit" value="Sign In"></td></tr>
</table>
</form>

<br>
</div>
