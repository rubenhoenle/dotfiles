vim.g.gitblame_message_template = "/* <summary> • <date> • <author> • <sha> */"
vim.g.gitblame_enabled = 1
vim.g.gitblame_virtual_text_column = 80
vim.g.gitblame_delay = 250

vim.keymap.set("", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Blame line" })
vim.keymap.set("", "<leader>go", "<cmd>GitBlameOpenCommitURL<cr>", { desc = "Open line commit" })
