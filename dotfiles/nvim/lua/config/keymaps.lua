local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bx", ":bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- lazygit
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })

-- obsidian
map("n", "<leader>nn", "<cmd>ObsidianNew<cr>", { noremap = true, silent = true, desc = "[N]ew" })
map("n", "<leader>nd", "<cmd>ObsidianToday<cr>", { noremap = true, silent = true, desc = "To[D]ay's Daily" })
map("n", "<leader>ny", "<cmd>ObsidianYesterday<cr>", { noremap = true, silent = true, desc = "[Y]esterday's Daily" })
map("n", "<leader>nm", "<cmd>ObsidianTomorrow<cr>", { noremap = true, silent = true, desc = "To[m]orrow's Daily" })
map("n", "<leader>ns", "<cmd>ObsidianSearch<cr>", { noremap = true, silent = true, desc = "[S]earch" })
map("n", "<leader>nr", "<cmd>ObsidianRename<cr>", { noremap = true, silent = true, desc = "[R]ename" })
map("n", "<leader>np", "<cmd>ObsidianPasteImg<cr>", { noremap = true, silent = true, desc = "[P]aste Image" })

map("n", "<leader>nlf", "<cmd>ObsidianFollowLink<cr>", { noremap = true, silent = true, desc = "[F]ollow Link" })
map("n", "<leader>nlb", "<cmd>ObsidianBacklinks<cr>", { noremap = true, silent = true, desc = "[B]acklinks" })
map("n", "<leader>nll", "<cmd>ObsidianLink<cr>", { noremap = true, silent = true, desc = "[L]ink Document" })
map("n", "<leader>nln", "<cmd>ObsidianLinkNew<cr>", { noremap = true, silent = true, desc = "Link [N]ew Document" })
map("n", "<leader>nln", "<cmd>ObsidianLinkNew<cr>", { noremap = true, silent = true, desc = "Link [N]ew Document" })
map("v", "<leader>nft", ":!column -t -s '|' -o '|' <CR>", { noremap = true, silent = true, desc = "Note format table" })

-- tmux
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { noremap = true, silent = true, desc = "tmux window left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { noremap = true, silent = true, desc = "tmux window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { noremap = true, silent = true, desc = "tmux window up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { noremap = true, silent = true, desc = "tmux window right" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- Kulala HTTP Client

vim.api.nvim_set_keymap(
	"n",
	"<leader>hr",
	":lua require('kulala').run()<CR>",
	{ noremap = true, silent = true, desc = "[r]un" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ha",
	":lua require('kulala').run_all()<CR>",
	{ noremap = true, silent = true, desc = "run [a]ll" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hR",
	":lua require('kulala').replay()<CR>",
	{ noremap = true, silent = true, desc = "[R]eplay" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hc",
	":lua require('kulala').copy()<CR>",
	{ noremap = true, silent = true, desc = "[c]opy as cURL" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hc",
	":lua require('kulala').close()<CR>",
	{ noremap = true, silent = true, desc = "e[x]it kulala window and current buffer" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hp",
	":lua require('kulala').jump_prev()<CR>",
	{ noremap = true, silent = true, desc = "[p]revious" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hn",
	":lua require('kulala').jump_next()<CR>",
	{ noremap = true, silent = true, desc = "[n]ext" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>he",
	":lua require('kulala').set_selected_env()<CR>",
	{ noremap = true, silent = true, desc = "[e]nvironment" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ht",
	":lua require('kulala').toggle_view()<CR>",
	{ noremap = true, silent = true, desc = "[t]oggle body/header" }
)

-- Zen Mode
map("n", "<leader>wz", "<cmd>ZenMode<cr>", { noremap = true, silent = true, desc = "zenmode" })
