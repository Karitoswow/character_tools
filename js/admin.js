var Admin = {

    identifier: "item",

    Links: {
        save: "character_tools/admin/save/",
    },

    save: function(form, id)
    {
        var values = {csrf_token_name: Config.CSRF};

        $(form).find("input, select, textarea").each(function()
        {
            if($(this).attr("type") == "checkbox")
            {
                values[$(this).attr("name")] = this.checked;
            }
            else if($(this).attr("type") != "submit")
            {
                values[$(this).attr("name")] = $(this).val();
            }
        });

        $.post(Config.URL  + this.Links.save + id, values,

        function(data) {
            data = JSON.parse(data);
            console.log(data);
            Swal.fire({
                text: data.text,
                icon: data.icon,
                willClose: () => {
                    if (data.status)
                        window.location.reload();
                }
            });

        });
    }

}