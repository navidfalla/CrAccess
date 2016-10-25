<?php

include_once '../global.php';

$action = $_GET['action'];

$pc = new IssueController();
$pc->route($action);

class IssueController {

	public function route($action) {
		switch($action) {
			case 'issues':
			  $this->issues();
				break;

			 case 'report':
			 	$this->report();
			 	break;

			case 'reportProcess':
				 $this->reportProcess();
				 break;

 			case 'viewIssue':
         $issueID = $_GET['id'];
 				$this->viewIssue($issueID);
 				break;

 			case 'editIssue':
         $issueID = $_GET['id'];
 				$this->editIssue($issueID);
 				break;

 			case 'editIssueProcess':
 				$issueID = $_GET['id'];
 				$this->editIssueProcess($issueID);
 				break;

			case 'deleteIssue':
				$issueID = $_GET['id'];
	 		 	$this->deleteIssue($issueID);
	 		 	break;

      default:
        header('Location: '.BASE_URL);
        exit();
		}
	}

  public function issues() {
		$pageName = 'Issues';

		$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
			or die ('Error: Could not connect to MySql database');
		mysql_select_db(DB_DATABASE);

		$q = "SELECT issue.id, address, description, summary, date_added, img, username FROM issue INNER JOIN user on added_by = user.id ORDER BY date_added; ";
		$result = mysql_query($q);

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/issues.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }

	public function isLoggedIn() {
		return isset($_SESSION['user']);
	}

	public function report() {
		$pageName = 'Report';
		if ($this->isLoggedIn()) {
			include_once SYSTEM_PATH.'/view/header.tpl';
			include_once SYSTEM_PATH.'/view/report.tpl';
			include_once SYSTEM_PATH.'/view/footer.tpl';
		} else {
			header('Location: '.BASE_URL.'/login/');
		}
	}

	public function reportProcess() {

		$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
			or die ('Error: Could not connect to MySql database');
		mysql_select_db(DB_DATABASE);

		$address = $_POST['address'];
		$description = $_POST['description'];
		$summary = $_POST['summary'];
		$img = $_POST['img'];
		$added_by = $_POST['added_by'];

		$sql = "INSERT INTO issue (address, description, summary, img, added_by) VALUES ('".$address."', '".$description."', '".$summary."', '".$img."', '".$added_by."')";
		if(mysql_query($sql)) {
			include_once SYSTEM_PATH.'/view/reportsuccess.tpl';
		}
		else {
			echo "Something wrong!<br>";

		}
	}

	public function deleteIssue($id) {
		if ($this->isLoggedIn()) {
			$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
				or die ('Error: Could not connect to MySql database');
			mysql_select_db(DB_DATABASE);


			$sql =	"DELETE FROM issue WHERE id='".$id."'";
			if (mysql_query($sql)) {
			include_once SYSTEM_PATH.'/view/deletesuccess.tpl';
			}
		}	else {
			header('Location: '.BASE_URL.'/login/');
		}

  }

	public function viewIssue($id) {
		$pageName = 'Issue';

		$i = Issue::loadById($id);

		$issue = array();
		$issue['address'] = $i->get('address');
		$issue['description'] = $i->get('description');
		$issue['summary'] = $i->get('summary');
		$issue['date_added'] = $i->get('date_added');
		$issue['added_by'] = $i->get('added_by');
		$issue['img'] = $i->get('img');

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/issue.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }

	public function editIssue($id) {
		$pageName = 'Edit Issue';
		if ($this->isLoggedIn()) {

		$i = Issue::loadById($id);

		$issue = array();
			$issue['address'] = $i->get('address');
			$issue['description'] = $i->get('description');
			$issue['summary'] = $i->get('summary');
			$issue['img'] = $i->get('img');

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/editIssue.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	} else {
		header('Location: '.BASE_URL.'/login/');
	}
}
	public function editIssueProcess($id) {
		$address = $_POST['address'];
		$description = $_POST['description'];
		$summary = $_POST['summary'];
		$img = $_POST['img'];

	$i = Issue::loadById($id);
		$i->set('address', $address);
		$i->set('description', $description);
		$i->set('summary', $summary);
		$i->set('img', $img);

	$i->save();

	header('Location: '.BASE_URL.'/issues/');
}

}
