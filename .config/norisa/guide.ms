.nr PS 13000
.TL
Guide of NoRiSA (Noah's Ricing Script for Arch Linux)
.AU
Noah Vogt

.SH
Introduction
.PP
Welcome to this Guide! This is my personal configuration of a
.I "simple, extensible, decentralized, lightweight and vimkey-centric System."
The aim is to find the balance between using as little resources while also being functional and somewhat goodlooking. I am constantly changing this configuration to come closer to my vision.

.SH
How To Revisit This Document
.PP
If you are running NoRiSA, then you can get back to this Guide everytime when you press 
.CW "Mod4+F4."
Note that 
.CW "Mod4"
refers to the key you may know as 
.CW "Windows Key, Super Key "
or
.CW " Command. "
This Guide - including the source file - are located in 
.I "$HOME/.config/norisa/."

.SH
General Keyboard Changes
.PP
The only keys I have changed are the 
.I "Caps Lock"
and 
.I "Escape Key"
: I swapped them. As a heavy vim user, this makes much more sense, saves me a lot of time and brings some convinience with it. If you actually tried this, I can guarantee you will 
.I "never "
want to go back to your traditional keyboard setup.

.SH
Macros
.PP
The efficiency of this system lives from all the handy keyboard shortcuts listed in the following. I sorted them in categories by use:

.RS
.SH 2
Window Management (powered by dwm)
.IP \(bu 2
.CW "Mod4+Shift+C"
\t  Close the current window
.IP \(bu 2
.CW "Mod4+Enter"
\t  Toggle master window
.IP \(bu 2
.CW "Mod4+H"
\t  Make the master area smaller
.IP \(bu 2
.CW "Mod4+L"
\t  Make the master area bigger
.IP \(bu 2
.CW "Mod4+[1-9]"
\t  Change to / select tag [1-9]. This displays the content of this specifig tag.
.IP \(bu 2
.CW "Shift+Mod4+[1-9]"
\t  Move the selected window to tag [1-9]
.IP \(bu 2
.CW "Mod4+0"
\t  Change to / select 
.I "all "
tags. This displays the content of 
.I "all "
tags.
.IP \(bu 2
.CW "Mod4+Tab"
\t  Jump to the last used tag
.IP \(bu 2
.CW "Shift+Mod4+Space"
\t  Toggle releasing a windows from the tiling layout
.IP \(bu 2
.CW "Mod4+Space"
\t  Cycle between layouts
.IP \(bu 2
.CW "Mod4+T"
\t  Change to tiling layout
.IP \(bu 2
.CW "Mod4+F"
\t  Change to floating layout
.IP \(bu 2
.CW "Mod4+M"
\t  Change to monocle layout
.IP \(bu 2
.CW "Mod4+I"
\t  Increase the amount of windows in the master area
.IP \(bu 2
.CW "Mod4+D"
\t  Decrease the amount of windows in the master area
.IP \(bu 2
.CW "Mod4+J"
\t  Change to the window down the stack
.IP \(bu 2
.CW "Mod4+K"
\t  Change to the window up the stack
.IP \(bu 2
.CW "Mod4+B"
\t  Toggle the visibiliy of the bar
.RE
