-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = Snacks.keymap.set

-- Noice Agent Terminal
-- Opens terminal on the right side with 30% relative width
map({ "n", "t" }, "<leader>dn", function()
	require("noice").cmd("history")
end, { desc = "Noice" })

-- Sidekick Agent Terminal
-- Opens terminal on the right side with 30% relative width
map({ "n" }, "<Tab>", function()
	if not require("sidekick").nes_jump_or_apply() then
		return "<Tab>"
	end
end, { desc = "Goto/Apply Next Edit Suggestion" })

map({ "x" }, "<Tab>", function()
	require("sidekick.cli").send({ msg = "{selection}" })
end, { desc = "Send Visual Selection" })
