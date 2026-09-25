return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
      },
      picker = {
        sources = {
          projects = {
            dev = { "~/repository", "~/Downloads/9. work_trash/91. si/afs-backend" },
            max_depth = 2,
          },
        },
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "Project Explorer",
      },
    },
  },
}
