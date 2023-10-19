return {
    "jackMort/ChatGPT.nvim",
    opts = {
        api_key_cmd = "op read op://private/OpenAI/credential --no-newline"
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    },
    cmd = {
        "ChatGPT",
        "ChatGPTActAs",
        "ChatGPTCompleteCode",
        "ChatGPTRun",
        "ChatGPTEditWithInstructions",
    },
    keys = {
        { '<c-g>', '<cmd>ChatGPTCompleteCode<cr>' }
    }
}
