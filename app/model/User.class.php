<?php

class User extends DbObject {
    const DB_TABLE = 'user';

    protected $id;
    protected $username;
    protected $password;
    protected $first_name;
    protected $last_name;
    protected $email;

    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'username' => '',
            'password' => '',
            'email' => null,
            'first_name' => null,
            'last_name' => null
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->username = $args['username'];
        $this->password = $args['password'];
        $this->email = $args['email'];
        $this->first_name = $args['first_name'];
        $this->last_name = $args['last_name'];
    }

    public function save() {
        $db = Db::instance();
        $db_properties = array(
            'username' => $this->username,
            'password' => $this->password,
            'email' => $this->email,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }


    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function getAllUsers($limit=null) {
        $query = sprintf(" SELECT id, username FROM %s ORDER BY privilege DESC ",
            self::DB_TABLE
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = [$row['id'],$row['username']];
            }
            return ($objects);
        }
    }

    public static function loadByUsername($username=null) {
        if($username === null)
            return null;

        $query = sprintf(" SELECT id FROM %s WHERE username = '%s' ",
            self::DB_TABLE,
            $username
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $row = mysql_fetch_assoc($result);
            $obj = self::loadById($row['id']);
            return ($obj);
        }
    }

}
