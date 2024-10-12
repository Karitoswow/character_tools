<div class="card" id="main_item">
    <div class="card-header">

        <div class="tab-content border-muted-200 dark:border-muted-700 dark:bg-muted-800 relative w-full border bg-white transition-all duration-300 rounded-xl p-6">
            <div class="tab-pane active" id="items">
                <div class="btn-toolbar justify-content-between">
                    <div class="input-group group/nui-input relative">

                        <div class="text-muted-400 group-focus-within/nui-input:text-primary-500 absolute start-0 top-0 flex items-center justify-center transition-colors duration-300 peer-disabled:cursor-not-allowed peer-disabled:opacity-75 h-10 w-10">

                        </div>
                    </div>
                </div>
                {if $configs}
                <table class="table table-responsive-md table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Option</th>
                        <th style="text-align:center;">Actions</th>
                    </tr>
                    </thead>
                    <tbody id="ItemTableResult">
                    {foreach from=$configs item=config}
                    <tr>
                        <td>  {$config.id}</td>
                        <td>  {lang({$config.name}, "character_tools")}  </td>
                        <td>

                            {if $config.amount == '0'}
                                <img src="{$url}application/images/icons/coins_delete.png" width="18px" height="18px" align="absmiddle">
                                <span class="amount">  {lang("free", "character_tools")} </span>
                            {elseif $config.amount != '0' && $config.type =='dp' }
                                <img src="{$url}application/images/icons/coins_add.png" width="18px" height="18px" align="absmiddle">
                                <span class="amount">  {lang({$config.type}, "character_tools")} </span>
                                <span style="color: chocolate">  {$config.amount} </span>
                            {/if}
                        </td>

                        <td style="text-align:center;">
                            {if $config.active == 1}<span style="color: green">(Active)</span>{else}<span style="color: red">(Disabled)</span>{/if}
                            <a class="relative font-sans font-normal text-sm inline-flex items-center justify-center leading-5 no-underline h-8 px-3 py-2 space-x-1 border nui-focus transition-all duration-300 disabled:opacity-60 disabled:cursor-not-allowed hover:enabled:shadow-none text-muted-700 border-muted-300 dark:text-white dark:bg-muted-700 dark:border-muted-600 dark:hover:enabled:bg-muted-600 hover:enabled:bg-muted-50 dark:active:enabled:bg-muted-700/70 active:enabled:bg-muted-100 rounded-md" href="javascript:void(0)" onClick="Items.remove({$config.id}, this)">
                                Change Access
                            </a>
                            <a class="relative font-sans font-normal text-sm inline-flex items-center justify-center leading-5 no-underline h-8 px-3 py-2 space-x-1 border nui-focus transition-all duration-300 disabled:opacity-60 disabled:cursor-not-allowed hover:enabled:shadow-none text-muted-700 border-muted-300 dark:text-white dark:bg-muted-700 dark:border-muted-600 dark:hover:enabled:bg-muted-600 hover:enabled:bg-muted-50 dark:active:enabled:bg-muted-700/70 active:enabled:bg-muted-100 rounded-md" href='{$url}character_tools/admin/edit/{$config.id}'  >
                                Edit
                            </a>

                        </td>
                    </tr>
                    {/foreach}
                    </tbody>
                </table>
                {/if}
            </div>
        </div>
    </div>
</div>
