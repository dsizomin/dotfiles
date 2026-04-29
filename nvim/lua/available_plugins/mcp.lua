return {
  -- {
  --   "ravitemer/mcphub.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  --   config = function()
  --     require("mcphub").setup()
  --   end,
  -- },
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        tools = {
          aifx = {
            cmd = { "aifx", "agent", "run", "claude" },
          },
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Toggle Claude",
      },
    },
  },
  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     provider = "claude-code",
  --     providers = {
  --       copilot = {
  --         endpoint = "https://api.githubcopilot.com",
  --         model = "claude-opus-4.6",
  --       },
  --     },
  --     acp_providers = {
  --       ["claude-code"] = {
  --         command = "aifx",
  --         args = { "agent", "run", "claude", "-p" },
  --         env = {
  --           HOME = "/home/user",
  --         },
  --       },
  --     },
  --     -- system_prompt as function ensures LLM always has latest MCP server state
  --     -- This is evaluated for every message, even in existing chats
  --     system_prompt = function()
  --       local hub = require("mcphub").get_hub_instance()
  --       return hub and hub:get_active_servers_prompt() or ""
  --     end,
  --     -- Using function prevents requiring mcphub before it's loaded
  --     custom_tools = function()
  --       return {
  --         require("mcphub.extensions.avante").mcp_tool(),
  --       }
  --     end,
  --     selector = {
  --       provider = "snacks", -- Avoid native provider issues
  --       provider_opts = {},
  --     },
  --     input = {
  --       provider = "snacks", -- Avoid native provider issues
  --     },
  --     rules = {
  --       -- project_dir = ".avante/rules", -- relative to project root, can also be an absolute path
  --       -- global_dir = "~/.config/avante/rules", -- absolute path
  --       global_dir = vim.g.is_web_code and "~/web-code/.cursor/rules",
  --     },
  --     windows = {
  --       input = {
  --         height = 24,
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     -- "stevearc/dressing.nvim", -- for input provider dressing
  --     "saghen/blink.cmp",
  --     "folke/snacks.nvim", -- for input provider snacks
  --     -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "nvim-mini/mini.nvim",
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     -- {
  --     --   -- support for image pasting
  --     --   "HakonHarnes/img-clip.nvim",
  --     --   event = "VeryLazy",
  --     --   opts = {
  --     --     -- recommended settings
  --     --     default = {
  --     --       embed_image_as_base64 = false,
  --     --       prompt_for_file_name = false,
  --     --       drag_and_drop = {
  --     --         insert_mode = true,
  --     --       },
  --     --       -- required for Windows users
  --     --       use_absolute_path = true,
  --     --     },
  --     --   },
  --     -- },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
