local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- 字体
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14

-- 默认窗口大小
config.initial_cols = 130
config.initial_rows = 38

-- 主题
config.color_scheme = 'Adventure Time (Gogh)'
-- config.colors = {
--   tab_bar = {
--     -- 整条 Tab Bar 背景
--     background = "#24143d",

--     -- 当前 Tab
--     active_tab = {
--       bg_color = "#7c3aed",
--       fg_color = "#ffffff",
--       intensity = "Bold",
--     },

--     -- 其他 Tab
--     inactive_tab = {
--       bg_color = "#3b1f5c",
--       fg_color = "#c4b5fd",
--     },

--     -- 鼠标移动上去
--     inactive_tab_hover = {
--       bg_color = "#5b21b6",
--       fg_color = "#ffffff",
--     },
--   },
-- }

-- 窗口
config.window_decorations = "RESIZE"

config.window_padding = {
  left = 12,
  right = 12,
  top = 10,
  bottom = 10,
}

-- 半透明 + macOS 毛玻璃
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Tab
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false

-- 不要声音 Bell
config.audible_bell = "Disabled"

-- 热键
config.keys = {
  -- 左右分屏
  {
    key = "d",
    mods = "CMD",
    action = act.SplitHorizontal {
      domain = "CurrentPaneDomain",
    },
  },

  -- 上下分屏
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = act.SplitVertical {
      domain = "CurrentPaneDomain",
    },
  },

  -- 关闭当前 pane
  {
    key = "w",
    mods = "CMD",
    action = act.CloseCurrentPane {
      confirm = true,
    },
  },
}

-- 默认文件夹
-- config.default_cwd = wezterm.home_dir .. "/repository"

local public_ip = "..."
local last_ip_update = 0

wezterm.on("update-status", function(window, pane)
  local now = os.time()

  -- 每 5 分钟更新一次公网 IP
  if now - last_ip_update > 300 then
    local success, stdout = wezterm.run_child_process({
      "curl",
      "-fsS",
      "https://api.ipify.org",
    })

    if success then
      public_ip = stdout:gsub("%s+", "")
    else
      public_ip = "offline"
    end

    last_ip_update = now
  end

  window:set_right_status(
    string.format("  %s  ", public_ip)
  )
end)

return config