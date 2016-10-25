<?php

class Db {

    private static $_instance = null;
    private $conn;

	private function __construct() {
		$host     = DB_HOST;
		$database = DB_DATABASE;
		$username = DB_USER;
		$password = DB_PASS;

		$conn = mysql_connect($host, $username, $password)
			or die ('Error: Could not connect to MySql database');

		mysql_select_db($database);
	}

	public static function instance() {
		if (self::$_instance === null) {
			self::$_instance = new Db();
		}
		return self::$_instance;
	}

    public function fetchById($id, $class_name, $db_table) {
		if ($id === null) {
			return null;
		}

		$query = sprintf("SELECT * FROM `%s` WHERE id = '%s';",
				$db_table,
				$id
			     );
		$result = $this->lookup($query);

		if(!mysql_num_rows($result)) {
			return null;
		} else {
			$row = mysql_fetch_assoc($result);
			$obj = new $class_name($row);
			return $obj;
		}
	}

	public function store(&$obj, $class_name, $db_table, $data)
	{
		if($obj->getId() === null) {
			$query = $this->buildInsertQuery($db_table, $data);
			$this->execute($query);
			$obj->setId($this->getLastInsertID());
		} else {
			if($obj->getModified()) {
				$query = $this->buildUpdateQuery($db_table, $data, $obj->getId());
				$this->execute($query);
			}
		}
		$obj->setModified(false);
	}
	public function quoteString($s) {
		return "'" . mysql_real_escape_string($s) . "'";
	}

	public function quoteDate($d) {
		return date("'Y-m-d H:i:s'", $d);
	}

	public function lookup($query) {
		$result = mysql_query($query);
		if(!$result)
			die('Invalid query: ' . $query);
		return ($result);
	}

	public function execute($query) {
		$ex = mysql_query($query);
		if(!$ex)
			die ('Query failed:' . mysql_error());
	}

	public function buildInsertQuery($table = '', $data = array()) {
		$fields = '';
		$values = '';

		foreach ($data as $field => $value) {
			if($value !== null) {
				$fields .= "`".$field . "`, ";
				$values .= $this->quoteString($value) . ", ";
			}
		}

		$fields = substr($fields, 0, -2);
		$values = substr($values, 0, -2);

		$query = sprintf("INSERT INTO `%s` (%s) VALUES (%s);",
				$table,
				$fields,
				$values
			     );

		return ($query);
	}

	public function buildUpdateQuery($table = '', $data = array(), $id=0) {
		$all_null = true;
		$query = "UPDATE `" . $table . "` SET `";

		foreach ($data as $field => $value) {
			if($value === null) {
				$query .= $field . "` = NULL, `";
        } else {
				$query .= $field . "` = " . $this->quoteString($value) . ", `";
				$all_null = false;
			}
		}

		$query = substr($query, 0, -3);
		$query .= " WHERE id = '" . $id . "';";

		if($all_null)
			return '';
		else
			return ($query);
	}

	public function getLastInsertID() {
		$query = "SELECT LAST_INSERT_ID() AS id";
		$result = mysql_query($query);
		if(!$result)
			die('Invalid query.');

		$row = mysql_fetch_assoc($result);
		return ($row['id']);
	}

}
