-- local tmux_manager = require('tmux-awesome-manager')
-- local tmux_term = require('tmux-awesome-manager.src.term')
-- require("cmake-tools").setup({
--
--   cmake_command = "cmake",                                          -- this is used to specify cmake command path
--   ctest_command = "ctest",                                          -- this is used to specify ctest command path
--   cmake_regenerate_on_save = true,                                  -- auto generate when save CMakeLists.txt
--   cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
--   cmake_build_options = {},                                         -- this will be passed when invoke `CMakeBuild`
--   -- support macro expansion:
--   --       ${kit}
--   --       ${kitGenerator}
--   --       ${variant:xx}
--   cmake_build_directory = "build/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
--   cmake_soft_link_compile_commands = true,              -- this will automatically make a soft link from compile commands file to project root dir
--   cmake_compile_commands_from_lsp = false,              -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
--   cmake_kits_path = nil,                                -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
--   cmake_variants_message = {
--     short = { show = true },                            -- whether to show short message
--     long = { show = true, max_length = 40 },            -- whether to show long message
--   },
--   cmake_dap_configuration = {                           -- debug settings for cmake
--     name = "cpp",
--     type = "codelldb",
--     request = "launch",
--     stopOnEntry = false,
--     runInTerminal = true,
--     console = "integratedTerminal",
--   },
--   cmake_executor = {                    -- executor to use
--     name = "quickfix",                  -- name of the executor
--     opts = {},                          -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
--     default_opts = {                    -- a list of default and possible values for executors
--       quickfix = {
--         show = "always",                -- "always", "only_on_error"
--         position = "belowright",        -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
--         size = 10,
--         encoding = "utf-8",             -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
--         auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
--       },
--       toggleterm = {
--         direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
--         close_on_exit = false, -- whether close the terminal when exit
--         auto_scroll = true,    -- whether auto scroll to the bottom
--       },
--       overseer = {
--         new_task_opts = {
--           strategy = {
--             "toggleterm",
--             direction = "horizontal",
--             autos_croll = true,
--             quit_on_exit = "success"
--           }
--         }, -- options to pass into the `overseer.new_task` command
--         on_new_task = function(task)
--           require("overseer").open(
--             { enter = false, direction = "right" }
--           )
--         end, -- a function that gets overseer.Task when it is created, before calling `task:start`
--       },
--       terminal = {
--         name = "Main Terminal",
--         prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
--         split_direction = "horizontal", -- "horizontal", "vertical"
--         split_size = 11,
--
--         -- Window handling
--         single_terminal_per_instance = true,  -- Single viewport, multiple windows
--         single_terminal_per_tab = true,       -- Single viewport per tab
--         keep_terminal_static_location = true, -- Static location of the viewport if avialable
--
--         -- Running Tasks
--         start_insert = false,       -- If you want to enter terminal with :startinsert upon using :CMakeRun
--         focus = false,              -- Focus on terminal when cmake task is launched.
--         do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
--       },                            -- terminal executor uses the values in cmake_terminal
--     },
--   },
--   cmake_runner = {               -- runner to use
--     name = "terminal",           -- name of the runner
--     opts = {},                   -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
--     default_opts = {             -- a list of default and possible values for runners
--       quickfix = {
--         show = "always",         -- "always", "only_on_error"
--         position = "belowright", -- "bottom", "top"
--         size = 10,
--         encoding = "utf-8",
--         auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
--       },
--       toggleterm = {
--         direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
--         close_on_exit = false, -- whether close the terminal when exit
--         auto_scroll = true,    -- whether auto scroll to the bottom
--       },
--       overseer = {
--         new_task_opts = {
--           strategy = {
--             "toggleterm",
--             direction = "horizontal",
--             autos_croll = true,
--             quit_on_exit = "success"
--           }
--         },   -- options to pass into the `overseer.new_task` command
--         on_new_task = function(task)
--         end, -- a function that gets overseer.Task when it is created, before calling `task:start`
--       },
--       terminal = {
--         name = "Main Terminal",
--         prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
--         split_direction = "horizontal", -- "horizontal", "vertical"
--         split_size = 11,
--
--         -- Window handling
--         single_terminal_per_instance = true,  -- Single viewport, multiple windows
--         single_terminal_per_tab = true,       -- Single viewport per tab
--         keep_terminal_static_location = true, -- Static location of the viewport if avialable
--
--         -- Running Tasks
--         start_insert = false,       -- If you want to enter terminal with :startinsert upon using :CMakeRun
--         focus = false,              -- Focus on terminal when cmake task is launched.
--         do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
--       },
--     },
--   },
--   cmake_notifications = {
--     runner = { enabled = true },
--     executor = { enabled = true },
--     spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
--     refresh_rate_ms = 100, -- how often to iterate icons
--   },
-- }
-- )
require("overseer").setup({
  strategy = "toggleterm",
  templates = { 'builtin', 'user.cpp_build' }
})

local wk = require("which-key")

-- tmux_manager.setup({
--   per_project_commands = {
--     clangd = { { cmd = "clangd", name = "Clangd server" } }
--   },
--   session_name = 'Terminals',
--   use_icon = true,
--
-- })
--
-- local rust_commands = {
--   debug_build = { cmd = 'cargo build', name = "Debug build" },
--   release_build = { cmd = 'cargo build --release', name = "Release build" },
--   install_package = { cmd = 'cargo install %1', name = "Cargo Install", questions = { { question = 'package name:', required = true } }, open_as = 'pane', visit_first_call = true, focus_when_call = false },
-- }
-- local clang_commands = {
--   compile = { cmd = "ninja", name = "Compile", open_as = "window", visit_first_call = true, focus_when_call = true },
--   mk_dir = { cmd = "mkdir -p " .. "build", name = "Create directory", visit_first_call = true, focus_when_call = true },
--   config = { cmd = "cd " .. vim.fn.getcwd() .. " && cd build && ccmake ../", name = "CMAKE", open_as = "pane" },
-- }
-- -- wk.register({
-- --   r = {
-- --     name = "+rails",
-- --     R = tmux_term.run_wk({
-- --       cmd = 'rails s',
-- --       name = 'Rails Server',
-- --       visit_first_call = false,
-- --       open_as =
-- --       'separated_session',
-- --       session_name = 'My Terms'
-- --     }),
-- --     r = tmux_term.run_wk({ cmd = 'rails s', name = 'Rails Console', open_as = 'window' }),
-- --     b = tmux_term.run_wk({ cmd = 'bundle install', name = 'Bundle Install', open_as = 'pane', close_on_timer = 2, visit_first_call = false, focus_when_call = false }),
-- --     g = tmux_term.run_wk({
-- --       cmd = 'rails generate %1',
-- --       name = 'Rails Generate',
-- --       questions = { {
-- --         question = "Rails generate: ",
-- --         required = true,
-- --         open_as = 'pane',
-- --         close_on_timer = 4,
-- --         visit_first_call = false,
-- --         focus_when_call = false
-- --       } }
-- --     }),
-- --     d = tmux_term.run_wk({
-- --       cmd = 'rails destroy %1',
-- --       name = 'Rails Destroy',
-- --       questions = { {
-- --         question = "Rails destroy: ",
-- --         required = true,
-- --         open_as = 'pane',
-- --         close_on_timer = 4,
-- --         visit_first_call = false,
-- --         focus_when_call = false
-- --       } }
-- --     }),
-- --   },
-- -- }, { prefix = "<leader>tm", silent = true })
-- wk.register({
--   c = {
--     name = "+clangd",
--     m = tmux_term.run_wk(clang_commands.compile),
--     d = tmux_term.run_wk(clang_commands.mk_dir),
--     c = tmux_term.run_wk(clang_commands.config),
--   }
-- }, { prefix = "<leader>tm", silent = true })
-- wk.register({
--   r = {
--     name = "+rust",
--     r = tmux_term.run_wk(rust_commands.debug_build),
--     R = tmux_term.run_wk(rust_commands.release_build),
--     i = tmux_term.run_wk(rust_commands.install_package),
--   }
-- }
-- , { prefix = "<leader>tm", silent = true })
