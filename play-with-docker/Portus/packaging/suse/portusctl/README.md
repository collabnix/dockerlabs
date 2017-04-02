# portusctl

`portusctl` is the tool that is provided to RPM users in order to easily
configure and perform operations on Portus installations. `portusctl` re-uses
part of Portus' infrastructure, and thus it made sense to keep it in the same
repository, and to write it in Ruby as well (at least for now that it's not too
big or unmaintainable this way).

All the commands are defined in the `lib/cli.rb` file, and the rest of the files
are mere helpers.

## man

Documentation for `portusctl` comes in the form of UNIX manual pages. They can
be found inside of the `man` directory. In this directory, there are two
subdirectories:

- `markdown`: the files that developers use to write the documentation.
- `man1`: the manual pages that should be installed in the system.

As you can see, we use regular Markdown files to edit manual pages. This is
possible thanks to the `md2man` gem. In order to generate the resulting man
pages inside of the `man/man1` directory, you have to execute:

```
$ rake portus:generate_man_pages
```

Note that this should be done by developers. Packagers should only have to care
about the files inside of `man/man1` and disregard the markdown files completely.
