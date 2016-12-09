<?php

class Seed extends DbObject {
    const DB_TABLE = 'location_seed';

    protected $id;
    protected $name;
    protected $lat;
    protected $lng;


    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'name' => '',
            'lat' => 0,
            'lng' => 0,
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->name = $args['name'];
        $this->lat = $args['lat'];
        $this->lng = $args['lng'];
    }

    public function save() {
        $db = Db::instance();
        $db_properties = array(
            'id' => $this->id,
            'name' => $this->name,
            'lat' => $this->lat,
            'lng' => $this->lng,
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }


    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function loadAllSeeds($limit=null) {
        $query = sprintf(" SELECT id FROM %s",
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
