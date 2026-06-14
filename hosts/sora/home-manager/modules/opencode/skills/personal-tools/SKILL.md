---
name: personal-tools
description: Use when answering Lucky's questions about his terminal PIM tools: khal (calendar), khard (contacts), and todoman (todos). Covers all commands, options, configuration, and troubleshooting for each tool. Use for calendar queries, contact lookups, task management, and pimutils ecosystem questions.
---

# Personal PIM Tools

Lucky uses the **pimutils** suite for calendar, contacts, and todos. All three
are vdir-based CLI tools that work with local directories of files and sync to
remote servers via **vdirsyncer**. They never talk to the network directly.

## Architecture

```
CalDAV/CardDAV server  <--vdirsyncer-->  local vdir directory  <--khal/khard/todoman-->
```

- **vdirsyncer** syncs `.ics` and `.vcf` files between remote servers and local directories.
- **khal** reads/writes iCalendar `.ics` files for calendar events.
- **khard** reads/writes vCard `.vcf` files for contacts.
- **todoman** (binary: `todo`) reads/writes iCalendar `.ics` files for tasks.

Each tool maintains its own **sqlite cache** at `~/.cache/<tool>/` for fast startup.

## Data Storage (vdir format)

One file per item in a directory:

```
~/.local/share/calendars/
├── personal/
│   ├── color          # optional: hex color for this list
│   ├── displayname    # optional: human-readable name override
│   ├── event1.ics
│   └── event2.ics
├── work/
│   └── meeting.ics
└── contacts/
    ├── john.vcf
    └── jane.vcf
```

The `color` file contains a hex color like `#FF0000`. The `displayname` file
contains a human-readable name (otherwise the directory name is used).

## How Lucky expects them to be used

- Lucky uses these tools daily. He knows their syntax; what he needs from you
  is accurate syntax reminders, troubleshooting, or help constructing complex
  queries.
- Never guess Lucky's config paths or calendar names. If you need to know
  those, check his dotfiles in `~/Documents/NixConfig/` or ask.
- When Lucky asks "what's on my calendar today" or similar, you should
  construct and run the appropriate `khal` command.
- When Lucky asks about contacts, you should construct and run the appropriate
  `khard` command.
- When Lucky asks about tasks, you should construct and run the appropriate
  `todo` command.

---

# khal — Terminal Calendar

## Quick reference

| Action | Command |
|--------|---------|
| List today's events | `khal list` |
| List events for N days | `khal list today 7d` |
| List specific date range | `khal list 2026-06-15 2026-06-20` |
| Events at specific time | `khal at 14:00` |
| Events right now | `khal at now` |
| Calendar view (3 months) | `khal calendar` |
| Add an event | `khal new 18:00 Event Title` |
| Add with description | `khal new 18:00 20:00 Title :: Description text` |
| Add to specific calendar | `khal new -a work 18:00 Meeting` |
| Add all-day event | `khal new 2026-06-15 All Day Conference` |
| Add recurring event | `khal new -r weekly 18:00 Team Standup` |
| Add event with alarm | `khal new --alarms 15m 18:00 Dentist` |
| Add with location | `khal new -l "Room 101" 18:00 Meeting` |
| Add with categories | `khal new -g meeting 18:00 Standup` |
| Search events | `khal search party` |
| Edit/delete interactively | `khal edit "search term"` |
| Interactive TUI | `khal interactive` or `ikhal` |
| Import .ics file | `khal import -a calendar file.ics` |
| List configured calendars | `khal printcalendars` |
| Preview date/time formats | `khal printformats` |
| Initial config wizard | `khal configure` |

## Configuration: `~/.config/khal/config`

INI format. Three main sections: `[calendars]`, `[default]`, `[locale]`.

### `[calendars]` section

```ini
[calendars]

  [[personal]]
    path = ~/.local/share/calendars/personal/
    color = dark green
    priority = 20

  [[work]]
    path = ~/.local/share/calendars/work/
    readonly = True

  [[all]]
    path = ~/.local/share/calendars/*
    type = discover
    color = dark green

  [[birthdays]]
    path = ~/.local/share/contacts/
    type = birthdays   # extracts from vCard .vcf files
```

Per-calendar options:
- **path** (mandatory): directory with `.ics` files (vdir)
- **color**: 16 named colors, 256-color index (0-255), or 24-bit `#RRGGBB`. `auto` reads from a `color` file in the vdir. Default: `auto`
- **priority** (int, default 10): higher = wins when coloring days
- **readonly** (bool, default False): prevent khal from writing to this calendar
- **type**: `calendar` (default), `birthdays` (extract from vCard), `discover` (glob-expand path)
- **addresses**: comma-separated email addresses for PARTSTAT matching

### `[locale]` section

Controls date/time parsing and display. Python `strftime` format strings.

```ini
[locale]
local_timezone = Europe/Berlin
default_timezone = Europe/Berlin

timeformat = %H:%M
dateformat = %d.%m.
longdateformat = %d.%m.%Y
datetimeformat = %d.%m. %H:%M
longdatetimeformat = %d.%m.%Y %H:%M

firstweekday = 0        # 0=Monday, 6=Sunday
weeknumbers = off       # or 'left' or 'right'
unicode_symbols = True  # or False for ASCII-only
```

### `[default]` section

```ini
[default]
default_calendar = personal
default_event_duration = 1h
default_dayevent_duration = 1d
default_event_alarm = 15m
default_dayevent_alarm = 12h
timedelta = 2d          # how far into the future to show by default
show_all_days = False   # show empty days in list view
print_new = False       # or 'event' or 'path'
highlight_event_days = False
enable_mouse = True
```

### `[keybindings]` section

ikhal keyboard shortcuts. Default vim-like bindings:

| Action | Default key |
|--------|-------------|
| move up/down/left/right | up/down/left/right, k/j/h/l |
| today | t |
| new event | n |
| delete (toggle) | d |
| duplicate event | p |
| export event | e |
| search | / |
| visual mode (range) | v |
| switch range end in visual | o |
| save (in editor) | meta+enter |
| view/edit event | enter |
| external edit (.ics file) | meta+E |
| quit | q, Q |
| show log | L |

### `[palette]` section

Override ikhal color theme. Format: `key = fg, bg, mono, fg_high, bg_high`.

```ini
[palette]
header = light red, default, default, '#ff0000', default
edit = '', '', 'bold', '#FF00FF', '#12FF14'
```

`[view]` section controls formatting: `agenda_event_format`, `event_format`,
`agenda_day_format`, `frame`, `theme`, `dynamic_days`, `monthdisplay`.

### `[sqlite]` section

```ini
[sqlite]
path = ~/.cache/khal/khal.db
```

## `khal list` in detail

```
khal list [-a CALENDAR | -d CALENDAR] [--format FORMAT] [--day-format DAYFORMAT]
          [--once] [--notstarted] [START [END | DELTA]]
```

- `-a CALENDAR`: include only this calendar (repeatable)
- `-d CALENDAR`: exclude this calendar (repeatable)
- `START` / `END`: dates/times/datetimes in configured format
- If no END: midnight of start date. If no START: today.
- `DELTA`: `{N}{m,h,d}` (e.g. `30d`, `2h`, `90m`) or `eod` (end of day) or `week`
- `--once`: show multi-day events only once
- `--notstarted`: only events starting after START
- `--format`: template with `{title}`, `{description}`, `{location}`, `{start}`, `{end}`, `{start-time}`, `{end-time}`, `{calendar}`, `{calendar-color}`, `{repeat-symbol}`, `{alarm-symbol}`, `{status}`, `{categories}`, `{duration}`, `{uid}`, `{url}`, `{all-day}`, `{repeat-pattern}`, etc.
- `--json FIELD`: output as JSON array (stable for scripting)
- `--day-format`: template for day headers: `{date}`, `{date-long}`, `{name}`
- `--color`/`--no-color`: force or suppress color

**Time formats for `khal new`:**

khal understands: `today`, `tomorrow`, weekday names (next occurrence), and dates in configured formats.

```
khal new 18:00 Event Title                              # today at 18:00, 1h default
khal new tomorrow 16:30 Coffee                          # tomorrow 16:30
khal new 25.10. 18:00 24:00 Party :: With friends       # date with end time
khal new 26.07. Conference -r weekly -g meeting         # all-day recurring
```

Options for `khal new`:
- `-a CALENDAR`: target calendar
- `-l LOCATION`, `--location`
- `-g CATEGORIES`, `--categories` (comma-separated)
- `-r RRULE`, `--repeat`: `daily`, `weekly`, `monthly`, `yearly`
- `-u UNTIL`, `--until`: end date for recurrence
- `--url URL`
- `--alarms DURATION,...`: e.g. `15m,1h` (negative = after event start)
- `--interactive` / `-i`: interactive event creation (all fields optional, opens editor)

## `khal at` in detail

```
khal at [-a CALENDAR | -d CALENDAR] [--format FORMAT] [--notstarted]
        [[START DATE] TIME | now]
```

Shows events happening at an exact datetime. Defaults to `now`.

## `khal calendar` in detail

Displays 3 consecutive months (configurable via `min_calendar_display`). Same
date range syntax as `khal list`. Today is highlighted.

## `khal edit` in detail

```
khal edit [--show-past] event_search_string
```

Loops through all matching events, prompting to delete or edit each attribute
interactively.

## `khal interactive` / ikhal in detail

Full TUI with three panes:
- **Left**: calendar browser with month view
- **Right**: event list for selected day/range
- **Bottom (optional)**: event detail viewer/editor

Navigation flow:
1. Calendar pane: arrow keys / hjkl, `v` for visual range mode, `t` for today, `n` for new event on selected day, `/` to search
2. Tab/Enter: focus event list. `j`/`k` to move through events, Enter to view details, Enter again to edit
3. In editor: Tab/Shift+Tab between fields, ctrl+a/ctrl+x to increment/decrement numbers (15min steps for time), meta+enter to save, esc to cancel

In visual range mode:
- `o`: switch to the other end of the range
- `esc`: exit visual mode
- `n`: create event spanning the selected range

Deletion:
- `d`: toggle deletion mark (D prefix). Events are actually deleted when exiting ikhal (with confirmation).

ikhal exit:
- `q`/`Q` or `esc` from top-level pane (press esc again to confirm).

## `khal import`

```
khal import [-a CALENDAR] [--batch] [--random-uid|-r] ICSFILE
```

- `--batch`: auto-update without prompting (if UID already exists)
- `--random-uid` / `-r`: generate new random UID for the imported event

## Format templates

Available in `--format` and `event_format`/`agenda_event_format` config:

| Template | Description |
|----------|-------------|
| `{title}` | Event title |
| `{description}` | Event description |
| `{description-separator}` | " :: " if description exists |
| `{location}` | Event location |
| `{start}` / `{end}` | Start/end datetime in datetimeformat |
| `{start-long}` / `{end-long}` | Start/end in longdatetimeformat |
| `{start-date}` / `{end-date}` | Start/end date only |
| `{start-time}` / `{end-time}` | Start/end time only |
| `{start-style}` / `{end-style}` | Time or symbol (for compact display) |
| `{start-end-time-style}` | Compact time range |
| `{to-style}` | "-" or nothing |
| `{end-necessary}` | End time/date only if differs from start |
| `{duration}` | Human-readable duration (e.g. "1h 30m") |
| `{repeat-symbol}` | Loop arrow if recurring |
| `{alarm-symbol}` | Alarm clock if alarms set |
| `{repeat-pattern}` | Raw iCal RRULE string |
| `{calendar}` | Calendar name |
| `{calendar-color}` | ANSI color code of calendar |
| `{status}` | CONFIRMED, CANCELLED, etc. |
| `{status-symbol}` | ✓, ✗, ? |
| `{cancelled}` | "CANCELLED " string if cancelled |
| `{partstat-symbol}` | Participation status symbol |
| `{uid}` | Event UID |
| `{url}` | Event URL |
| `{categories}` | Event categories |
| `{organizer}` | Organizer name and email |
| `{all-day}` | Boolean: whether all-day event |
| `{nl}` / `{tab}` / `{bell}` | Control characters |
| `{reset}` / `{bold}` | ANSI styling |

Color names available: `black`, `red`, `green`, `yellow`, `blue`, `magenta`,
`cyan`, `white` (plus `bold` and `-bold` variants like `red-bold`).

## Common khal usage patterns

```bash
# Today's events
khal list

# Next 7 days from today
khal list today 7d

# This week (Monday-Sunday)
khal list today week

# Only work calendar
khal list -a work

# Exclude a calendar
khal list -d trash_calendar

# Custom format: compact
khal list --format "{start-time} {title}"

# Custom format: verbose
khal list --format "{bold}{title}{reset} ({calendar-color}{calendar}{reset}) @ {start-time} - {end-time}"

# JSON output (scriptable)
khal list --json title --json start --json location

# Events at specific time
khal at 15:30

# Events happening right now
khal at now

# Search for "dentist" in all events
khal search dentist

# Add an event with alarm
khal new -a personal --alarms 30m tomorrow 10:00 Dentist appointment :: Bring insurance card

# Calendar view starting from a date
khal calendar 2026-07-01
```

---

# khard — Terminal Address Book

## Quick reference

| Action | Command |
|--------|---------|
| List all contacts | `khard list` |
| List filtered | `khard list search_term` |
| List specific addressbook | `khard list -a work` |
| Field-specific search | `khard list name:Lucky emails:example.com` |
| Show contact details | `khard show "Lucky"` |
| Export as YAML | `khard show --format=yaml -o file.yaml "Lucky"` |
| Export as vCard | `khard show --format=vcard "Lucky"` |
| New contact | `khard new -a addressbook` |
| New from YAML file | `khard new -i contact.yaml` |
| New from stdin | `echo "..." | khard new` |
| Edit contact | `khard edit "Lucky"` |
| Edit from YAML | `khard edit -i contact.yaml search_term` |
| Merge two contacts | `khard merge source -t target` |
| Copy to another book | `khard copy -a source -A target "Contact"` |
| Move to another book | `khard move -a source -A target "Contact"` |
| Remove contact | `khard remove "Contact"` |
| List email addresses | `khard email [search]` |
| List phone numbers | `khard phone [search]` |
| List postal addresses | `khard postaddress [search]` |
| List birthdays | `khard birthdays` |
| Show YAML template | `khard template` |
| List addressbooks | `khard addressbooks` |
| List contact filenames | `khard filename [search]` |
| Extract email from header | `khard add-email -H from < email.txt` |
| New with vCard 4.0 | `khard new --vcard-version=4.0` |

## Configuration: `~/.config/khard/khard.conf`

```ini
[addressbooks]
[[family]]
path = ~/.contacts/family/
[[friends]]
path = ~/.contacts/friends/
[[work]]
path = ~/.work/contacts/
type = discover    # glob-expand path for multiple vdirs

[general]
debug = no
default_action = list
editor = vim, -i, NONE
merge_editor = vimdiff

[contact table]
display = first_name          # first_name / last_name / formatted_name
group_by_addressbook = no
reverse = no
show_nicknames = no
show_uids = yes
show_kinds = no
sort = last_name
localize_dates = yes
preferred_phone_number_type = pref, cell, home   # descending priority
preferred_email_address_type = pref, work, home

[vcard]
private_objects = Jabber, Skype, Twitter   # custom X- fields
preferred_version = 3.0                    # or 4.0
search_in_source_files = no                # speed up search (may be incomplete)
skip_unparsable = no
```

### Query language

`khard` supports field-specific search with `field:value` syntax:

```bash
khard list name:Lucky                      # search "name" fields only
khard list emails:example.com              # search email fields only
khard list phone:555                       # search phone fields only
khard list org:"Acme Inc"                  # search organization field
```

Available fields: `name`, `emails`, `phone`, `org`, `title`, `role`,
`categories`, `nicknames`, `notes`, and all other vCard fields (lowercased,
underscores for spaces, e.g. `formatted_name`).

**Important**: The `name:` field searches all name components (prefix, first,
additional, last, suffix, nickname, formatted name).

**Important**: Typos in field names fall back to general search. `email:foo`
searches for literal "email:foo" in any field — the correct field is `emails:foo`.

### Subcommand aliases

Most subcommands have short aliases:
- `khard list` = `khard ls`
- `khard show` = `khard details`
- `khard new` = `khard add`
- `khard edit` = `khard modify` = `khard ed`
- `khard copy` = `khard cp`
- `khard move` = `khard mv`
- `khard remove` = `khard delete` = `khard del` = `khard rm`
- `khard postaddress` = `khard post` = `khard postaddr`
- `khard addressbooks` = `khard abooks`
- `khard filename` = `khard file`

### Item selection (search terms)

Most commands accept search terms to identify the contact. If multiple contacts
match, the first one is used. For commands needing two contacts (merge), use
`-t target_search` for the second.

```bash
khard show Lucky                    # exact or partial match
khard edit Lucky                    # edit the first matching contact
khard merge source -t target        # merge two contacts
khard remove Lucky --force          # delete without confirmation
```

### Contact YAML format

```yaml
Prefix:
First name: John
Additional:
Last name: Smith
Nickname: Johnny
Organisation: Acme Inc.
Title: Software Engineer
Role: Development
Phone:
    cell: +1 555 1234
    home: +1 555 5678
Email:
    work: john.smith@example.org
    personal: johnny@example.com
Post addresses:
    home: 123 Main St, Anytown, USA
Categories:
    - work
    - friends
Jabber: johnny@jabber.example.com
Skype: johnny.skype
Twitter: @johnny
Birthday: 1990-01-15
Note: Some note text
```

The `private_objects` config option (Jabber, Skype, Twitter in the example
above) adds custom fields to the template.

### Merging contacts

```
khard merge source_contact -t target_contact
```

Opens `merge_editor` (vimdiff by default) with both contacts. Merge changes
from source into target. On save, source is deleted and target updated.

### Copying / moving between addressbooks

```bash
khard copy -a family -t work "John Smith"    # copy to work
khard move -a work -t personal "John Smith"  # move to personal
```

### Email integration (mutt/neomutt)

```bash
# List all email addresses (mutt query format)
khard email Lucky

# Parsable output (for scripts)
khard email -p Lucky

# Remove the "searching for..." header line
khard email --remove-first-line Lucky

# Add email from a mail header
khard add-email -H from < email.txt
khard add-email -H from,to,cc < email.txt
```

### Phone integration

```bash
khard phone Lucky          # list phone numbers
khard phone -p Lucky       # parsable: number\tname\ttype
```

### Birthdays

```bash
khard birthdays            # all contacts with birthdays, sorted by month/day
khard birthdays -p         # parsable: name\tdate
```

### Output formats

```bash
khard show --format=pretty "John"    # human-readable (default)
khard show --format=yaml "John"      # YAML
khard show --format=vcard "John"     # vCard (.vcf)

# Export to file
khard show --format=yaml -o john.yaml "John"
```

### Editing workflow

```bash
# 1. Export contact to YAML
khard show --format=yaml -o contact.yaml "John"

# 2. Edit the YAML file manually
hx contact.yaml

# 3. Re-import the edited YAML
khard edit -i contact.yaml "John"

# Or pipe directly:
khard show --format=yaml "John" | hx ...

# Alternative: direct edit (opens editor)
khard edit "John"
```

### Common khard usage patterns

```bash
# List all contacts, sorted by last name
khard list

# List contacts from a specific addressbook
khard list -a work

# Search by name
khard list Lucky

# Search by email
khard list emails:lucky@example.com

# Search by organization
khard list org:"Acme"

# Show full contact details
khard show "Lucky"

# Quick email lookup for mutt
khard email Lucky

# Quick phone lookup
khard phone Lucky

# Add a new contact (opens editor with YAML template)
khard new -a personal

# Add from pre-filled YAML
khard new -i new-contact.yaml

# Remove without confirmation
khard remove "John" --force

# List upcoming birthdays
khard birthdays
```

---

# todoman — Terminal Todo Manager

**Binary name**: `todo` (not `todoman`). The `todoman` package provides the `todo` command.

## Quick reference

| Action | Command |
|--------|---------|
| List all tasks | `todo` or `todo list` |
| List for specific list | `todo list -l personal` |
| Create a task | `todo new Summary text` |
| Create with due date | `todo new -d 2026-06-20 Task` |
| Create with priority | `todo new -p 1 Urgent task` |
| Create on a list | `todo new -l work Task` |
| Show task details | `todo show 3` |
| Edit task (TUI) | `todo edit 3` |
| Mark as done | `todo done 3` |
| Un-mark done | `todo undo 3` |
| Cancel a task | `todo cancel 3` |
| Delete a task | `todo delete 3` |
| Move to another list | `todo move 3 -l target_list` |
| Copy to another list | `todo copy 3 -l target_list` |
| Delete all done tasks | `todo flush` |
| List available lists | `todo lists` |
| Show file path of task | `todo path 3` |
| Interactive shell | `todo repl` |
| Sort by due date | `todo list --sort due` |
| Sort reverse | `todo list --sort -priority` |
| Porcelain (JSON) output | `todo --porcelain list` |
| Human-friendly dates | `todo --humanize list` |

## Output format

```
1 [ ] !!! 2015-04-30 Close bank account @work (0%)
2 [ ] !              Send minipimer back @home (0%)
3 [X]     2015-03-29 Buy soy milk @home (100%)
4 [ ] !!             Fix the iPad's screen @home (0%)
```

Columns: id, done-status ([ ] or [X]), priority (!!! high, !! medium, ! low),
due date, summary, @list (hidden when filtering by one list or single list),
completion %.

## Task IDs

- Tasks get a semi-permanent ID when listed.
- IDs are retained until the next `todo flush` operation.
- Refer to tasks by ID: `todo edit 3`, `todo done 3`, etc.

## Commands in detail

### `todo list` (default)

```
todo [list] [-l LIST] [--sort FIELD] [--reverse] [--startable]
            [--start-before DATE] [--start-after DATE] [--due-before DATE]
            [--due-after DATE] [--status STATUS] [--priority PRIORITY]
            [--categories CATEGORIES]
```

- `-l` / `--list`: filter to specific list
- `--sort FIELD`: sort by field. Prepending `-` reverses (ascending)
- `--reverse`: reverse sort order
- `--startable`: only show tasks where start date <= today (or no start date)
- `--start-before` / `--start-after`: filter by start date
- `--due-before` / `--due-after`: filter by due date
- `--status`: filter by status (e.g. COMPLETED, CANCELLED, NEEDS-ACTION)
- `--priority`: filter by priority number

### `todo new`

```
todo new [-l LIST] [-d DUE_DATE] [--start START_DATE] [--priority N]
         [--description TEXT] SUMMARY
```

- `-l` / `--list`: target list (required unless `default_list` is set)
- `-d` / `--due`: due date. Supports `today`, `tomorrow`, ISO dates.
- `--start`: start date (hidden until this date if `startable` is enabled)
- `-p` / `--priority`: 1 (highest) to 10 (lowest). 0 or omitted = no priority.
- `--description`: task description/notes

Examples:
```bash
todo new Buy groceries
todo new -l personal -d tomorrow Buy groceries
todo new -l work -p 1 -d "2026-06-20" --description "Prepare slides" Quarterly review
```

### `todo edit`

```
todo edit ID
```

Opens a TUI editor for the task. Can modify all fields: summary, description,
due date, priority, etc. This is currently TUI-only (no CLI editing).

### `todo done` / `todo undo` / `todo cancel`

```bash
todo done 3              # mark as completed
todo done 3 5 7          # mark multiple
todo undo 3              # un-mark as incomplete
todo cancel 3            # cancel (different from done)
```

### `todo delete` / `todo flush`

```bash
todo delete 3            # delete a single task (with confirmation)
todo flush               # delete ALL completed tasks (also resets IDs)
```

Always run `flush` after completing a batch of tasks to clean up.

### `todo move` / `todo copy`

```bash
todo move 3 -l target_list
todo copy 3 -l target_list
```

### `todo show` / `todo path`

```bash
todo show 3              # detailed view of task
todo path 3              # print filesystem path to task's .ics file
```

### `todo lists`

Lists all configured task lists (vdir directories).

### `todo repl`

Launches an interactive shell with tab-completion (requires `click-repl`).

## Configuration: `~/.config/todoman/config.py`

This is a Python file (though it looks like INI). Simple key=value format.

```python
# Glob pattern matching directories with .ics files. Each matching dir = one list.
path = "~/.local/share/calendars/*"

date_format = "%Y-%m-%d"
time_format = "%H:%M"

# Default list name (directory name)
default_list = "Personal"

# Default due date offset in hours (0 = no due date)
default_due = 48

# Default priority for new tasks (1-10, or None for no priority)
default_priority = None

# String separating date and time in display
dt_separator = " "

# Human-friendly dates like "tomorrow", "in 2 hours"
humanize = False

# Only show tasks whose start date has passed (or has no start date)
startable = False

# Cache database location
# cache_path = "~/.cache/todoman/cache.sqlite3"

# Color mode: auto, always, never
color = "auto"

# Default command when running `todo` with no args
default_command = "list"
```

### Per-list metadata

Like khal, todoman supports `color` and `displayname` files in each vdir:
- `~/.local/share/calendars/personal/color` → `#FF0000`
- `~/.local/share/calendars/personal/displayname` → `My Personal Tasks`

### Environment variables

- `TODOMAN_CONFIG`: path to config file (overrides default location)
- `TZ`: override timezone (otherwise uses system timezone)

## Sorting

Available sort fields: `description`, `location`, `status`, `summary`, `uid`,
`rrule`, `percent_complete`, `priority`, `sequence`, `categories`,
`completed_at`, `created_at`, `dtstamp`, `start`, `due`, `last_modified`.

```bash
todo list --sort due,-priority        # sort by due date (desc), then priority (asc)
todo list --sort created_at           # oldest first? No — desc by default, so newest first
```

**Sort order**: Default is **descending**. Prepend `-` for **ascending**.
Note: this can be counterintuitive — `--sort priority` shows priority 10 first
(lowest). Use `--sort -priority` to show highest priority (1) first.

## Porcelain output (scripting)

Add `--porcelain` for stable JSON output:

```bash
todo --porcelain list
```

Output is a JSON array of todo objects. Fields are always present (null if
unset). Fields may be added in future releases but never removed.

## Caveats

- **percent_complete**: only 0% (incomplete) or 100% (complete). No partial
  completion tracking.
- **Editing**: currently TUI-only (`todo edit ID`). No CLI editing of task
  fields beyond what `todo new` offers.
- **No sub-tasks or dependencies**: todoman is intentionally simple.

## Common todoman usage patterns

```bash
# List all tasks sorted by due date (soonest first)
todo list --sort -due

# Add a task to personal list due tomorrow
todo new -l personal -d tomorrow Buy milk

# Add a high priority work task
todo new -l work -p 1 -d 2026-06-20 Submit report

# Mark task as done
todo done 3

# See what's due this week
todo list --due-before 2026-06-21

# Clean up completed tasks
todo flush

# Browse all lists
todo lists
```

---

# Pimutils Ecosystem Tips

## vdirsyncer integration

While these tools don't sync themselves, Lucky likely has vdirsyncer set up.
The typical workflow is:

```bash
# Sync calendars/contacts/tasks from server
vdirsyncer sync

# Now use local tools
khal list
khard list
todo list

# After making changes, sync back
vdirsyncer sync
```

## Shared patterns

1. **Date formats**: khal uses `strftime` patterns. todoman uses similar formats
   but configures them in `date_format`/`time_format` keys. khard uses system locale.
2. **Vdir discovery**: both khal (`type = discover`) and todoman (`path` with
   glob) support glob patterns to auto-discover vdirs.
3. **Color files**: all three respect `color` files in vdir directories.
4. **Displayname files**: khal and todoman support `displayname` files.
5. **Multiple calendars/lists**: all three can work with multiple vdirs,
   filtering by name or addressbook.

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| khal: "No such calendar" | Calendar name doesn't match config | Check `khal printcalendars` |
| khal: events not showing | vdirsyncer not synced | Run `vdirsyncer sync` first |
| khal: wrong timezone | Timezone not configured | Check `[locale] default_timezone` |
| khard: "Config file not found" | Missing or wrong path | Place at `~/.config/khard/khard.conf` |
| khard: no contacts | Empty vdir or wrong path | Check `[addressbooks] path` in config |
| khard: search returns nothing | Case-sensitive? | khard search is case-insensitive |
| todo: "No default list" | not configured | Set `default_list` in config or use `-l` |
| todo: task ID changed | Flush was run | IDs reset after `todo flush` |
| Any tool: slow startup | Large cache/sync needed | Check `~/.cache/<tool>/` db size |
