<div id="content">
<br>
<br>

<form id="report-form" action="<?= BASE_URL ?>/report/process" method = "POST">
	<table>
  <tr><td>Address:</td><td> <input type="text" name="address" style="width: 369px;" id="address"></td></tr>
  <tr><td>Description:</td><td> <textarea name="description" id="description" rows="8" cols="103">Write a description of the issue in detail...</textarea></td></tr>
	<tr><td>Summary:</td><td> <textarea name="summary" id="summary" rows="4" cols="103">Write a summary less than 20 words...</textarea></td></tr>
	<tr><td>Upload Images:</td><td> <input type="file" name="img" id="img"></td></tr>
	<input type="hidden" name="added_by" value="<?= $_SESSION['user_id'] ?>">
  <tr><td></td><td><input class="submit" type="submit" value="Submit"></td></tr>
</table>
</form>


</div>
