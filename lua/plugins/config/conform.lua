return function()
  local conform = require("conform");
  local map = vim.keymap.set;

  map("n", "<leader>lf", function()
    if not conform.format({ async = true }) then
      vim.lsp.buf.format({ async = true });
    end
  end, { noremap = true, desc="Format", });

  local data_path = vim.fn.stdpath("data");
  local meson_path = data_path.."/mason/bin";
  vim.env.PATH = vim.env.PATH..":"..meson_path;

  local clang_format = {
    "clang-format",
    lsp_format = "fallback", stop_after_first = true,
  };

  conform.setup({
    formatters_by_ft = {
      lua = {
        "stylua",
        lsp_format = "fallback", stop_after_first = true,
      },
      python = {
        "black", "isort",
        lsp_format = "fallback", stop_after_first = true,
      },
      rust = {
        "rustfmt",
        lsp_format = "fallback", stop_after_first = true,
      },
      javascript = {
        "prettierd", "prettier",
        lsp_format = "fallback", stop_after_first = true,
      },
      c = clang_format,
      cpp = clang_format,
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  });
end;
