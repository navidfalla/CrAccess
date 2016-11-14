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

			case 'signup':
				$this->signup();
				break;

			case 'signupProcess':
				 $this->signupProcess();
					break;

				case 'myaccount':
					$this->myaccount();
					break;

			case 'processLogin':
				$username = $_POST['un'];
				$password = $_POST['pw'];
				$this->processLogin($username, $password);
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
		$user['username'] = $_SESSION['user'];

		//  $sql = "SELECT img FROM issue INNER JOIN user on added_by = user.id WHERE user.id = 1 AND issue.id = 2 ORDER BY date_added; ";
		//  $imgs = explode(", ", mysql_fetch_assoc(mysql_query($sql)));

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/myaccount.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';

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

	public function logout() {
		unset($_SESSION['user']);
		unset($_SESSION['user_id']);
		header('Location: '.BASE_URL.'/login/');
	}
}
