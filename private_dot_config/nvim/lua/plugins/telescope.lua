return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>sf', function()
            builtin.find_files({
                hidden = true,
                file_ignore_patterns = {
                    '%.git/',
                    'node_modules/',
                    '__pycache__/',
                    '%.venv/',
                    'obj/',
                    'target/',
                    '%.gradle/',
                    '%.DS_Store',
                },
            })
        end, { desc = 'Telescope find files' })

        vim.keymap.set('n', '<leader>gs', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
}
