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

			case 'login':
				$this->login();
				break;

			case 'logout':
				$this->logout();
				break;

				case 'myaccount':
					$this->myaccount();
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

			case 'checkUsername':
				$username = $_GET['username'];
				$this->checkUsername($username);
				break;

      default:
        header('Location: '.BASE_URL);
        exit();

		}
	}

  public function index() {
		$pageName = 'Home';
		if (isset($_SESSION['user'])){
			$users = User::getAllUsers();
		}else{
			$users = null;
		}
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/index.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
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
		if (isset($_SESSION['user'])){
			$u = User::loadById($_SESSION['user_id']);
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
			header('Location: '.BASE_URL."/login");
			exit();
		}


		//  $sql = "SELECT img FROM issue INNER JOIN user on added_by = user.id WHERE user.id = 1 AND issue.id = 2 ORDER BY date_added; ";
		//  $imgs = explode(", ", mysql_fetch_assoc(mysql_query($sql)));

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
		//
		$u = User::loadById($info['user_id']);
		$u->update($info);
		// $u->set('first_name',$info['first_name']);
		// $u->set('last_name',$info['last_name']);
		// $u->set('password',$info['password']);
		// $u->set('email',$info['email']);

		header('Location: '.BASE_URL."/myaccount");
	}

	public function logout() {
		unset($_SESSION['user']);
		unset($_SESSION['user_id']);
		header('Location: '.BASE_URL.'/login/');
	}
<<<<<<< Updated upstream
=======

	public function followUser($followeeId) {
			// user is logged in
			// get user ID for followee
			$followee = User::loadById($followeeId);
			$followeeUsername = $followee->get('username');
			echo 'here';
			// does this follow already exist?
			$f = Follow::loadByUsernames($_SESSION['user'], $followeeUsername);
			if($f != null) {
				// follow already happened!
				$json = array('error' => 'You already followed this user.');
				echo json_encode($json);
			}
			// save the new follow
				$f = new Follow(array(
					'id' => 1,
					'follower_id' => $_SESSION['user_id'],
					'followee_id' => $followeeId
					));
				$f->save();
		}

>>>>>>> Stashed changes
}
