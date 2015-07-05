# RRGif
A Swift script which allows you to encode an animated gif.

Scripting in Swift
==================

First add a Shebang in the .swift file:

```Shell
#!/usr/bin/swift
```

This line essentially launches the swift REPL first so that rest of your file actually compiles in a swift environment.

The cool part with scripting in Swift is that you can even import frameworks like Foundation as well. Anything you can do with Foundation, you can put into a script. This includes File I/O, string manipulation, and more.

swiftc
======

you could also use the swift compiler in Terminal, swiftc (only as of Xcode 6.1 and on Yosemite), to compile your swift files into an executable binary. 

```Shell
swiftc RRGif.swift -o gif
```

Next you can move the binary, to use it like a command everywhere.
```Shell
sudo cp gif /usr/bin
```

How to use RRGif
================
```Shell
./RRGif.swift --images *.png --delay 1
```
