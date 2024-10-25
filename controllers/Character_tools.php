<?php
use MX\MX_Controller;
class character_tools extends MX_Controller
{
    private $characters;
    private $total;

    private $tools = array(
        1 => "name_change",
        2 => "race_change",
        3 => "faction_change",
        4 => "appearance_change",
    );
    public function __construct()
    {
       

        $this->user->userArea();
        $this->load->model("data_model");

       
    }
    
    public function index()
    {
        requirePermission("view");
        clientLang("cant_afford", "character_tools");
        clientLang("select", "character_tools");
        clientLang("selected", "character_tools");
        clientLang("dp", "character_tools");
        clientLang("free", "character_tools");

        $this->template->setTitle("Character Tools");

        $content_data = array(
            "realms" => $this->realms->getRealms(),
            "url" => $this->template->page_url,
            "total" => $this->total,
            "dp" => $this->user->getDp(),
            "configs" => $this->data_model->getconfig(),
            "this"=> $this
        );

        $page_content = $this->template->loadPage("character_tools.tpl", $content_data);

        //Load the page
        $page_data = array(
            "module" => "default",
            "headline" => "Character Tools",
            "content" => $page_content
        );

        $page = $this->template->loadPage("page.tpl", $page_data);

        $this->template->view($page, "modules/character_tools/css/character_tools.css", "modules/character_tools/js/character_tools.js");
    }

    public function submit()
    {
        //Get the post variables
        $ToolId = $this->input->post('id');
        $characterGuid = $this->input->post('guid');
        $realmId = $this->input->post('realm');




        // Make sure the realm actually supports console commands
        if (!$this->realms->getRealm($realmId)->getEmulator()->hasConsole())
        {
            die("The realm does not support that service.");
        }
        if($this->data_model->getOnlineAccount())
        {
            die("account is online");
        }

        if ($ToolId && $characterGuid && $realmId)
        {
            //Validate the tool id
            if (isset($this->tools[$ToolId]))
            {
                $realmConnection = $this->realms->getRealm($realmId)->getCharacters();
                $realmConnection->connect();
                $isOnline = $realmConnection->isOnline($characterGuid);
                if ($isOnline) {
                    die("You cannot use this feature, the character is online");

                }

                $server = $this->data_model->getCommandServerFee($ToolId);

                // Make sure the character exists
                if (!$realmConnection->characterExists($characterGuid))
                {
                    die("The selected character does not exist.");
                }

                // Make sure the character belongs to this account
                if (!$realmConnection->characterBelongsToAccount($characterGuid, $this->user->getId()))
                {
                    die("The selected character does not belong to your account.");
                }

                //Get the character name
                $CharacterName = $realmConnection->getNameByGuid($characterGuid);

                //Make sure we've got the name
                if (!$CharacterName)
                {
                    die("The website was unable to resolve your character's name.");
                }

                if($server['amount']== '0')
                {
                   $this->data_model->done($realmId, $CharacterName ,$ToolId);
                   die("1");
                }

                if($server['type']== 'dp')
                {
                    if ($this->user->getDp() >= $server['amount'])
                    {
                        if ($server['amount'] > 0)
                        {
                                $this->data_model->done($realmId, $CharacterName ,$ToolId);
                                $this->user->setDp($this->user->getDp() - $server['amount']);
                                die("1");

                        }
                    }
                    else
                    {
                        die("You dont have enough Donation Points.");
                    }
                }

            }
            else
            {
                die("The selected service is invalid.");
            }
        }
        else
        {
            die("Something went wrong, please try again.");
        }
    }


}
