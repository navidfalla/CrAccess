<?php

include_once '../global.php';

$action = $_GET['action'];

$pc = new SiteController();
$pc->route($action);

class SiteController {

	public function route($action) {
		switch($action) {
			case 'index':
				$this->index();
				break;

			case 'homePageMap':
				$this->homePageMap();
				break;

			case 'whoarewe':
				$this->whoarewe();
				break;

			case 'howto':
				$this->howto();
				break;

			case 'login':
				$this->login();
				break;

			case 'logout':
				$this->logout();
				break;

			case 'signup':
				$this->signup();
				break;

			case 'signupProcess':
				 $this->signupProcess();
					break;

			case 'myaccount':
				$this->myaccount();
				break;

			case 'profile_view':
				$user_id = $_GET['user_id'];
				$this->profile($user_id);
				break;

			case 'processLogin':
				$username = $_POST['un'];
				$password = $_POST['pw'];
				$this->processLogin($username, $password);
				break;

			case 'processProfile':
				$info = array();
				$info['user_id'] = $_POST['user_id'];
				$info['username'] = $_POST['username'];
				$info['firstname'] = $_POST['firstname'];
				$info['lastname'] = $_POST['lastname'];
				$info['email'] = $_POST['email'];
				$info['password'] = $_POST['password'];
				$this->processProfile($info);
				break;

			case 'changeRole':
				$user_id = $_POST['user_id'];
				$privilege = $_POST['privilege'];
				$this->changeRole($user_id,$privilege);
				break;

			case 'checkUsername':
				$username = $_GET['username'];
				$this->checkUsername($username);
				break;

			case 'follow':
				$followeeId = $_POST['userId'];
				$this->followUser($followeeId);
				break;

			case 'unfollow':
				$followeeId = $_POST['userId'];
				$this->unfollowUser($followeeId);
				break;

      default:
        header('Location: '.BASE_URL);
        exit();
		}
	}

	public function homePageMap(){
		// include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/404.tpl';
	// 	include_once SYSTEM_PATH.'/view/footer.tpl';
	}

  public function index() {
		$pageName = 'Home';
		if (isset($_SESSION['user'])){
			$followees = Follow::getFolloweesByUserId($_SESSION['user_id']);
			$followeeIds = array();
			foreach ($followees as $followee) {
				$followeeIds[] = $followee->get('id');
			}
			$users = User::getAllUsersExceptThis($_SESSION['user_id']);
			$num_events = 10;
			// get the last 15 events
			$events = Event::getEventsByUserId($_SESSION['user_id'], $num_events);
		}else{
			$users = null;
		}
		include_once SYSTEM_PATH.'/view/helpers.php';
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/index.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }

  public function whoarewe() {
		$pageName = 'whoarewe';

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/whoarewe.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }

	public function howto() {
		$pageName = 'howto';

		include_once SYSTEM_PATH.'/view/404.tpl';
  }

	public function login() {
		$pageName = 'Sign In';
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/login.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }

	public function myaccount() {
		$pageName = 'My Account';
		$user = array();
		// fetch only reported issues
		$event_type_id = EventType::getIdByName('report_issue');
		$events = Event::getEventsByType($_SESSION['user_id'], $event_type_id);

		if (isset($_SESSION['user'])){
			$u = User::loadById($_SESSION['user_id']);
			$user['username'] = $u->get('username');
			$user['privilege'] = $u->get('privilege');
			$user['firstname'] = $u->get('first_name');
			$user['lastname'] = $u->get('last_name');
			$user['password'] = $u->get('password');
			$user['email'] = $u->get('email');
			include_once SYSTEM_PATH.'/view/helpers.php';
			include_once SYSTEM_PATH.'/view/header.tpl';
			include_once SYSTEM_PATH.'/view/myaccount.tpl';
			include_once SYSTEM_PATH.'/view/footer.tpl';
		}else {
			$user = null;
			header('Location: '.BASE_URL."/login");
			exit();
		}

	}

	public function profile($user_id){
		$pageName = 'profile_view';
		$user = array();
		$u = User::loadById($user_id);

		// print_r($u);
		if ($u != null){
			$user['user_id'] = $user_id;
			$user['username'] = $u->get('username');
			$user['privilege'] = $u->get('privilege');
			$user['firstname'] = $u->get('first_name');
			$user['lastname'] = $u->get('last_name');
			$user['password'] = $u->get('password');
			$user['email'] = $u->get('email');
			include_once SYSTEM_PATH.'/view/header.tpl';
			include_once SYSTEM_PATH.'/view/profile.tpl';
			include_once SYSTEM_PATH.'/view/footer.tpl';
		}else {
			$user = null;
			header('Location: '.BASE_URL."/");
			exit();
		}

	}

	public function signup() {
		$pageName = 'signup';
			include_once SYSTEM_PATH.'/view/header.tpl';
			include_once SYSTEM_PATH.'/view/signup.tpl';
			include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	public function signupProcess() {

		$first_name = $_POST['first_name'];
		$last_name = $_POST['last_name'];
		$email = $_POST['email'];
		$username = $_POST['username'];
		$password = $_POST['password'];


		$nu = new User (array (
		'first_name' => $first_name,
		'last_name' => $last_name,
		'email' => $email,
		'username' => $username,
		'password' => $password

		));
		$nu->save();

		include_once SYSTEM_PATH.'/view/signupsuccess.tpl';

	}


	public function processLogin($u, $p) {

		$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
			or die ('Error: Could not connect to MySql database');
		mysql_select_db(DB_DATABASE);

		$q = "SELECT * FROM user WHERE username = '".$u."' and password = '".$p."'";
		$result = mysql_query($q);
		$row = mysql_fetch_assoc($result);
		if ($row != null) {
			session_start();
			$_SESSION['user'] = $u;
			$_SESSION['user_id'] = $row['id'];
			$_SESSION['privilege'] = $row['privilege'];
			header('Location: '.BASE_URL."/myaccount");
		} else {
			header('Location: '.BASE_URL."/login");
			exit();
		}
	}

	public function processProfile($info) {

		$_SESSION['username']=$info['username'];
		$u = User::loadById($info['user_id']);
		$u->update($info);
		header('Location: '.BASE_URL."/myaccount");
	}

	public function changeRole($user_id,$privilege) {
		$u = User::loadById($user_id);
		$response = $u->changeUserRole($user_id,$privilege);
		// $u->set('first_name',$info['first_name']);
		// $u->set('last_name',$info['last_name']);
		// $u->set('password',$info['password']);
		// $u->set('email',$info['email']);
		echo json_encode($response);
		// header('Location: '.BASE_URL."/view/profile/".$user_id);
	}

	public function logout() {
		unset($_SESSION['user']);
		unset($_SESSION['user_id']);
		header('Location: '.BASE_URL.'/login/');
	}
	public function unfollowUser($followeeId) {
		$followerId = $_SESSION['user_id'];
		if(Follow::deleteFollow($followeeId, $_SESSION['user_id'])){
			$json = array('success' => 'success');
			echo json_encode($json);
		}
		else{
			$json = array('error' => 'Could not unfollow this user!');
			echo json_encode($json);
		}
	}

	public function followUser($followeeId) {
			// user is logged in
			// get user ID for followee
			$followee = User::loadById($followeeId);
			$followeeUsername = $followee->get('username');
			// does this follow already exist?
			$f = Follow::loadByUsernames($_SESSION['user'], $followeeUsername);
			if($f != null) {
				// follow already happened!
				$json = array('error' => 'You already followed this user.');
				echo json_encode($json);
			}
		else{
			// log the event
			$e = new Event(array(
					'event_type_id' => EventType::getIdByName('follow_user'),
					'user_1_id' => $_SESSION['user_id'],
					'user_2_id' => $followee->get('id')
			));
			$e->save();
			// save the new follow
				$f = new Follow(array(
					'follower_id' => $_SESSION['user_id'],
					'followee_id' => $followeeId
					));
				$f->save();
				$json = array('success' => 'success');
				echo json_encode($json);
			}

			header('Content-Type: application/json');
		}

}
