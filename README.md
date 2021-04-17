# neon-log-file

**INTERNAL USE ONLY:** This GitHub action is not intended for general use.  The only reason why this repo is public is because GitHub requires it.

Copies a text file to the GitHub action output, optionally nesting it within an expandable group 

## Examples:

**Append a file to the action log without nesting it within an expandable group:**
```
uses: nforgeio-actions@master
with:
  path: ${{ github.workspace }}/build.log
```

**Append a file to the action log nesting it within an expandable group:**
```
uses: nforgeio-actions@master
with:
  path: ${{ github.workspace }}/build.log
  group-title: build.log
```

