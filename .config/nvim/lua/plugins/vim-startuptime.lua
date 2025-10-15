return {
    {
        "dstein64/vim-startuptime",
        -- lazy-load on command
        cmd = "StartupTime",
        -- init called during startup
        init = function()
            vim.g.startuptime_tries = 10
        end,
        version="^4.^5.0",
    },
}
