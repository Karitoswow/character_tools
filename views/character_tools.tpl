<section id="character_tools">
    <section id="select_character">
         {foreach from=$realms item=realm}
         
                <table class="nice_table mb-3" style="text-align: center">
                    <thead>
                    <tr>
                        <div>
                            <div>
                                    <p class="realm_active">   {$realm->getName()} </p>
                            </div>
                        </div>
                    </tr>
                    </thead>
                     {if $this->data_model->GetCountAccount($realm->getId())}
                        {foreach from=$this->data_model->getAccChar($realm->getId()) item=character}
                        <tr>
                            <td class="col-0">
                                <img src="{$url}application/images/stats/{$character.race}-{$character.gender}.gif">
                            </td>
                            <td class="col-2">
                                <img src="{$url}application/images/stats/{$character.class}.gif" width="20px">
                            </td>
                            <td class="col-3">{$character.name}</td>
                            <td class="col-5">Lv{$character.level}</td>
                            <td>
                                <div class="select_character">
                                    <div class="character store_item">
                                        <section class="character_buttons">
                                            <a href="javascript:void(0)" class="nice_button" onClick="CharacterTools.selectCharacter(this, {$realm->getId()}, {$character.guid}, '{$character.name}')">
                                                Select
                                            </a>
                                        </section>
                                    </div>
                                </div>
                            </td>
                        </tr>
                       {/foreach}
                     {else}
                         <center style="padding-top:10px;"><b>no found character</b></center>
                    {/if}
                </table>
            {/foreach}
    </section>
    <table class="nice_table"  id="show"  style="text-align: center;">
        {foreach from=$configs key=key item=config}
            {if $config.id == 0 }
                <tr>
            {/if}
            {if $config.active}
                <td class="td">
                    <div class="name" id="{$config.name}"> {ucwords(lang({$config.name}, "character_tools"))} </div>
                    <br/>
                       <p>
                            {if $config.amount == '0'}
                                 <img src="{$url}application/images/icons/coins_delete.png" width="18px" height="18px" align="absmiddle">
                                <span class="amount">  {lang("free", "character_tools")} </span>
                            {elseif $config.amount != '0' && $config.type =='dp' }
                                  <img src="{$url}application/images/icons/coins_add.png" width="18px" height="18px" align="absmiddle">
                                <span class="amount">  {lang({$config.type}, "character_tools")} </span>
                                <span style="color: chocolate">  {$config.amount} </span>
                            {/if}
                        <br/>
                        <a href="javascript:void(0)" class="nice_button" onClick="CharacterTools.Purchase(this, {$config.id})">
                            Purchase
                        </a>
                    </p>
                </td>
            {/if}
            {if  $config.id == 0  }  </tr> {/if}
        {/foreach}
    </table>
    <div id="loading"></div>
