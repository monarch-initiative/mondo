## Issue templates

These issue templates are intended to be programmatically instantiated as markdown and then used as the issue text payload when creating a new issue.

For example, this command instantiates the issue template using a JSON file.

```
jinjanate monogenic_ntr.md.j2 tests/issue9963.json -o tests/issue9963.md
```