<?php

class User extends DbObject {
    const DB_TABLE = 'user';

    protected $id;
    protected $username;
    protected $password;
    protected $first_name;
    protected $last_name;
    protected $email;
    protected $privilege;

    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'username' => '',
            'password' => '',
            'email' => null,
            'first_name' => null,
            'last_name' => null,
            'privilege' => 1
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->username = $args['username'];
        $this->password = $args['password'];
        $this->email = $args['email'];
        $this->first_name = $args['first_name'];
        $this->last_name = $args['last_name'];
        $this->privilege = $args['privilege'];
    }

    public function save() {
        $db = Db::instance();
        $db_properties = array(
            'username' => $this->username,
            'password' => $this->password,
            'email' => $this->email,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'privilege' => $this->privilege
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }


    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function getAllUsersExceptThis($userId, $limit=null) {
        $query = sprintf(" SELECT * FROM %s WHERE id!=$userId ORDER BY privilege DESC ",
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


    // given a user ID, return that user's username
    public static function getUsernameById($userID=null) {
      if($userID == null)
        return null;

      $query = sprintf("SELECT username FROM `%s` WHERE id = %d ",
          self::DB_TABLE,
          $userID
        );
      $db = Db::instance();
      $result = $db->lookup($query);
      if(!mysql_num_rows($result))
          return null;
      else {
          $row = mysql_fetch_assoc($result);
          $username = $row['username'];
          return ($username);
      }
  }

    public static function update($info = null){
        $query = sprintf("UPDATE user SET username = '%s', first_name = '%s', last_name = '%s', email = '%s', password = '%s' WHERE id = %d ",
            $info['username'],
            $info['firstname'],
            $info['lastname'],
            $info['email'],
            $info['password'],
            $info['user_id']
            );
        $db = Db::instance();
        $db->execute($query);

    }

}
