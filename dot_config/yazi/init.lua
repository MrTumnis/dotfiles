require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.PLAIN,
}
require("zoxide"):setup {
	update_db = true,
}
-- require("git"):setup()
require("no-status"):setup()
require("duckdb"):setup({
  mode = "standard",            -- Default: "summarized"
  cache_size = 1000,                          -- Default: 500
  row_id = "dynamic",             -- Default: false
  minmax_column_width = int,                  -- Default: 21
  column_fit_factor = float,
})

require("augment-command"):setup {
	prompt = false,
	default_item_group_for_prompt = "hovered",
	smart_enter = true,
	smart_paste = true,
	smart_tab_create = true,
	smart_tab_switch = false,
	confirm_on_quit = false,
	open_file_after_creation = false,
	enter_directory_after_creation = false,
	use_default_create_behaviour = false,
	enter_archives = true,
	extract_retries = 3,
	recursively_extract_archives = true,
	preserve_file_permissions = false,
	must_have_hovered_item = true,
	skip_single_subdirectory_on_enter = true,
	skip_single_subdirectory_on_leave = true,
	smooth_scrolling = false,
	scroll_delay = 0.02,
	wraparound_file_navigation = false,
}


function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
