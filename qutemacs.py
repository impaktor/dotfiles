# USE:
# Create a ~/.config/qutebrowser/config.py and add line:
# config.source("~/.dotfiles/qutemacs.py")

# SOURCE:
# from https://gist.github.com/jumper047/ee821f789cd336b1105309f3ebf44f70
# and https://github.com/david-alvarez-rosa/dotfiles/tree/main/.config/qutebrowser

# GENERAL
# - history never expires, stored in ~/.local/share/qutebrowser/history.sqlite

# TIP:
# - Reload with :config-source.
# - :bind

# TODO:
# - paths relative HOME?
# - revisit xxx lines
# - in 'M-x' must type before using arrow?
# - commit to git
# - /usr/share/qutebrowser/scripts/hist_importer.py -b firefox -s path/places.sqlite -d ~/.local/share/qutebrowser/history.sqlite

# USAGE:
# - 'yy' yank url to clipboard, 'pp' paste from clipboard & load
# - ';y' hint urls to copy, ';i' hint images
# - 'gC' clone tab
# - 'gu' move up in url address hierarchy
# - 'm' save (named) quick-bookmark, 'M' save bookmark

# Always save tabs on exit (equivalent to ':wq')
c.auto_save.session = True

# Name of the session to save by default (optional)
# consider: session-load <name>
c.session.default_name = "default"

# Load restored tabs only when they get focus (faster startup with many tabs)
c.session.lazy_restore = True

#  Opens new tabs next to current one.
c.tabs.new_position.unrelated = "next"

# Don’t wrap on tabs.
c.tabs.wrap = True

# Configure external editor.
c.editor.command = ["emacsclient", "{}"]
# # alternativ c.editor.command = ["emacsclient", "-c", "{}"]

# Configure title format for tabs.
c.tabs.title.format = "{perc} {index} {current_title}"


# c.url.start_pages = "file:///home/kf.."
# c.url.default_page = "file:///home/kf.."

# NORMAL MODE

# # Keybindings for normal mode. All default keybindings will be disabled, and redefined one by one. This is needed to so we can safely disable insert mode completely.
# c.bindings.default["normal"] = {}
# c.input.match_counts = False


# C-g = vim's ESC
config.bind("<Ctrl-g>", "mode-leave", mode="hint")
config.bind("<Ctrl-g>", "mode-leave", mode="command")
config.bind("<Ctrl-g>", "mode-leave", mode="prompt")
config.bind("<Ctrl-g>", "mode-leave", mode="caret")


# MINIBUFFER

config.unbind("<Ctrl-Y>", mode="command")
config.bind("<Ctrl-y>", "fake-key -g <Ctrl-V>", mode="command")
# config.bind('<Ctrl-y>', 'insert-text -- {clipboard}', mode='command')

config.bind("<Ctrl-n>", "completion-item-focus next", mode="command")
config.bind("<Ctrl-p>", "completion-item-focus prev", mode="command")

config.bind("<Alt-n>", "command-history-next", mode="command")
config.bind("<Alt-p>", "command-history-prev", mode="command")

# Don't know why/what this is
# config.bind("<Ctrl-s>", "search-next", mode="command")
# config.bind("<Ctrl-r>", "search-prev", mode="command")


# SEARCHING

# Initiate search:
config.bind("<Ctrl-s>", "cmd-set-text /")
config.bind("<Ctrl-r>", "cmd-set-text ?")

# Move to next / previous match
config.bind("<Ctrl-s>", "search-next", mode="command")
config.bind("<Ctrl-r>", "search-prev", mode="command")


# HINTING

# COMMAND FOR HINTING (for jump).
# xxx config.bind('<Ctrl-j>', 'hint all')
# xxx config.bind('<Alt-j>', 'hint all tab')

c.hints.mode = "number"  # or 'letter' / 'number'
c.hints.chars = "1234567890"  # pure numeric like classic Conkeror

# When to auto-follow a unique match. Note: I prefer conkeror's way,
# where you press RET to follow, thus I see the URL before following
# it.
c.hints.auto_follow = (
    "unique-match"  # or "always" / "full-match" / "never" / "unique-match"
)

# Which unbound keys to forward to the webview in normal mode.
c.input.forward_unbound_keys = "all"

# Disable vim-style number previx to command
c.input.match_counts = False

# Enter insert mode if an editable element is clicked.
c.input.insert_mode.auto_enter = True

# Leave insert mode if a non-editable element is clicked.
c.input.insert_mode.auto_leave = True

# yank URLs to clipboard
config.bind("c0", "hint links yank")

# Yank and format as org-mode link
config.bind("yo", "yank inline [[{url}][{title}]]")

# Default to darker colors
# config.set("colors.webpage.darkmode.enabled", True)

# alternativ:
# c.colors.webpage.darkmode.enabled = True
# c.colors.webpage.darkmode.policy.images = 'never'
# c.colors.webpage.darkmode.algorithm = "lightness-cialab"

# # EDITING

# For editing, fake keys will be used. This makes everything easier:
# take into account that now insert mode is disabled. This bindings
# need to work also for scrolling as well.

# config.bind("<Ctrl-f>", "fake-key <Right>")
# config.bind("<Ctrl-b>", "fake-key <Left>")
# config.bind("<Ctrl-a>", "fake-key <Home>")
# config.bind("<Ctrl-e>", "fake-key <End>")
# config.bind("<Ctrl-n>", "fake-key <Down>")
# config.bind("<Ctrl-p>", "fake-key <Up>")
# config.bind("<Alt-f>", "fake-key <Ctrl-Right>")
# config.bind("<Alt-b>", "fake-key <Ctrl-Left>")
# config.bind("<Ctrl-d>", "fake-key <Delete>")
# config.bind("<Alt-d>", "fake-key <Ctrl-Delete>")
# config.bind("<Alt-backspace>", "fake-key <Ctrl-Backspace>")
# config.bind("<Ctrl-w>", "fake-key <Ctrl-backspace>")
# config.bind("<Ctrl-y>", "insert-text {primary}")


# NAVIGATION

# Keybindings for basic scrolling are already configured by the editing fake keys.
# For fast scrolling.
# config.bind("<Ctrl-v>", "scroll-page 0 0.5")
# config.bind("<Alt-v>", "scroll-page 0 -0.5")

# scroll-page can fail on some pages that handles scrolling in non-standard way, below is more reliable:
config.bind("<Ctrl-v>", "fake-key -g <PgDown>")
config.bind("<Alt-v>", "fake-key -g <PgUp>")

config.bind("<Space>", "scroll-page 0 0.5")
config.bind("<Backspace>", "scroll-page 0 -0.5")

config.bind("<Ctrl-n>", "fake-key <Down>", mode="insert")
config.bind("<Ctrl-p>", "fake-key <Up>", mode="insert")

# movement on page with C-p / C-n
config.bind("<Ctrl-n>", "fake-key <Down>")
config.bind("<Ctrl-p>", "fake-key <Up>")

# paste C-y in input fileds
config.bind("<Ctrl-y>", "fake-key <Ctrl-v>", mode="insert")
# or try:
# config.bind('<Ctrl-y>', 'insert-text {clipboard}', mode='insert')

# undo on C-_
config.bind("<Ctrl-_>", "fake-key <Ctrl-z>", mode="insert")
config.bind("<Ctrl-Shift-->", "fake-key <Ctrl-z>", mode="insert")

# Go to end/beginning of page.
# xxx config.bind('<Alt-,>', 'scroll-to-perc 0')
# xxx config.bind('<Alt-.>', 'scroll-to-perc')


# BASIC COMMANDS

# Prompt and quitting keybindings.
config.bind("<Alt-x>", "cmd-set-text :")  # M-x

# Convert “C-g” in an escape key.
ESC_BIND = "clear-keychain ;; search ;; fullscreen --leave"
config.bind("<Ctrl-g>", ESC_BIND)

# Help utility.
config.bind("<Ctrl-h>", "cmd-set-text -s :help")

# # Open editor.
# config.bind("<Ctrl-x><Ctrl-e>", "edit-text")

# Zooming. (+ - =)
# config.bind("<Ctrl-0>", "zoom")
# config.bind("<Ctrl-=>", "zoom-in")
# config.bind("<Ctrl-->", "zoom-out")
# Prefer what I had on conkeror over emacs:
config.bind("<+>", "zoom-in")
config.bind("<->", "zoom-out")

# Yank selected text and site url to clipboard.
config.bind("<Alt-w>", "yank selection")
config.bind("<Ctrl-w>", "yank")


# TABS
config.bind("q", "tab-close")  # kill buffer
config.bind("Q", "undo")  # open last killed buffer

# :quit = quite qutebrowser entierly
# :close = close current window
# Close only the current window (like Emacs frame)
config.bind("<Ctrl-x><Ctrl-c>", "close")
# config.bind("<Ctrl-x><Ctrl-c>", "quit")

# Buffer / tab management (Conkeror “buffers”)
# (or just use default K/L)
config.bind("<Alt-n>", "tab-next")
config.bind("<Alt-p>", "tab-prev")

# because default K/J is reversed(!)
config.bind("gR", "tab-move +")
config.bind("gL", "tab-move -")

config.bind("<Alt-Shift-n>", "tab-move +")
config.bind("<Alt-Shift-p>", "tab-move -")

# or :tab-select to open new buffer of all tabs as bookmarks
# ('gt' by default)
config.bind("<Ctrl-x><Ctrl-b>", "cmd-set-text -s :tab-select")


# PROMPT MODE

# Basic keybindigs for promtp mode.
config.bind("<Ctrl-p>", "prompt-item-focus prev", mode="prompt")
config.bind("<Ctrl-n>", "prompt-item-focus next", mode="prompt")


# CARET MODE (e.g. for text selection)

# Enter caret mode (v/V by default)
config.bind("<Ctrl-Space>", "mode-enter caret")

# Basic commands for caret mode (i.e., visual mode).
config.bind("<Alt-w>", "yank selection", mode="caret")
config.bind("<Ctrl-Space>", "selection-toggle", mode="caret")

# Navigation inside caret mode.
config.bind("<Ctrl-f>", "move-to-next-char", mode="caret")
config.bind("<Ctrl-b>", "move-to-prev-char", mode="caret")
config.bind("<Ctrl-p>", "move-to-prev-line", mode="caret")
config.bind("<Ctrl-n>", "move-to-next-line", mode="caret")
config.bind("<Alt-f>", "move-to-next-word", mode="caret")
config.bind("<Alt-b>", "move-to-prev-word", mode="caret")
config.bind("<Ctrl-e>", "move-to-end-of-line", mode="caret")
config.bind("<Ctrl-a>", "move-to-start-of-line", mode="caret")
# xxx config.bind('<Alt-.>', 'move-to-end-of-document', mode='caret')
# xxx config.bind('<Alt-,>', 'move-to-start-of-document', mode='caret')

# Themes from: https://github.com/tinted-theming/base16-qutebrowser
config.source("/home/karlf/.config/qutebrowser/base16-gruvbox-dark-medium.config.py")

# increase font size of qutebrowser's interface, like command and prompt
c.fonts.default_size = "13pt"  # or 13pt, 14pt, 16pt, etc.

# # Explicit overrides (optional)
# c.fonts.statusbar = "12pt default_family"
# c.fonts.completion.entry = "12pt default_family"
# c.fonts.completion.category = "bold 12pt default_family"
# c.fonts.prompts = "12pt default_family"
# c.fonts.messages.info = "12pt default_family"
# c.fonts.messages.error = "12pt default_family"
# c.fonts.messages.warning = "12pt default_family"
# c.fonts.tabs.selected = "12pt default_family"
# c.fonts.tabs.unselected = "12pt default_family"
# c.fonts.hints = "bold 12pt default_family"

# Normal mode

# Download videos. use 'all' for embedded videos, since 'links' misses them
# config.bind(";z", "hint all spawn alacritty -e yt-dlp -S res:640 -P ~/ {hint-url}")

# this uses dmenu to selects resolution of dowload, since my Internet connection is shit
config.bind(";z", "hint all spawn --userscript yt-dlp-res {hint-url}")

config.bind(";Z", "hint all spawn --detach mpv {hint-url}")
# Open videos with mpv.
# config.bind("<Ctrl-m>", "spawn mpv {url}")
# config.bind("<Alt-m>", "hint all spawn --detach mpv {hint-url}")
# config.bind("<Alt-m>", "hint links spawn --detach mpv {hint-url}")


# 'hint title userscript show-title.sh'
c.hints.selectors.update({"title": ["[title]"]})

# needed for search button at www.yr.no, but adding it globally anyway.
# The yr.no search button is poorly implemented, and lacking a field  role="button".
c.hints.selectors["all"].append("#page-header__search-button")
# config.set(
#     "hints.selectors",
#     {"all": [*c.hints.selectors["all"], "#page-header__search-button"]},
#     "www.yr.no",
# )


# Conkeror's webjumps:
# tradera, wayback, archive
# http://downforeveryoneorjustme.com
c.url.searchengines = {
    # Websearch:
    "DEFAULT": "https://duckduckgo.com/?q={}",
    # DEFAULT: "https://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion/?q={}",
    "duck-html": "https://html.duckduckgo.com/html?q={}",
    "image": "https://duckduckgo.com/?q={}&ia=images&iax=images",
    "s": "https://www.startpage.com/do/search{}",
    "g": "https://www.google.com/search?q={}",
    "G": "https://encrypted.google.com/search?hl=en&source=hp&q={}",
    "brave": "https://search.brave.com/search?q={}",
    # "qwant": "https://www.qwant.com/?q={}",
    # Media
    "yt": "https://www.youtube.com/results?search_query={}&aq=f",
    "imdb": "https://www.imdb.com/find?q={}&s=all",
    "rateyourmusic": "https://rateyourmusic.com/search?searchtype=a&searchterm={}",
    "metalarchives": "https://www.metal-archives.com/search?searchString={}&type=band_name",
    "goodreads": "https://www.goodreads.com/search?q={}",
    # wikis
    "wiki": "https://en.wikipedia.org/wiki/Special:Search?search={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "aur": "https://aur.archlinux.org/packages?O=0&K={}",
    # Misc.
    "c++": "http://www.cplusplus.com/search.do?q={}",
    "openstreetmap": "https://www.openstreetmap.org/search?query={}",
    "unvisit": "https://unvis.it/{}",
    # Shopping
    "abebooks": "https://www.abebooks.com/servlet/SearchResults?kn={}",
    "ebay": "http://www.ebay.co.uk/sch/i.html?_nkw={}",
    # Pioneer
    "pioneergit": "https://github.com/pioneerspacesim/pioneer/issues/{}",
    # Dictionaries
    "synonym": "https://www.synonymer.se/sv-syn/{}",
    "urban": "https://www.urbandictionary.com/define.php?term={}",
    "dictionary": "https://www.thefreedictionary.com/{}",
    "thesaurus": "https://www.thefreedictionary.com/{}#Thesaurus",
    "trans": "https://translate.google.com/translate_t#auto|en|{}",
}
# Make webjump work also if no search term given. NOTE: for jumps where
# I don't want the base url, (e.g. pioneergit) also add same alias in
# quickmarks-file.
config.set("url.open_base_url", True)


# PRIVACY / TRACKING

# For privacy reasons, I’m setting a generic user-agent to minimize fingerprinting.
c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36"
# config.set("content.webgl", False, "*")
config.set("content.canvas_reading", True)
config.set("content.geolocation", False)  # True, False, 'ask'

# "all", "no-3rdparty", "no-unknown-3rdparty", "never"
config.set("content.cookies.accept", "all")

# config.set("content.cookies.store", True)
config.set("content.javascript.enabled", True)


# KEEPASSXC integration:

config.bind(
    "pw",
    "spawn --userscript qute-keepassxc --key 5436BCEDAE64A288",
    mode="normal",
)
config.bind(
    "<Alt-Shift-u>",
    "spawn --userscript qute-keepassxc --key 5436BCEDAE64A288",
    mode="insert",
)

# For TOTP, manually select input field, then exit input mode (ESC), then run:
config.bind(
    "pt",
    "spawn --userscript qute-keepassxc --key 5436BCEDAE64A288 --totp",
    mode="normal",
)

c.url.start_pages = ["file:///home/karlf/.config/qutebrowser/startpage.html"]
c.url.default_page = "file:///home/karlf/.config/qutebrowser/startpage.html"
