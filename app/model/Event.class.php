<?php

class Event extends DbObject {
    // name of database table
    const DB_TABLE = 'event';

    // database fields
    protected $id;
    protected $event_type_id;
    protected $user_1_id;
    protected $user_2_id;
    protected $issue_id;
    protected $date_created;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'event_type_id' => 0,
            'user_1_id' => null,
            'user_2_id' => null,
            'issue_id' => null,
            'date_created' => null
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->event_type_id = $args['event_type_id'];
        $this->user_1_id = $args['user_1_id'];
        $this->user_2_id = $args['user_2_id'];
        $this->issue_id = $args['issue_id'];
        $this->date_created = $args['date_created'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'event_type_id' => $this->event_type_id,
            'user_1_id' => $this->user_1_id,
            'user_2_id' => $this->user_2_id,
            'issue_id' => $this->issue_id,
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    public function deleteByIssueId($issue_id) {
      $db = Db::instance();
      $query = sprintf("DELETE FROM %s WHERE issue_id=%s;",
        self::DB_TABLE,
        $issue_id
        );
        $result = $db->lookup($query);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }


    public static function getAllEvents($limit=null) {
      $db = Db::instance();

      $query = sprintf("SELECT * FROM %s ORDER BY date_created DESC ",
        self::DB_TABLE
        );
      if($limit != null) {
        $query .= " LIMIT ".$limit;
      }

      $result = $db->lookup($query);
      if(!mysql_num_rows($result))
          return null;
      else {
          $objects = array();
          while($row = mysql_fetch_assoc($result)) {
              $objects[] = self::loadById($row['id']);
          }
          return ($objects);
      }
    }

    public static function getEventsByUserId($userID = null, $limit=null) {
      if($userID == null)
        return null;

      $db = Db::instance();

      $query = "SELECT * FROM ".self::DB_TABLE." WHERE (user_1_id = ".$userID." OR user_2_id = ".$userID.") ";

      $followees = Follow::getFolloweesByUserId($userID);
      foreach($followees as $followee) {
        $query .= " OR (user_1_id = ".$followee->get('id').' OR user_2_id = '.$followee->get('id').') ';
      }

      $query .= " ORDER BY date_created DESC ";

      // $query = sprintf("SELECT * FROM `%s`
      //   WHERE user_1_id = %d OR user_2_id = %d
      //   ORDER BY date_created DESC ",
      //   self::DB_TABLE,
      //   $userID,
      //   $userID
      //   );
      if($limit != null) {
        $query .= " LIMIT ".$limit;
      }

      //echo $query;
      $result = $db->lookup($query);

      $objects = array();
      while($row = mysql_fetch_assoc($result)) {
          $objects[] = self::loadById($row['id']);
      }
      return ($objects);

    }

}
