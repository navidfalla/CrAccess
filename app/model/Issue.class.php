<?php

class Issue extends DbObject {
    const DB_TABLE = 'issue';

    protected $id;
    protected $address;
    protected $description;
    protected $summary;
    protected $date_added;
    protected $added_by;
    protected $img;
    protected $solved;
    protected $lat;
    protected $lng;
    protected $group_id;

    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'address' => '',
            'description' => null,
            'summary' => '',
            'date_added' => null,
            'img' => null,
            'added_by' => 0,
            'solved' => 0,
            'lat' => 0,
            'lng' => 0,
            'group_id' => 0
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->address = $args['address'];
        $this->description = $args['description'];
        $this->summary = $args['summary'];
        $this->date_added = $args['date_added'];
        $this->img = $args['img'];
        $this->added_by = $args['added_by'];
        $this->solved = $args['solved'];
        $this->lat = $args['lat'];
        $this->lng = $args['lng'];
        $this->group_id = $args['group_id'];
    }

    public function save()
    {
        $db = Db::instance();
        $db_properties = array(
            'address' => $this->address,
            'description' => $this->description,
            'summary' => $this->summary,
            'img' => $this->img,
            'added_by' => $this->added_by,
            'solved' => $this->solved,
            'lat' => $this->lat,
            'lng' => $this->lng,
            'group_id' => $this->group_id
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function loadByTimestamp($timestamp){
      $query = sprintf(" SELECT id FROM %s WHERE date_added=%s",
          self::DB_TABLE,
          $timestamp
          );
      $db = Db::instance();
      $result = $db->lookup($query);
      if(!mysql_num_rows($result))
          return null;
      else {
          $objects = array();
          while($row = mysql_fetch_assoc($result)) {
              $objects[] = $row;
          }
          return ($objects);
      }

    }

    public static function deleteById($issue_id){
      $query = sprintf("DELETE FROM %s WHERE id = %s",
          self::DB_TABLE,
          $issue_id
        );

        $db = Db::instance();
        return($db->lookup($query));
    }

    public static function reportSolved($issue_id){
      $query = sprintf("UPDATE %s SET solved=solved+1 WHERE id=%s;",
      self::DB_TABLE,
      $issue_id
    );
      $db = Db::instance();
      return($db->lookup($query));
    }

    public static function loadLastAdded(){
      $query = sprintf("SELECT * FROM %s ORDER BY `date_added` DESC LIMIT 1",
          self::DB_TABLE
        );
      $db = Db::instance();
      $result = $db->lookup($query);
      if(!mysql_num_rows($result))
          return null;
      else {
        $row = mysql_fetch_assoc($result);
        return ($row['id']);
      }
  }

    public static function getAllIssues($limit=null) {
        $query = sprintf(" SELECT id FROM %s ORDER BY `date_added` DESC",
            self::DB_TABLE
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = $row['id'];
            }
            return ($objects);
        }
    }

}
