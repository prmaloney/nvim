local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local snip = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

local arrow = snip('arrow', fmt("({}) => {{\n\t{}\n}};", { i(1), i(2) }))
local it = snip('it', fmt("it('{}', () => {{\n\t{}\n}});", { i(1), i(2) }))

local clog = snip('clog', fmt("console.log({})", { i(1) }))

ls.add_snippets('typescript', {
  arrow,
  it,
  clog,
})

ls.add_snippets('typescriptreact', {
  arrow,
  it,
  clog,
})
