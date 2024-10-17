local wk = require("which-key");

wk.setup({
  keys = {
    scroll_up = "<c-p>",
    scroll_down = "<c-n>",
  },
});

wk.add({
  {
    "<leader>wk",
    function()
      local input = vim.fn.input("WhichKey: ");
      local leader = vim.g.mapleader;
      if #input == 0 then
        return;
      end
      input = input:gsub(leader, "<leader>");

      local lbuf = vim.bo[vim.api.nvim_get_current_buf()];
      local lmod = lbuf.modifiable;
      local cmod = function(b)
        lbuf.modifiable = b;
      end
      vim.cmd.WhichKey(input);
      cmod(lmod);
    end,
    desc = "WhichKey"
  },
}, { prefix = "<leader>" });
