local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local compile_path = install_path .. "/plugin/packer_compiled.lua"
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Needed to load first
    use { 'lewis6991/impatient.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }

    -- Themes
    use { 'folke/tokyonight.nvim' }
    use { 'navarasu/onedark.nvim' }

    --
    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', config = "require('plugins.treesitter')" }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }
    use { 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } }
    use { 'm-demare/hlargs.nvim', config = "require('plugins.hlargs')" }

    -- Navigating (Telescope/Tree/Refactor)
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope.nvim',
      config = "require('plugins.telescope')",
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim' }
      }
    }
    use { 'cljoly/telescope-repo.nvim' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
    -- use { 'kyazdani42/nvim-tree.lua', config = "require('plugins.tree')" }

    use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        {
          -- only needed if you want to use the commands with "_with_window_picker" suffix
          's1n7ax/nvim-window-picker',
          tag = "v1.*",
          config = function()
            require 'window-picker'.setup({
              autoselect_one = true,
              include_current = false,
              filter_rules = {
                -- filter using buffer options
                bo = {
                  -- if the file type is one of following, the window will be ignored
                  filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                  -- if the buffer type is one of following, the window will be ignored
                  buftype = { 'terminal', "quickfix" },
                },
              },
              other_win_hl_color = '#e35e4f',
            })
          end,
        },
      },
      config = "require('plugins.neo-tree')"
    }

    -- LSP Base
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'neovim/nvim-lspconfig' }
    use { 'ray-x/lsp_signature.nvim' }

    use({
      'dnlhc/glance.nvim',
      config = function()
        require('glance').setup({})
      end,
    })

    --  Go
    use {
      'ray-x/go.nvim',
      config = function()
        require('go').setup()
      end
    }

    -- LSP Cmp
    use { 'hrsh7th/nvim-cmp', event = 'InsertEnter', config = "require('plugins.cmp')" }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua' }
    use { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-path', after = 'cmp-buffer' }
    use { 'hrsh7th/cmp-cmdline', after = 'cmp-path' }
    use { 'hrsh7th/cmp-calc', after = 'cmp-cmdline' }
    use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp', after = 'cmp-calc' }
    use { 'David-Kunz/cmp-npm', after = 'cmp-tabnine', requires = 'nvim-lua/plenary.nvim',
      config = "require('plugins.cmp-npm')" }
    use { 'saadparwaiz1/cmp_luasnip', after = 'cmp-npm' }
    use { 'lukas-reineke/lsp-format.nvim' }

    -- LSP Addons
    use { 'stevearc/dressing.nvim', requires = 'MunifTanjim/nui.nvim', config = "require('plugins.dressing')" }
    use { 'onsails/lspkind-nvim' }
    use { 'folke/lsp-trouble.nvim', config = "require('plugins.trouble')" }
    use { 'nvim-lua/popup.nvim' }
    use { 'ChristianChiarulli/nvim-gps', branch = 'text_hl', config = "require('plugins.gps')", after = 'nvim-treesitter' }
    use { 'jose-elias-alvarez/typescript.nvim' }
    use { 'axelvc/template-string.nvim', config = function() require('template-string').setup() end }
    use { 'lvimuser/lsp-inlayhints.nvim', config = function() require('lsp-inlayhints').setup() end }

    -- General
    use { 'AndrewRadev/switch.vim' }
    use { 'AndrewRadev/splitjoin.vim' }
    use { 'numToStr/Comment.nvim', config = "require('plugins.comment')" }
    use { 'LudoPinelli/comment-box.nvim' }
    use { 'akinsho/nvim-toggleterm.lua', branch = 'main', config = "require('plugins.toggleterm')" }
    use { 'tpope/vim-repeat' }
    -- use { 'tpope/vim-speeddating' }
    use { 'dhruvasagar/vim-table-mode' }
    use { 'junegunn/vim-easy-align' }
    use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
    use { 'nacro90/numb.nvim', config = "require('plugins.numb')" }
    use { 'folke/todo-comments.nvim', config = "require('plugins.todo-comments')" }
    use { 'folke/zen-mode.nvim', config = "require('plugins.zen')", disable = not EcoVim.plugins.zen.enabled }
    use { 'folke/twilight.nvim', config = function() require("twilight").setup {} end,
      disable = not EcoVim.plugins.zen.enabled }
    -- use { 'ggandor/lightspeed.nvim', config = "require('plugins.lightspeed')" }
    use { 'ggandor/leap.nvim', config = "require('plugins.leap')" }
    use { 'folke/which-key.nvim', config = "require('plugins.which-key')", event = "BufWinEnter" }
    use { 'ecosse3/galaxyline.nvim', after = 'nvim-gps', config = "require('plugins.galaxyline')", event = "BufWinEnter" }
    use { 'romgrk/barbar.nvim', requires = { 'kyazdani42/nvim-web-devicons' },
      config = "require('plugins.barbar')" }
    use { 'antoinemadec/FixCursorHold.nvim' } -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    use { 'rcarriga/nvim-notify' }
    use { 'vuki656/package-info.nvim', event = "BufEnter package.json", config = "require('plugins.package-info')" }
    use { 'iamcco/markdown-preview.nvim', run = "cd app && npm install",
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" } }
    use { 'airblade/vim-rooter', setup = function() vim.g.rooter_patterns = EcoVim.plugins.rooter.patterns end }
    use { 'Shatur/neovim-session-manager', config = "require('plugins.session-manager')" }
    use { 'kylechui/nvim-surround', config = function() require("nvim-surround").setup({}) end }
    use { 'sunjon/shade.nvim', config = function() require("shade").setup(); require("shade").toggle(); end }
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = "require('plugins.nvim-ufo')" }
    use { 'simrat39/symbols-outline.nvim', config = function() require("symbols-outline").setup() end }

    -- Snippets & Language & Syntax
    use { 'windwp/nvim-autopairs', after = { 'nvim-treesitter', 'nvim-cmp' }, config = "require('plugins.autopairs')" }
    use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' } }
    use { 'lukas-reineke/indent-blankline.nvim', config = "require('plugins.indent')" }
    use { 'NvChad/nvim-colorizer.lua', config = "require('plugins.colorizer')" }
    use { 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets' }, after = 'cmp_luasnip' }

    -- Git
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = "require('plugins.git.signs')",
      event = "BufRead"
    }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim', config = "require('plugins.git.diffview')" }
    use { 'akinsho/git-conflict.nvim', config = "require('plugins.git.conflict')" }

    use { 'ThePrimeagen/git-worktree.nvim', config = "require('plugins.git.worktree')" }
    use { 'kdheepak/lazygit.nvim' }

    -- Testing
    use {
      'nvim-neotest/neotest',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'haydenmeade/neotest-jest'
      },
      config = "require('plugins.neotest')"
    }

    -- DAP
    use { 'theHamsta/nvim-dap-virtual-text' }
    use { 'rcarriga/nvim-dap-ui' }
    use { 'mfussenegger/nvim-dap', config = "require('plugins.dap')" }

    -- Play around with
    -- use { 'ldelossa/nvim-ide', config = "require('plugins.nvim-ide')" }

    -- use({
    --   "folke/noice.nvim",
    --   config = function()
    --     require("noice").setup({
    --       lsp = {
    --         signature = {
    --           enabled = false
    --         }
    --       }
    --     })
    --   end,
    --   requires = {
    --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --     "MunifTanjim/nui.nvim",
    --     -- OPTIONAL:
    --     --   `nvim-notify` is only needed, if you want to use the notification view.
    --     --   If not available, we use `mini` as the fallback
    --     "rcarriga/nvim-notify",
    --   }
    -- })

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    compile_path = compile_path,
    disable_commands = true,
    max_jobs = 50,
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end
    }
  }
})
