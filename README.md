# telescope-projects.nvim

A custom telescope.nvim plugin to hop between your projects.

## Installation

***NOTE***: This plugin is an extension to `telescope.nvim` so it does in fact require
you to have it installed.

Using your Neovim plugin manager of choice, add this repo to your plugin list.

Example using `packer`:

```lua
require('packer').startup(function(use)
    use { 'nvim-telescope/telescope.nvim' }
    use { 'alex-laycalvert/telescope-projects.nvim' }
end)
```

## Setup

In your `init.lua` or wherever your `telescope` config is, you can load the extension
like this.

```lua
local telescope = require('telescope')

telescope.setup({
    -- ... your normal telescope config
    extensions = {
        -- ... other extension config
        projects = {
            projects_dir = '<YOUR PROJECTS DIR>'
        }
    }
})

telescope.load_extension('projects')
```

`projects_dir` is the location where all of your projects are stored. A projects is a
a directory within the `projects_dir`. Using `~/` is allowed.

`TODO`: Allow users to add multiple directories.

## Usage

This is a subcommand of `Telescope` so to call it, just execute `:Telescope projects`.
