# Fawry-Intern


# Q1 : Custom Command (mygrep.sh)

## Description

This Bash script wraps `grep` to add simple command-line parsing for a pattern and filename, along with options to:

- Show line numbers (`-n`)
- Invert match (`-v`)
- Display usage information (`--help`)

## How the Script Works

---

### 1. Manual Check for `--help`
Before parsing options, the script checks if the first argument is `--help`.  
If so, it prints a usage message and exits immediately.

```bash
if [[ "$1" == "--help" ]]; then
  print_usage
fi
```

---

### 2. Initialize an Options Variable
An empty `options` variable is initialized to collect any `grep` flags:

```bash
options=""
```

---

### 3. Parse Short Options with `getopts`
The script uses `getopts` to parse short options `-n` and `-v`.

```bash
while getopts "nv" opt; do
  case $opt in
    n) options="$options -n" ;;
    v) options="$options -v" ;;
    *) print_usage ;;
  esac
done
```
- `-n` adds line numbers (`grep -n`).
- `-v` inverts the match (`grep -v`).
- Invalid options trigger the help message.

---

### 4. Shift Processed Options
After option parsing, the script uses `shift` to move positional arguments (pattern and filename) into place:

```bash
shift $((OPTIND-1))
```
This ensures that `$1` becomes the **pattern** and `$2` becomes the **filename**.

---

### 5. Validate Positional Arguments
The script ensures that exactly two positional arguments are provided:

```bash
if [[ $# -ne 2 ]]; then
  echo "Error: pattern and filename are required."
  echo
  print_usage
fi
```
If not, it prints an error and shows the usage instructions.

---

### 6. Assign Pattern and Filename
After validation, it assigns:

```bash
pattern="$1"
filename="$2"
```

---

### 7. Run `grep`
Finally, the script runs `grep`, passing along any collected options:

```bash
grep $options "$pattern" "$filename"
```


---

## Screenshots

  [Screenshots Link](https://drive.google.com/drive/folders/1SEficuy6ZTC4JKv6P66iorcNxDBbte1K?usp=sharing)
---


---

## Summary of Flow

```
Input args -> Check for --help -> Parse -n/-v -> shift -> Validate args -> Assign vars -> Run grep
```

---

## Notes

- `-n` and `-v` can be combined in any order.
- Pattern and filename are always **positional arguments** (required).
- `--help` must be the first argument if used.


##  If you were to support regex or -i/-c/-l options, how would your structure change?

If I were to add support for options like -i (ignore case), -c (count matches), -l (list filenames with matches), or regex patterns, I would expand the getopts string to include those new options (e.g., "nvicl"). Inside the case block, I would simply append the corresponding grep options (-i, -c, -l) to the existing $options variable like I did with -n and -v. Structurally, the script would stay almost the same: parse options with getopts, shift positional arguments after options, and then call grep with all collected flags. However, if supporting complex regex patterns (e.g., extended regex -E), I might also validate the pattern more carefully or allow a special flag like -E to trigger grep -E instead of plain grep.
In short: minimal structural change, just a few more lines inside the case and perhaps slightly more detailed usage instructions.


##  What part of the script was hardest to implement and why?

The hardest part of script to implement was handling option parsing using getopts. Because it had while loop and inside it there is a case to check the options were passed to the script.

