<?php

require_once 'HTTP/Request2.php';
include_once '../global.php';
$subscriptionKey = 'AIzaSyAla7FkKwsq9PehjiZ9gBEGq5xo-xEU_9E';

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

			case 'getVizData':
				$this->getVizData();
				break;

      default:
        header('Location: '.BASE_URL);
        exit();
		}
	}

  public function issues() {
		$pageName = 'Issues';

		$results = array();

		$issues = Issue::getAllIssues();
		foreach ($issues as $id) {
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
			if (strpos($issue['img'], "jpeg")===false){
				$issue['img'] = $issue['img'].".jpeg";
			}
			$issue['username'] = $user->get('username');
			array_push($results, $issue);
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
		$added_by = $_POST['added_by'];
		$img = $_FILES['img'];

		$geocoordinates = $this->fetch_coordinates($address);
		$group_id = $this->fetch_groupID($geocoordinates);
		// $uploaded = $this->uploadImage($_FILES, $_POST);
		// print_r($uploaded);
		// die();
		$issue = new Issue(array(
			'id' => null,
			'address' => $address,
			'description' => $description,
			'summary' => $summary,
			'date_added' => null,
			'img' => null,
			'added_by' => $added_by,
			'solved' => 0,
			'lat' => $geocoordinates['lat'],
			'lng' => $geocoordinates['lng'],
			'group_id' => $group_id
		));

		$issue->save();
		// $datetime = new DateTime();
		// $datetime->format('Y-m-d H:i:s')
		$id = Issue::loadLastAdded();
		// log the event
			$e = new Event(array(
					'event_type_id' => EventType::getIdByName('report_issue'),
					'user_1_id' => $_SESSION['user_id'],
					'issue_id' => $id,
			));

			$e->save();
			include_once SYSTEM_PATH.'/view/reportsuccess.tpl';

	}

	public function deleteIssue($id) {
		if ($this->isLoggedIn()) {
			if (Issue::deleteById($id)) {
				// delete the corresponding events
				Event::deleteByIssueId($id);

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
		//   UPDATE issue SET solved=solved+1 WHERE id=$id;

	  	$i = Issue::loadById($id);

		if ($solved == 'T'){
			$numSolved = $i->get('solved') + 1;
	  		$i->set('solved',$numSolved);
		}else{
			$numSolved = $i->get('solved') - 1;
	  		if ($numSolved >= 0){
	  			$i->set('solved',$numSolved);
	  		}else{
	  			$numSolved = 0;
	  			$i->set('solved',$numSolved);
	  		}
		}
		$i->save();
		$json = array( 'status' => 'success', 'solved' =>  $numSolved);
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

	public function getVizData() {
		$groups = array('0','1','2','3','4','5','6');
		// get all issues
		$issues = Issue::getAllIssues();

		$jsonIssues = array(); // array to hold json issues

		foreach($issues as $id) {
			// get details about each issue
			$i = Issue::loadById($id);
			$author = User::loadById($i->get('added_by'));
			$user = "guest";
			$privilege = '1';
			if (isset($_SESSION['user'])){
				$myuser = User::loadById($_SESSION['user_id']);
				$user = $myuser->get('username');
				$privilege = $myuser->get('privilege');
			}
			$jsonIssue = array(
				'id' => $id,
				'name' => "issue".$id,
				'address' => $i->get('address'),
				'description' => $i->get('description'),
				'summary' => $i->get('summary'),
				'date_added' => $i->get('date_added'),
				'group' => $i->get('group_id'),
				'img' => $i->get('img'),
				'solved' => $i->get('solved'),
				'author' => $author->get('username'),
				'privilege' => $privilege,
				'current_user' => $user
			);

			$jsonIssues[] = $jsonIssue;
		}

		foreach ($groups as $key => $value) {
			$jsonIssue = array(
				'id' => $id,
				'name' => "group".$value,
				'current_user' => $user,
				'author' => 'g',
				'privilege' => $privilege,
				'group' => $value,
			);

			$jsonIssues[] = $jsonIssue;
		}

		foreach ($jsonIssues as $key1 => $value1) {
			if ($value1['author']=='g'){
				foreach ($jsonIssues as $key2 => $value2) {
			    	if ($value1['group'] == $value2['group']){
						$jsonLink = array(
				    		'source' => $key1,
				    		'target' => $key2,
				    		'value' => 0.5,
				    	);
				    	$jsonLinks[] = $jsonLink;
				    }elseif ($value2['author']=='g') {
						$jsonLink = array(
				    		'source' => $key1,
				    		'target' => $key2,
				    		'value' => 0.1,
				    	);
				    	$jsonLinks[] = $jsonLink;
				    }
				}
			}
		}

		// finally, the json root object
		$json = array(
			'nodes' => $jsonIssues,
			'links' => $jsonLinks
		);

		header('Content-Type: application/json');
		echo json_encode($json);
		}

	public function haversine($coordinatesFrom, $coordinatesTo, $earthRadius = 6371){
	  // convert from degrees to radians
	  $latFrom = deg2rad($coordinatesFrom['lat']);
	  $lonFrom = deg2rad($coordinatesFrom['lng']);
	  $latTo = deg2rad($coordinatesTo['lat']);
	  $lonTo = deg2rad($coordinatesTo['lng']);

	  $latDelta = $latTo - $latFrom;
	  $lonDelta = $lonTo - $lonFrom;

	  $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
	    cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));
	  return $angle * $earthRadius;
	}

	public function fetch_groupID($coordinates){
		if ($coordinates['lat']==0 && $coordinates['lng']==0){
			return 0;
		}
		$min_dist = 63710 ; //in meters
		$group_id = 0;
		$seeds = Seed::loadAllSeeds();
		foreach ($seeds as $id) {
			if($id==0){
				continue;
			}
			else{
			$s = Seed::loadById($id);
			$seed_coordinates = array('lat' => $s->get('lat'), 'lng' => $s->get('lng') );
			$dist = $this->haversine($coordinates, $seed_coordinates);
			print_r($dist.' ');
			if($dist < $min_dist){
				$min_dist = $dist;
				$group_id = $s->get('id');
				}
	  	}
		}
		return $group_id;
	}

	public function fetch_coordinates($address, $subscriptionKey='AIzaSyAla7FkKwsq9PehjiZ9gBEGq5xo-xEU_9E'){
	  $request = new Http_Request2('https://maps.googleapis.com/maps/api/geocode/json');
	  // $request->setMethod(HTTP_Request2::METHOD_POST);
		$url = $request->getUrl();
		$query_params = array(
			 // Specify values for optional parameters, as needed
			 'address' => $address,
			 'key' => $subscriptionKey
			);

		$url->setQueryVariables($query_params);

	  try {
	    $response = $request->send();
	    $json = $response->getBody();
	    $jsonArr = json_decode($json, true);
			// if address can be decoded to a location
			if( isset($jsonArr['results'][0]['geometry']['location'])){
				return $jsonArr['results'][0]['geometry']['location'];
			}

			else{
				// else return coordinates as 0.0, 0.0
				return array(0.0, 0.0);
			}
		}
	  catch (HttpException $ex) {
	    echo "Exception: ".$ex."<br>";
	    exit();
	    }
	}

}
