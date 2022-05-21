# LABEL Instruction <br>
You can add labels to your image to help organize images by project, record licensing information, to aid in automation, or for other reasons. For each label, add a line beginning with LABEL and with one or more key-value pairs. The following examples show the different acceptable formats.<br>
Docker offers support to add labels into images as a way to add custom metadata on them.<br>
The label syntax on your Dockerfile is as follows: <br>
```
LABEL <key>=<value> <key>=<value> <key>=<value> ...
```
The LABEL instruction adds metadata to an image. A LABEL is a key-value pair. To include spaces within a LABEL value, use quotes and backslashes as you would in command-line parsing. A few usage examples:
```
LABEL "com.example.vendor"="ACME Incorporated"
LABEL com.example.label-with-value="foo"
LABEL version="1.0"
LABEL description="This text illustrates \
that label-values can span multiple lines."
```
An image can have more than one label. You can specify multiple labels on a single line. Prior to Docker 1.10, this decreased the size of the final image, but this is no longer the case. You may still choose to specify multiple labels in a single instruction, in one of the following two ways:
```
LABEL multi.label1="value1" multi.label2="value2" other="value3"
``` 
```
LABEL multi.label1="value1" \
      multi.label2="value2" \
      other="value3"
```
Labels included in base or parent images (images in the FROM line) are inherited by your image. If a label already exists but with a different value, the most-recently-applied value overrides any previously-set value.

To view an image’s labels, use the ```docker inspect``` command.
```
"Labels": {
    "com.example.vendor": "ACME Incorporated"
    "com.example.label-with-value": "foo",
    "version": "1.0",
    "description": "This text illustrates that label-values can span multiple lines.",
    "multi.label1": "value1",
    "multi.label2": "value2",
    "other": "value3"
},
```

Next >> [Lab #13: ONBUILD instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/onbuild.html) 
