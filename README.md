# Task Fawry Internship : Bash Scripting and Network Troubleshooting

## Task Overview

This project consists of two main parts:

1. **Custom Bash Script (`mygrep.sh`)**:  
   A script similar to `grep` that can search for a string in a text file, with additional options.

2. **Network Troubleshooting**:  
   Investigating and solving DNS problems using Linux commands.

---
## Q1 : Custom Command (mygrep.sh)

You're asked to build a mini version of the grep command. Your script will be called mygrep.sh and must support:
🔹 Basic Functionality
• Search for a string (case-insensitive)
• Print matching lines from a text file
🔹 Command-Line Options:
• -n → Show line numbers for each match
• -v → Invert the match (print lines that do not match)
• Combinations like -vn, -nv should work the same as using -v -n
  
🛠 Technical Requirements:
1.  The script must be executable and accept input as:
2.  It must handle invalid input (e.g., missing file, too few arguments).
3.  Output must mimic grep's style as closely as possible.
  
🧪 Hands-On Validation: You must test your script with the file testfile.txt containing the following:
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
✅ Include:
• Screenshot of your terminal running the script with: 
    ◦ ./mygrep.sh hello testfile.txt
    ◦ ./mygrep.sh -n hello testfile.txt
    ◦ ./mygrep.sh -vn hello testfile.txt
    ◦ ./mygrep.sh -v testfile.txt (expect: script should warn about missing search string)
  
🧠 Reflective Section
In your submission, include:
1.  A breakdown of how your script handles arguments and options.
2.  A short paragraph: If you were to support regex or -i/-c/-l options, how would your structure change?
3.  What part of the script was hardest to implement and why?
  
🏆 Bonus:
• Add support for --help flag to print usage info.
• Improve option parsing using getopts.

## Part 1: Bash Script — `mygrep.sh`

### Features:

- **Basic Search**: Search for a word inside a file (case-insensitive).
- **Options Supported**:
  - `-n`: Show line numbers with the matching lines.
  - `-v`: Show lines that do **not** contain the search word.
  - `--help`: Show help message.
- **Support for combined options** like `-vn`, `-nv`.

---

### Usage:

```bash
./mygrep.sh [options] search_string filename
```

**Examples:**

- Search normally:
  ```bash
  ./mygrep.sh hello myfile.txt
  ```

- Search and show line numbers:
  ```bash
  ./mygrep.sh -n hello myfile.txt
  ```

- Invert match (show non-matching lines):
  ```bash
  ./mygrep.sh -v hello myfile.txt
  ```

- Combined options:
  ```bash
  ./mygrep.sh -vn hello myfile.txt
  ```

- Show help:
  ```bash
  ./mygrep.sh --help
  ```

---
![mygrep](https://github.com/user-attachments/assets/4a2e9287-3e8f-44cf-825b-c8eaee7d6298)

### Testing and Output:

- I tested the script by searching a simple word inside a text file.
- I tried different options `-n`, `-v`, and both combined.
- I also checked that if the search string is missing, the script gives an error.

(Screenshots of the tests are available.)

---
### 🏆 Bonus (Solved):

✅ Implemented a `--help` flag to print usage information.

✅ Improved option parsing using `getopts` for robust handling.

### Reflection:

- **Argument handling**: I checked if the user entered enough arguments.
- **Options parsing**: I handled combined options without using external libraries.
- **Hardest part**: Managing multiple options together was a little tricky.

---

## Part 2: Network Troubleshooting
## Q2 : Scenario

Your internal web dashboard (hosted on internal.example.com) is suddenly unreachable from multiple systems. The service seems up, but users get “host not found” errors. You suspect a DNS or network misconfiguration. Your task is to troubleshoot, verify, and restore connectivity to the internal service.
  
🛠 Your Task:
1.  Verify DNS Resolution:
Compare resolution from /etc/resolv.conf DNS vs. 8.8.8.8.
2.  Diagnose Service Reachability:
Confirm whether the web service (port 80 or 443) is reachable on the resolved IP.
Use curl, telnet, netstat, or ss to find if the service is listening and responding.
3.  Trace the Issue – List All Possible Causes
🧪 Your goal here is to identify and list all potential reasons why [internal.example.com](http://internal.example.com/) might be unreachable, even if the service is up and running. Consider both DNS and network/service layers.
4.  Propose and Apply Fixes
✅ For each potential issue you identified in Point 3, do the following:
1.  Explain how you would confirm it's the actual root cause
2.  Show the exact Linux command(s) you would use to fix it
  
🧠 Note:
Please include screenshots that demonstrate how you identified and resolved the issue 
  
🏆 Bonus:
Configure a local /etc/hosts entry to bypass DNS for testing.
Show how to persist DNS server settings using systemd-resolved or NetworkManager.
### Problem:

- I could not access `internal.example.com`.
- The error message was "host not found".

---

### Steps I Followed:

1. **Checked DNS configuration**:
   ```bash
   cat /etc/resolv.conf
   ```
   ![ping1](https://github.com/user-attachments/assets/ee010386-7604-4863-97a1-7aa8de969e44)

   - Found that DNS was not properly set.

2. **Tested name resolution**:
   ```bash
   nslookup internal.example.com
   nslookup internal.example.com 8.8.8.8
   ```
   - Got `NXDOMAIN` which means the DNS server could not find the domain.
     ![ping2_1](https://github.com/user-attachments/assets/8b6c7a06-5190-4c9c-bd36-7232d65e5ef7)


3. **Checked open ports**:
   ```bash
   ss -tuln
   netstat -tulnp | grep ':22\|:631'
   ```
   - Confirmed that the service was not listening on the expected port.
![ping2](https://github.com/user-attachments/assets/58108452-a3bf-4d3c-95e6-155662c9011a)
---



### Possible Causes:

| Cause | Check |
|:-----|:------|
| Wrong DNS Server | Checked `/etc/resolv.conf` |
| Missing DNS Record | Used `nslookup` |
| Service not Listening | Used `ss` and `netstat` |
| Firewall Issue | Checked `ufw` settings |

---

### Solutions:

| Issue | Fix |
|:-----|:---|
| Wrong DNS server | Updated DNS manually |
| Missing DNS record | Added entry manually or fixed DNS server |
| Service not running | Restarted the service |
| Firewall issue | Allowed needed ports |

Example fix (temporary solution):

```bash
sudo nano /etc/hosts
# Add:
127.0.0.1 internal.example.com
```

Then restart network services:

```bash
### 🏆 Bonus (Solved):

✅ Configured `/etc/hosts` to manually bypass DNS for testing.

✅ Persisted DNS server settings using `systemd-resolved` or `NetworkManager`.
sudo systemctl restart systemd-resolved
```

---


