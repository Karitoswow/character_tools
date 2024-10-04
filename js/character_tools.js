var CharacterTools = {

    User: {

        dp: null,

        initialize: function(dp)
        {
            this.dp = dp;
        }
    },

    Character: {

        name: null,
        guid: null,
        realm: null,

        initialize: function(name, guid, realm)
        {
            this.name = name;
            this.guid = guid;
            this.realm = realm;
        }
    },

    selectCharacter: function(button, realm, guid, name)
    {
        var CharSection = $("#select_character");

        CharacterTools.Character.initialize(name, guid, realm);

        $(".item_group", CharSection).each(function()
        {
            $(this).removeClass("item_group").addClass("select_character");
            $(this).find(".nice_active").removeClass("nice_active").html(lang("select", "character_tools"));
        });

        $(button).parents(".select_character").removeClass("select_character").addClass("item_group");
        $(button).addClass("nice_active").html(lang("selected", "character_tools"));
    },

    IsLoading: false,

    GetToolName: function(ToolId)
    {
        switch (ToolId)
        {
            case 1:	return "Name Change";
            case 2: return "Race Change";
            case 3: return "Faction Change";
            case 4: return "Appearance Change";
        }

    },

    Purchase: function(button, ToolId)
    {
        var x = document.getElementById("show");

        //Check if we're already executing a command
        if (CharacterTools.IsLoading)
            return;

        //Check if we have selected character
        if (CharacterTools.Character.guid == null)
        {
            Swal.fire({
                icon: 'error',
                title: 'Character Tools',
                text: 'Please select a character first ',
            })
            return;
        }

        var CanAfford = true;

        if (CanAfford)
        {
            $.ajax({
                beforeSend: function(xhr)
                {
                    CharacterTools.IsLoading = true;
                    $(button).html('Processing...');
                    x.style.display = "none";
                    $('#loading').html('<center style="margin: 10px;color:red;font-size: 14px;font-weight:bold">Processing ... <br/><img src="' + Config.URL + 'application/modules/character_tools/images/ajax.gif" /></center>');

                }
            });
            $.post(Config.URL + "character_tools/submit",
                {
                    id: ToolId,
                    guid: CharacterTools.Character.guid,
                    realm: CharacterTools.Character.realm,
                    csrf_token_name: Config.CSRF
                },
                function(data)
                {
                    x.style.display = '';
                    $('#loading').html('');

                    if (data == 1)
                    {
                        $(button).html("Purchase");
                        Swal.fire({
                            icon:  'success',
                            title: 'Character Tools',
                            text:  CharacterTools.GetToolName(ToolId) + ' was successfully purchased for ' + CharacterTools.Character.name,
                            willClose: () => {
                                    window.location.reload();
                            }
                        });
                    }
                    else
                    {
                        CharacterTools.IsLoading = false;
                        $(button).html("Purchase");
                        Swal.fire({
                            icon: 'error',
                            title: 'Character Tools',
                            text: data,
                        })
                    }

                });
        }
    },
}