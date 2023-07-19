local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local sorters      = require("telescope.sorters")
local conf         = require("telescope.config").values
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")


local function list_note_tags()
    local results = io.popen('grep -r "T: " ~/code/notes')

    local tags = {}

    for result in results:lines() do
        local file = string.match(result, "(.*).md") .. ".md"
        local tag_line = string.match(result, "T:(.*)")
        tag_line = tag_line:gsub("T: ", "")

        for i in string.gmatch(tag_line, "%S+") do
            local dict = {}
            dict["file"] = file
            dict["tag"] = i

            tags[#tags + 1] = dict
        end
    end
    return tags
end


local function action_override(prompt_bufnr, _)
    actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local str = "edit " .. selection.value

        vim.api.nvim_command(str)
    end)

    return true
end

local function telescope_tags()
    local note_tags = list_note_tags()
    local new_finder = finders.new_table {
        results = note_tags,
        entry_maker = function(entry)
            return {
                value = entry["file"],
                display = entry["tag"],
                ordinal = entry["tag"]
            }
        end
    }

    local picker = pickers.new({}, {
        prompt_title = "Note tags",
        finder = new_finder,
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = action_override,
        previewer = conf.file_previewer({}),
    })

    picker:find()
end

local function new_quick_note()
    local file_name = "~/code/notes/" .. os.date("%Y%m%d%H%M") .. "-quick-note.md"

    local str = "edit " .. file_name

    vim.api.nvim_command(str)
end

vim.keymap.set("n", "<leader>nt", telescope_tags)
vim.keymap.set("n", "<leader>nn", new_quick_note)
