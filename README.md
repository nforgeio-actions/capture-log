# neon-log-file

**INTERNAL USE ONLY:** This GitHub action is not intended for general use.  The only reason why this repo is public is because GitHub requires it.

Copies a text file to the GitHub action output, optionally nesting it within an expandable group

## Examples

**Copy a file into the log without nesting it within an expandable group:**
```
uses: nforgeio-actions/neon-log-file@master
with:
  path: "myfile.txt"
```

**Copy a file into the log without nesting it within the "build.log" expandable group:**
```
uses: nforgeio-actions/neon-log-file@master
with:
  path: "myfile.txt"
  group: "build.log"
```
