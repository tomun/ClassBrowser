# ClassBrowser

[![Gem Version][GV img]][Gem Version]
[![Build Status][BS img]][Build Status]
[![Dependency Status][DS img]][Dependency Status]
[![Code Climate][CC img]][Code Climate]
[![Coverage Status][CS img]][Coverage Status]

## Description

ClassBrowser is an interactive ruby class browser.   

## Usage
ClassBrowser can be invoked with command line arguments or, if no arguments are specified, ClassBrowser will enter its interactive mode.   In interactive mode you may enter the same arguments as from the command line repeatedly.   Enter a blank line to exit interactive mode and the program.

Usage: ClassBrowser \[class\] \[switches\]

'class' is a Class or Module name

'switches' may be:  
&nbsp;&nbsp;-h:   show help  
&nbsp;&nbsp;-da:  show all descendants of this class  
&nbsp;&nbsp;-di:  show the immediate descendants of this class  
&nbsp;&nbsp;-dn:  do not show the descendants of this class  
&nbsp;&nbsp;-m:   show the Modules included by this Class or Module  
&nbsp;&nbsp;-ma:  show all methods of this Class or Module  
&nbsp;&nbsp;-mi:  show the instance methods of this Class  
&nbsp;&nbsp;-mc:  show the class methods of this Class  
&nbsp;&nbsp;-mn:  do not show any methods of this Class or Module  

## Command Line Example

  $ ClassBrowser Array  
  ○ BasicObject  
  └─○ Object  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─○ Array  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─○ CGI::Cookie  

## Interactive Mode

In interactive mode, the prompt shows the current Class or Module.  Entering a Class or Module name and pressing enter will change the prompt to the new current Class or Module.   If you enter an invalid name, you will change to \*Unknown class\*\>.   When switching to a class in interactive mode, information about this class will be displayed depending on the current switches.   Entering just switches and no class name willredisplay information about the current class using the new switches.

## Interactive Example

  $ ClassBrowser  
    
  Object> Array  
    
  ○ BasicObject  
  └─○ Object  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─○ Array  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─○ CGI::Cookie  
    
  Array> -dn -mc  
  ○ BasicObject  
  └─○ Object  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─○ Array  
    
  ::[]                      
  ::try_convert  
    
  Array> 

[Gem Version]: https://rubygems.org/gems/ClassBrowser
[Build Status]: https://travis-ci.org/tomun/ClassBrowser
[travis pull requests]: https://travis-ci.org/tomun/ClassBrowser/pull_requests
[Dependency Status]: https://gemnasium.com/tomun/ClassBrowser
[Code Climate]: https://codeclimate.com/repos/5486124de30ba079230050ca/feed
[Coverage Status]: https://codeclimate.com/repos/5486124de30ba079230050ca/feed

[GV img]: https://badge.fury.io/rb/ClassBrowser.png
[BS img]: https://travis-ci.org/tomun/ClassBrowser.png
[DS img]: https://gemnasium.com/tomun/ClassBrowser.png
[CC img]: https://codeclimate.com/repos/5486124de30ba079230050ca/badges/b374b21eb9741352f3b9/gpa.svg
[CS img]: https://codeclimate.com/repos/5486124de30ba079230050ca/badges/b374b21eb9741352f3b9/coverage.svg
