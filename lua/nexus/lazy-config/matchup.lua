local html_conf = {
  tagnameonly = 1,
  nolists = 1,
};
vim.g.matchup_matchpref = {
  html = html_conf,
  xml = html_conf,
};
vim.g.matchup_matchparen_deferred = 1;
vim.g.matchup_matchparen_offscreen = {};
vim.g.matchup_matchparen_nomode = "i";
vim.g.matchup_matchparen_pumvisible = 0;
