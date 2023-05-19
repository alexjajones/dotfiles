local ts           = vim.treesitter
local themes       = require("telescope.themes")
local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local sorters      = require("telescope.sorters")
local actions      = require("telescope.actions")
local terminal     = require('toggleterm.terminal').Terminal
local action_state = require("telescope.actions.state")

local function list_make_commands()
    local content = vim.fn.join(vim.fn.readfile("Makefile"), '\n')

    local tree = ts.get_string_parser(content, 'make'):parse()
    local root = tree[1]:root()

    local query = vim.treesitter.parse_query('make', '(targets) @make_cmd')

    local targets = {}

    for _, match in query:iter_matches(root, content, root:start(), root:end_()) do
        table.insert(targets, ts.get_node_text(match[1], content))
    end

    return targets
end

local function action_override(prompt_bufnr, _)
    actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local term = terminal:new({
            cmd = "make " .. selection[1],
            hidden = true,
            close_on_exit = false,
            auto_scroll = true
        })

        term:toggle()
    end)

    return true
end

local function telescope_make()
    local make_commands = list_make_commands()
    local opts = themes.get_dropdown()

    local picker = pickers.new(opts, {
        prompt_title = "make commands",
        finder = finders.new_table({ results = make_commands }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = action_override
    })

    picker:find()
end

vim.keymap.set("n", "<leader>m", telescope_make)
