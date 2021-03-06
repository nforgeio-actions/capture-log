# capture-log

**INTERNAL USE ONLY:** This GitHub action is not intended for general use.  The only reason why this repo is public is because GitHub requires it.

Copies a text file to the GitHub action output, optionally nesting it within an expandable group and highlighting errors and warnings.

**NOTE:** This action does nothing when the source file doesn't exist.  This makes the action suitable for executing when previous steps have failed without having to do complex checks to avoid capturing non-existent log files.

## Examples:

**Append a file to the action log without nesting it within an expandable group:**
```
uses: nforgeio-actions/capture-log@master
with:
  path: ${{ github.workspace }}/build.log
```

**Append a file to the action log, nesting it within an expandable group:**
```
uses: nforgeio-actions/capture-log@master
with:
  path: ${{ github.workspace }}/build.log
  group: build.log
```

**Append a build log to the action log, parsing and coloring it as well as nesting it within an expandable group:**
```
uses: nforgeio-actions/capture-log@master
with:
  path: ${{ github.workspace }}/build.log
  type: build-log
  group: build.log
```

**neonFORGE: Build code and fail the capture step for build errors**

```
steps:
- id: build
  uses: nforgeio-actions/build
  with:
    repo: neonFORGE
    build-log-path: ${{ github.workspace }}/build.log
    fail-on-error: true
- uses: nforgeio-actions/capture-log
  if: ${{ always() }}
  with:
    path: ${{ github.workspace }}/build.log
    group: build.log
    type: build-log
    fail-on-error: ${{ steps.build.outputs.success }}
```
