local tagStatus, autotag = pcall(require, 'nvim-ts-autotag')
if (not tagStatus) then return end

autotag.setup {}

local pairsStatus, autopairs = pcall(require, 'nvim-autopairs')
if (not pairsStatus) then return end

local rulesStatus, Rule = pcall(require, 'nvim-autopairs.rule')
if (not rulesStatus) then return end

local condStatus, cond = pcall(require, 'nvim-autopairs.conds')
if (not condStatus) then return end

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

autopairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    typescript = { "string", "template_string" },
    typescriptreact = { "string", "template_string" }
  },
  disable_filetype = { 'TelescopePrompt' }
}
-- <i dont know how this works>
autopairs.add_rules {
  Rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
          brackets[1][1] .. brackets[1][2],
          brackets[2][1] .. brackets[2][2],
          brackets[3][1] .. brackets[3][2]
        }, pair)
      end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local context = opts.line:sub(col - 1, col + 2)
        return vim.tbl_contains({
          brackets[1][1] .. '  ' .. brackets[1][2],
          brackets[2][1] .. '  ' .. brackets[2][2],
          brackets[3][1] .. '  ' .. brackets[3][2]
        }, context)
      end)
}
for _, bracket in pairs(brackets) do
  Rule('', ' ' .. bracket[2])
      :with_pair(cond.none())
      :with_move(function(opts) return opts.char == bracket[2] end)
      :with_cr(cond.none())
      :with_del(cond.none())
      :use_key(bracket[2])
end
-- </i dont know how this works>
