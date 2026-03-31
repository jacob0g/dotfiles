return {
    "Aietes/esp32.nvim",
    name = "esp32.nvim",
    dependencies = {
        "folke/snacks.nvim",
    },
    opts = {
        build_dir = ".pio/build"
    },
    config = function(_, opts)
        require("esp32").setup(opts)
    end,
}
