<div class="card">
    <div class="card-header"><a href='{$url}character_tools/admin/camamands' data-bs-toggle="tooltip" data-placement="top" title="Return">Services</a> &rarr; Edit Services</div>
    <div class="card-body">
        <form onSubmit="Admin.save(this,{$config.id}); return false">
            <div class="form-group row">
                <div class="col-sm-6 mb-3">
                    <label class="col-form-label" for="title"> Name</label>
                    <input class="form-control nui-focus border-muted-300 text-muted-600 placeholder:text-muted-300 dark:border-muted-700 dark:bg-muted-900/75 dark:text-muted-200 dark:placeholder:text-muted-500 dark:focus:border-muted-700 peer w-full border bg-white font-monospace transition-all duration-300 disabled:cursor-not-allowed disabled:opacity-75 px-2 h-10 py-2 text-sm leading-5 px-3 rounded" type="text" name="name" id="name" disabled="disabled" value="{lang({$config.name}, "character_tools")}">
                </div>

                <div class="col-sm-6 mb-3">
                    <label class="col-form-label" for="title">Status</label>
                    <select class="form-control" name="active" id="active">
                        <option value="1" {if $config.active==1}selected{/if}>Yes</option>
                        <option value="0" {if $config.active==0 }selected{/if}>No</option>
                    </select>
                </div>

                <div class="col-sm-6 mb-3">
                    <label class="col-form-label" for="title">Option</label>
                    <select class="form-control" name="type" id="type">
                        <option value="dp">{lang("dp", "character_tools")}</option>

                    </select>
                </div>
                <div class="col-sm-6 mb-3">
                    <label class="col-form-label" id="value" for="title">Amount</label>
                    <input class="form-control nui-focus border-muted-300 text-muted-600 placeholder:text-muted-300 dark:border-muted-700 dark:bg-muted-900/75 dark:text-muted-200 dark:placeholder:text-muted-500 dark:focus:border-muted-700 peer w-full border bg-white font-monospace transition-all duration-300 disabled:cursor-not-allowed disabled:opacity-75 px-2 h-10 py-2 text-sm leading-5 px-3 rounded" type="text" name="amount" id="amount" value="{$config.amount}">
                </div>

            </div>
            <button type="submit" class="relative font-sans font-normal text-sm inline-flex items-center justify-center leading-5 no-underline h-8 px-3 py-2 space-x-1 border nui-focus transition-all duration-300 disabled:opacity-60 disabled:cursor-not-allowed hover:enabled:shadow-none text-muted-700 border-muted-300 dark:text-white dark:bg-muted-700 dark:border-muted-600 dark:hover:enabled:bg-muted-600 hover:enabled:bg-muted-50 dark:active:enabled:bg-muted-700/70 active:enabled:bg-muted-100 rounded-md">Edit</button>
        </form>
    </div>
</div>

</script>