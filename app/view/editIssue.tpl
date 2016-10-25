<div id="content">

<h2>Edit Issue</h2>

<form id="edit-issue" action="<?= BASE_URL ?>/issues/edit/<?= $id ?>/process" method="POST">

  <label>Address: <input type="text" name="address" value="<?= $issue['address'] ?>"></label>

  <label>Description: <textarea name="description"><?= $issue['description'] ?></textarea></label>

  <label>Summary: <textarea name="summary"><?= $issue['summary'] ?></textarea></label>

  <label>Image URL: <input type="text" name="img" value="<?= $issue['img'] ?>"></label>

  <input type="submit" name="submit" value="Save Changes">

</form>

</div>
