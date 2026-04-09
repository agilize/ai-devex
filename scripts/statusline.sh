#!/usr/bin/env zsh
# Claude Code status line — compact developer view
#
# Shows: directory (git-branch)* | model | ctx [bar] % | rate limits | session duration
#
# INSTALLATION
# ------------
# 1. Copy this script anywhere accessible, e.g.:
#      cp scripts/statusline.sh ~/.claude/statusline.sh
#      chmod +x ~/.claude/statusline.sh
#
# 2. Register it as the status line command in ~/.claude/settings.json:
#      {
#        "statusline": {
#          "command": "~/.claude/statusline.sh"
#        }
#      }
#
# Or use the Claude Code settings agent:
#      /statusline-setup

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir=$(basename "$cwd")

# Colors (ANSI)
cyan='\033[36m'
red='\033[31m'
blue='\033[34m'
yellow='\033[33m'
green='\033[32m'
dim='\033[2m'
reset='\033[0m'
bold='\033[1m'

sep=" ${dim}|${reset} "

# ---------------------------------------------------------------------------
# Git info
# ---------------------------------------------------------------------------
git_branch=""
git_dirty=""
if git -C "$cwd" --no-optional-locks rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if ! git -C "$cwd" --no-optional-locks diff --quiet 2>/dev/null \
    || ! git -C "$cwd" --no-optional-locks diff --cached --quiet 2>/dev/null \
    || git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard --quiet 2>/dev/null | grep -q .; then
    git_dirty="${yellow}*${reset}"
  fi
fi

# ---------------------------------------------------------------------------
# Model — extract short name: "Claude 3.5 Sonnet" -> "Sonnet"
#                              "claude-opus-4"     -> "Opus"
# ---------------------------------------------------------------------------
model_raw=$(echo "$input" | jq -r '.model.display_name // .model.id // empty')
model=""
if [ -n "$model_raw" ]; then
  # Try to match known family names in order (case-insensitive)
  case "${model_raw:l}" in
    *opus*)   model="Opus"   ;;
    *sonnet*) model="Sonnet" ;;
    *haiku*)  model="Haiku"  ;;
    *)        model=$(echo "$model_raw" | sed 's/^[Cc]laude[- ]//' | sed 's/[ -][0-9].*//')  ;;
  esac
fi

# ---------------------------------------------------------------------------
# Context window — ASCII progress bar + percentage
# ---------------------------------------------------------------------------
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_part=""
if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")

  # Color threshold
  if [ "$used_int" -ge 80 ]; then
    ctx_color=$red
  elif [ "$used_int" -ge 50 ]; then
    ctx_color=$yellow
  else
    ctx_color=$green
  fi

  # Build 10-char bar: filled = round(used_int / 10), empty = 10 - filled
  filled=$(( (used_int + 5) / 10 ))
  [ "$filled" -gt 10 ] && filled=10
  empty=$(( 10 - filled ))

  bar=""
  i=0
  while [ $i -lt $filled ]; do bar="${bar}█"; i=$(( i + 1 )); done
  i=0
  while [ $i -lt $empty ];  do bar="${bar}░"; i=$(( i + 1 )); done

  ctx_part="${sep}${ctx_color}ctx [${bar}] ${used_int}%${reset}"
fi

# ---------------------------------------------------------------------------
# Session duration — derived from transcript file mtime
# ---------------------------------------------------------------------------
duration_part=""
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  # Birth time not reliably available on Linux; use mtime of the file as
  # "last activity" and creation time approximated by the oldest line's
  # timestamp if available, otherwise fall back to mtime delta from now.
  # Simpler: use the transcript file's change time as session start proxy.
  file_ctime=$(stat -c %W "$transcript_path" 2>/dev/null)   # birth time (Linux, may be 0)
  if [ -z "$file_ctime" ] || [ "$file_ctime" -eq 0 ] 2>/dev/null; then
    file_ctime=$(stat -c %Y "$transcript_path" 2>/dev/null)  # fallback: mtime
  fi
  if [ -n "$file_ctime" ] && [ "$file_ctime" -gt 0 ] 2>/dev/null; then
    now=$(date +%s)
    elapsed=$(( now - file_ctime ))
    if [ $elapsed -lt 0 ]; then elapsed=0; fi
    hours=$(( elapsed / 3600 ))
    mins=$(( (elapsed % 3600) / 60 ))
    if [ $hours -gt 0 ]; then
      duration_str="${hours}h${mins}m"
    else
      duration_str="${mins}m"
    fi
    duration_part="${sep}${dim}${duration_str}${reset}"
  fi
fi

# ---------------------------------------------------------------------------
# Rate limits — show 5h and/or 7d when available
# ---------------------------------------------------------------------------
rate_part=""
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
rate_str=""
if [ -n "$five_pct" ]; then
  five_int=$(printf '%.0f' "$five_pct")
  if [ "$five_int" -ge 80 ]; then
    r5_color=$red
  elif [ "$five_int" -ge 50 ]; then
    r5_color=$yellow
  else
    r5_color=$dim
  fi
  rate_str="${r5_color}5h:${five_int}%${reset}"
fi
if [ -n "$week_pct" ]; then
  week_int=$(printf '%.0f' "$week_pct")
  if [ "$week_int" -ge 80 ]; then
    r7_color=$red
  elif [ "$week_int" -ge 50 ]; then
    r7_color=$yellow
  else
    r7_color=$dim
  fi
  [ -n "$rate_str" ] && rate_str="${rate_str} "
  rate_str="${rate_str}${r7_color}7d:${week_int}%${reset}"
fi
[ -n "$rate_str" ] && rate_part="${sep}${rate_str}"

# ---------------------------------------------------------------------------
# Assemble output
# ---------------------------------------------------------------------------

# Location: dir (branch)*
if [ -n "$git_branch" ]; then
  location="${cyan}${bold}${dir}${reset} ${blue}(${red}${git_branch}${blue})${reset}"
  [ -n "$git_dirty" ] && location="${location} ${git_dirty}"
else
  location="${cyan}${bold}${dir}${reset}"
fi

# Model
model_part=""
[ -n "$model" ] && model_part="${sep}${dim}${model}${reset}"

printf "%b%b%b%b%b" \
  "$location" \
  "$model_part" \
  "$ctx_part" \
  "$rate_part" \
  "$duration_part"
