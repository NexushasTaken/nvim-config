local map = vim.keymap.set
local hop = require("hop");
hop.setup()

local hop_map = function(suffix, command)
  map("n", "<leader>h"..suffix, vim.cmd[command])
end
hop_map("w", "HopWord")
hop_map("p", "HopPattern")
hop_map("l", "HopLine")
hop_map("s", "HopLineStart")
hop_map("v", "HopVertical")
hop_map("a", "HopAnywhere")
hop_map("cj", "HopChar1")
hop_map("ck", "HopChar2")
