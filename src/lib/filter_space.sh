filter_space() {
    command cat "${PM_ROOT_DIR}/spaces" | gum filter --placeholder "Select a space"
}
