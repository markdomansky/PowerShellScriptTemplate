# PowerShell Script Template

These are plaster templates I use that include most of the parameter definitions and a pre-built comment section that includes synopsis, description and the other sections that I know are supported.

I've tried to describe the various features enough, and the Parameter description is at the bottom so you get to the meat of your scripts faster.

## What's included

### Script template

This is for a script you'll call directly (.\Script.ps1 -param1 X)

There are some directives and variables specific to [WebJEA](http://webjea.com).  If you aren't using WebJEA, the directives won't do anything and the parameters are just parameters.

### Function template

This is for functions in modules.  This is functionally identical to the Script template, but has removed the WebJEA references

I welcome your suggestions/improvements.  Pull requests are welcome.

### License

![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png)

These templates are available under [Creative Commons Zero v1.0 Universal](http://creativecommons.org/publicdomain/zero/1.0/).  _In short, Public Domain, no Guarantees, no Liability._

To the extent possible under law, [Mark Domansky](https://github.com/markdomansky) has waived all copyright and related or neighboring rights to [PowerShell Script Template](https://github.com/markdomansky/PowerShellScriptTemplate).  This work is published from: United States.
