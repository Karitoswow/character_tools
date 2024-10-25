
<?php
class data_model extends CI_Model
{

    public function save($id, $data)
    {
        $this->db->table('character_tools_free')->where('id', $id)->update($data);
    }

    public function getEdit($id)
    {
        $query = $this->db->query("SELECT * FROM character_tools_free WHERE id = ? LIMIT 1", [$id]);

        if ($query->getNumRows() > 0) {
            $row = $query->getResultArray();

            return $row[0];
        } else {
            return false;
        }
    }


    public function getNameByGuid($guid,$realmId=1)
    {

        $character_database = $this->realms->getRealm($realmId)->getCharacters();
        $character_database->connect();

        $query = $character_database->getConnection()->query("SELECT name FROM characters WHERE guid=?", array($guid));



        if($query->getNumRows() > 0)
        {
            $row = $query->getResultArray();

            return $row[0]['name'];
        }
        else
        {
            return false;
        }
    }

    public function GetRealmName($realmid)
    {
        $query = $this->db->query("SELECT * FROM realms where  id = ?",[$realmid]);

        if($query->getNumRows() > 0)
        {
            $result=$query->getResultArray();
            return $result[0]['realmName'];
        }
        else
        {
            return false;
        }
    }
    public function getCommandServerFee($id)
    {
        $query = $this->db->query("SELECT * FROM character_tools_free where  id = ?",[$id]);
        if($query->getNumRows() > 0)
        {
            $result = $query->getResultArray();
            return $result[0];
        }
        else
            return 0;
    }
    public function getconfig()
    {
        $query = $this->db->query("SELECT * FROM character_tools_free  ORDER BY `id` ASC");
        if($query && $query->getNumRows() > 0)
            return  $query->getResultArray();
        else
            return false;

    }




    public function getOnlineAccount()
    {
        $this->connection = $this->external_account_model->getConnection();
        $query = $this->connection->query("SELECT * FROM account WHERE  id = ? AND online = 1",[$this->user->getId()]);
        if($query->getNumRows())
            return true;
        else
            return false;
    }


    private function GetCommand($ToolId, $CharacterName)
    {
        switch ($ToolId)
        {
            case 1:	return $this->GetNameCommand($CharacterName);
            case 2:	return $this->GetRaceCommand($CharacterName);
            case 3:	return $this->GetFactionCommand($CharacterName);
            case 4: return $this->GetAppearanceCommand($CharacterName);
        }
        return false;
    }
    private function GetNameCommand($CharacterName)
    {
        return ".character rename " . $CharacterName;
    }
    private function GetRaceCommand($CharacterName)
    {
        return ".character changerace " . $CharacterName;
    }
    private function GetFactionCommand($CharacterName)
    {
        return ".character changefaction " . $CharacterName;
    }
    private function GetAppearanceCommand( $CharacterName)
    {
        return ".character customize " . $CharacterName;
    }

    public function done($realmid, $characterName ,$ToolId)
    {

        $realmConnection = $this->realms->getRealm($realmid)->getCharacters();
        $realmConnection->connect();
        $command = $this->GetCommand($ToolId, $characterName);
        $this->realms->getRealm($realmid)->getEmulator()->sendCommand($command);

        return true;

    }
    
    public function GetCountAccount($realmId = 1)
  {
     
    
    $character_database = $this->realms->getRealm($realmId)->getCharacters();
    $character_database->connect();
   
    $query = $character_database->getConnection()->query( "SELECT COUNT(*) AS total FROM  characters WHERE account= ? ", [$this->user->getId()]
    );

    if ($query && $query->getNumRows() > 0)
    {
      $results = $query->getResultArray();
      
      return (int)$results[0]['total'];
    }
    
    return 0;
  }

    public function getAccChar($realmId = 1)
    {

        $sell_MIX = $this->config->item('maxLevel');
        $sell_MIN = $this->config->item('minLevel');

        // دریافت دیتابیس مربوط به realm
        $character_database = $this->realms->getRealm($realmId)->getCharacters();
        $character_database->connect();

        // استفاده از بایند کردن پارامترها برای جلوگیری از SQL Injection
        $query = $character_database->getConnection()->query( "SELECT guid, race, gender, class, level, account, name  FROM characters  WHERE account = ? ",[$this->user->getId()]
        );

        // بررسی تعداد رکوردهای برگشتی
        if ($query->getNumRows() > 0)
            return $query->getResultArray();
        else
            return false ;
    }




}