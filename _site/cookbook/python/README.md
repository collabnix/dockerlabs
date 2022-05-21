# Hands-on with Python

[Installing Python3 on Ubuntu 18.04]()<br>
[Writing Your first Hello World Program]()<br>
[Python Indentations]()<br>
[Python Variables]()<br>
[Multi-Line Comments]()<br>
[String Variables]()<br>



## Installing Python3 on Ubuntu 18.04

```
apt install python3
```

Quick Way:

```
docker pull python:3.6
```


## Writing Hello World Example in Python

Create a file called "helloworld.py" and add the below contents:

```
root@ubuntu1804-1:~/cookbook# cat helloworld.py
#!/usr/bin/python3
print ("Hello,World")
```

Save the file and run the python script:

```
root@ubuntu1804-1:~/cookbook# python3 helloworld.py
Hello,World
```

## Python Indentations

Where in other programming languages the indentation in code is for readability only, in Python the indentation is very important.
Python uses indentation to indicate a block of code.

```
root@ubuntu1804-1:~/cookbook# cat tryindentation.py
if 5 > 2:
  print ("Five is greater than two!")
```

```
root@ubuntu1804-1:~/cookbook# python3 tryindentation.py
Five is greater than two!
```

Que: What will be the output for the below code:

```
if 5 > 2:
print("Five is greater than two!")
```

It will generate error. Let us try it out:

```
root@ubuntu1804-1:~/cookbook# cat tryindentation_error.py
if 5 > 2:
print ("Five is greater than two!")
```

## Output:

```
root@ubuntu1804-1:~/cookbook# python3 tryindentation_error.py
  File "tryindentation_error.py", line 2
    print ("Five is greater than two!")
        ^
IndentationError: expected an indented block
```


## Python Variables

```
root@ubuntu1804-1:~/cookbook# cat variables.py
x = 5
y = "Hello, World!"

print(x)
print(y)
```

```
root@ubuntu1804-1:~/cookbook# python3 variables.py
5
Hello, World!
```

## What will be the below output show?

```
root@ubuntu1804-1:~/cookbook# cat variables.py
x = 5
y = "Hello, World!"

print(x)
print(x,y)
print(y)
```

```
 python3 variables.py
5
5 Hello, World!
Hello, World!
```

## Multi-Line Comments

```
"""
This is a comment
written in 
more than just one line
"""
print("Hello, World!")
```

```
C:\Users\My Name>python demo_comment5.py
Hello, World!
```

## String Variables

String variables can be declared either by using single or double quotes:

```
x = "John"
# is the same as
x = 'John'
```

## Assign Value to Multiple Variables

Python allows you to assign values to multiple variables in one line:

```
x, y, z = "Orange", "Banana", "Cherry"
print(x)
print(y)
print(z)
```

```
C:\Users\My Name>python demo_variables8.py
Orange
Banana
Cherry
```

##  Assigning the same value to multiple variables in one line

```
x = y = z = "Orange"
print(x)
print(y)
print(z)
```

```
C:\Users\My Name>python demo_variables6.py
Orange
Orange
Orange
```

## 

## 

## 



