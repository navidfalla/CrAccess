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

    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'address ' => '',
            'description' => null,
            'summary' => '',
            'date_added' => null,
            'img' => null,
            'added_by' => 0,
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->address = $args['address'];
        $this->description = $args['description'];
        $this->summary = $args['summary'];
        $this->date_added = $args['date_added'];
        $this->img = $args['img'];
        $this->added_by = $args['added_by'];
    }

    public function save() {
        $db = Db::instance();
        $db_properties = array(
            'address' => $this->address,
            'description' => $this->description,
            'summary' => $this->summary,
            'img' => $this->img,
            'added_by' => $this->added_by
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function getAllIssues($limit=null) {
        $query = sprintf(" SELECT id FROM %s ORDER BY date_added DESC ",
            self::DB_TABLE
            );
        $db = Db::instance();
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

}
