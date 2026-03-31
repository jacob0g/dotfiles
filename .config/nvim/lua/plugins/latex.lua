return {
    {
        "lervag/vimtex",
        lazy = true,
        ft = "tex",

        init = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_quickfix_mode = 0
            vim.opt.conceallevel = 1
            vim.g.tex_conceal = "abdmg"
            vim.g.vimtex_view_forward_search_on_start = 0
            vim.g.vimtex_compiler_latexmk = {
                out_dir = "build",
                aux_dir = "build"
            }
        end
    },
    {
        "xuhdev/vim-latex-live-preview",
        lazy = true,
        ft = "tex",
        
        init = function()
            vim.g.livepreview_use_biber = 1
            vim.g.livepreview_previewer = "skim"
        end
    },
    {
        "sirver/ultisnips",

        init = function()
            vim.g.UltiSnipsExpandTrigger = "<tab>"
            vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
            vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
            
            vim.g.UltiSnipsSnippetDirectories = {vim.fn.stdpath("config") .. "/UltiSnips"}
        end
    }
}
