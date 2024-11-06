let org = require("orgmode");

-- Setup orgmode
org.setup({
  org_agenda_files = "~/orgfiles/**/*",
  org_default_notes_file = "~/orgfiles/refile.org",
});
