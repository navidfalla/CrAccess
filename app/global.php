<?php

set_include_path(dirname(__FILE__)); # include path - don't change

include_once 'config.php';

function __autoload($class_name) {
	require_once 'model/'.$class_name.'.class.php';
}

if (!isset($_SESSION))
	session_start();
