DECLARE LIBRARY ""
    SUB keydown_ascii (BYVAL keycode~&)
    SUB keyup_ascii (BYVAL keycode~&)
    SUB keydown_unicode (BYVAL keycode~&)
    SUB keyup_unicode (BYVAL keycode~&)
    SUB keydown_vk (BYVAL keycode~&)
    SUB keyup_vk (BYVAL keycode~&)
    'these map directly to keydown/keyup except for unicode which remaps extended CP437 & double-width
    SUB keydown (BYVAL keycode~&)
    SUB keyup (BYVAL keycode~&)
END DECLARE