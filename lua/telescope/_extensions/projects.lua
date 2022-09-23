-- TODO
local has_telescope, telescope = pcall(require, 'telescope')

if not has_telescope then
  error("This plugin requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)")
end

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local themes = require('telescope.themes')
local scan = require('plenary.scandir')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local home = os.getenv('HOME')

local M = {}

local projects_dir = ''

M.projects = function ()
    local opts = themes.get_dropdown({})
    projects_dir = string.gsub(projects_dir, '~', home)
    local file_list = scan.scan_dir(projects_dir, { hidden = true, depth = 2 })
    local results = {}
    local added_files = {}
    local i = 1
    for _, v in pairs(file_list) do
        local project_name = string.gsub(v, projects_dir .. '/', '')
        project_name = string.match(project_name, '^.+/')
        if added_files[project_name] == nil then
            added_files[project_name] = project_name
            results[i] = project_name
            i = i + 1
        end
    end
    pickers.new(opts, {
        prompt_title = 'projects',
        finder = finders.new_table({
            results = results,
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function ()
            actions.select_default:replace(function (prompt_bufnr, map)
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd('cd ' .. projects_dir .. '/' .. selection.value)
            end)
            return true
        end
    }):find()
end

return require('telescope').register_extension {
  setup = function(ext_config, config)
      projects_dir = ext_config.projects_dir or home .. '/projects'
  end,
  exports = {
    projects = M.projects
  },
}
