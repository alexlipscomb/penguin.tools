FUNCTION_NAMES = {
	HIGHLIGHT_CURRENT_NOTE = "Select Current Note",
}

function SelectCurrentNote()
	local song = renoise.song()

	if not song then
		return
	end

	local current_track = song.selected_track
	local current_track_index = song.selected_track_index
	local current_line_index = song.selected_line_index

	-- No note columns to select
	if not (current_track.visible_note_columns > 0) then
		return
	end

	local column_index = song.selected_note_column_index

	-- Cursor is not in a note column
	if not column_index then
		return
	end

	song.selection_in_pattern = {
		start_column = column_index,
		start_line = current_line_index,
		start_track = current_track_index,
		end_column = column_index,
		end_line = current_line_index,
		end_track = current_track_index,
	}
end

renoise.tool():add_keybinding({
	name = "Global:Pattern Editor:" .. FUNCTION_NAMES.HIGHLIGHT_CURRENT_NOTE,
	invoke = function(repeated)
		if not repeated then
			SelectCurrentNote()
		end
	end,
})
