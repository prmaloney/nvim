return {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    config = function()
        require('peek').setup({
            app = 'browser',
        });
    end
}
