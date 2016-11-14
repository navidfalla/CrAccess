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

			case 'checkIssue':
				$issueID = $_GET['id'];
				$this->checkIssue($issueID);
				break;

			case 'deleteIssue':
				$issueID = $_GET['id'];
	 		 	$this->deleteIssue($issueID);
	 		 	break;

			case 'reportSolvedProcess':
				$issueID = $_GET['id'];
				$solved = $_GET['solved'];
				$this->reportSolvedProcess($issueID,$solved);
 				break;

			case 'showMap':
				$issueID = $_GET['id'];
				$this->showMap($issueID);
				break;

			case 'saveChanges':
				$issueID = $_GET['id'];
				$this->saveChanges($issueID);
				break;

      default:
        header('Location: '.BASE_URL);
        exit();
		}
	}

  public function issues() {
		$pageName = 'Issues';

		// $conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
		// 	or die ('Error: Could not connect to MySql database');
		// mysql_select_db(DB_DATABASE);
		//
		// $q = "SELECT issue.id, address, description, summary, date_added, img, username, solved FROM issue INNER JOIN user on added_by = user.id ORDER BY date_added; ";
		$result = array();

		$issues = Issue::getAllIssues();
		foreach ($issues as $id) {
			# code...
			$i = Issue::loadById($id);
			$issue = array();
			$issue['id'] = $id;
			$issue['address'] = $i->get('address');
			$issue['description'] = $i->get('description');
			$issue['summary'] = $i->get('summary');
			$issue['date_added'] = $i->get('date_added');
			$user = User::loadById($i->get('added_by'));
			$issue['solved'] = $i->get('solved');
			$issue['img'] = $i->get('img');
			$issue['username'] = $user->get('username');
			array_push($result, $issue);
		};
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

		$address = $_POST['address'];
		$description = $_POST['description'];
		$summary = $_POST['summary'];
		$img = $_POST['img'];
		$added_by = $_POST['added_by'];

		$issue = new Issue(array(
			'id' => null,
			'address ' => $address,
			'description' => $description,
			'summary' => $summary,
			'date_added' => null,
			'img' => $img,
			'added_by' => $added_by,
			'solved' => 0
		));

		$issue->save();
	}

	public function deleteIssue($id) {
		if ($this->isLoggedIn()) {
			$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
				or die ('Error: Could not connect to MySql database');
			mysql_select_db(DB_DATABASE);

			$sql =	"DELETE FROM issue WHERE id='".$id."'";
			if (mysql_query($sql)) {
				$json = array( 'status' => 'success' );
			}else{
				$json = array( 'status' => 'fail' );
			}
		}else {
			$json = array( 'status' => 'unauthorized' );
		}
		header('Content-Type: application/json');
		echo json_encode($json);
    }

	public function reportSolvedProcess($id,$solved) {
	  if ($this->isLoggedIn()) {
		  $conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
			  or die ('Error: Could not connect to MySql database');
		  mysql_select_db(DB_DATABASE);

		//   UPDATE issue SET solved=solved+1 WHERE id=$id;
		if ($solved == 'T'){
			$sql =	"UPDATE issue SET solved=solved+1 WHERE id='".$id."'";
		}else{
			$sql =	"UPDATE issue SET solved=solved-1 WHERE id='".$id."' and solved >= 0";
		}
		  if (mysql_query($sql)) {
			  $q = "SELECT solved FROM issue WHERE id='".$id."'";
	  		  $result = mysql_query($q);
			  $row = mysql_fetch_assoc($result);
			  $json = array( 'status' => 'success', 'solved' =>  $row['solved']);
		  }else{
			  $json = array( 'status' => 'fail' );
		  }
	  }else {
		  $json = array( 'status' => 'unauthorized' );
	  }
	  header('Content-Type: application/json');
	  echo json_encode($json);
	}

	public function checkIssue($id) {
		if ($id == null){
			$issue = array( 'status' => 'null' );
		}else{
			$i = Issue::loadById($id);

			$issue = array();
			$issue['id'] = $id;
			$issue['address'] = $i->get('address');
			$issue['description'] = $i->get('description');
			$issue['summary'] = $i->get('summary');
			$issue['date_added'] = $i->get('date_added');
			$issue['added_by'] = $i->get('added_by');
			$issue['solved'] = $i->get('solved');
			$issue['img'] = $i->get('img');

			$u = User::loadById($issue['added_by']);
			$issue['username'] = $u->get('username');
			$issue['status'] = 'success';
		}
		header('Content-Type: application/json');
		echo json_encode($issue);
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
		$issue['id'] = $i->get('id');
		$issue['solved'] = $i->get('solved');

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/issue.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
    }

	public function showMap($id){
		$pageName = 'Map';
		$issue = Issue::loadById($id);
		$issueAddress = $issue->get('address');
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/map.tpl';
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

		$i->save();

		header('Location: '.BASE_URL.'/issues/');
	}

	public function saveChanges($id) {
		$address = $_POST['address'];
		$description = $_POST['description'];
		$summary = $_POST['summary'];

		$i = Issue::loadById($id);
		$i->set('address', $address);
		$i->set('description', $description);
		$i->set('summary', $summary);

		$i->save();
		$issue = array();
		$issue['id'] = $id;
		$issue['address'] = $i->get('address');
		$issue['description'] = $i->get('description');
		$issue['summary'] = $i->get('summary');
		$issue['date_added'] = $i->get('date_added');
		$issue['added_by'] = $i->get('added_by');
		$issue['solved'] = $i->get('solved');
		$issue['img'] = $i->get('img');

		$u = User::loadById($issue['added_by']);
		$issue['username'] = $u->get('username');
		$issue['status'] = 'success';
		header('Content-Type: application/json');
		echo json_encode($issue);
	}

}
