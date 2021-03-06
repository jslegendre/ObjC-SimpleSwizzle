# ObjC-BlockSwizzle
A much smaller/streamlined way of method swizzling exampled by calling an NSUSerNotification from a CLI app.

**Why?**

I was taking a look at some of the other projects here on github of the ways people were swizzling objective-c methods, namely in the NSUserNotification space.  Every project I could find was (comparitively) massive for what seemed to be a relatively simple task.  Sometimes you only need to swizzle one method in an entire project and adding another project seemed extravagant to say the least. I also eventually wanted to port this functionality to a C(++) application and the set up for that seemed (again), extravagant. It would have required setting up an objective-c method, an implemenation segment, registering a selector, accessing that selector for the method exchange function.... You see where I am going with this.

**How**

I started out by stripping out everything I knew to be not completely necessary as well as consolodating as much as I could into `main`.  I eventually ended up with `main` and one separate method for the swizzle. Still not solving my originial problem... So I started reading anything I could find on the Objective-C runtime until I stumbled across "blocks". A block is, as Apple puts it "a language-level feature added to C, Objective-C and C++, which allow you to create distinct segments of code that can be passed around to methods or functions as if they were values". I will post some further reading that I used the bottom where the authors offer explanations in in much more detail than I could get into here. Using this information I was able to, instead of swizzle an entire method, swizzle solely the block of the original method with my own.   

**Result**

First off, I do not want to go into what is more "safe" or better as this was not the point of the excersise nor am I the most qualified person to address this issue so I will stay away from it.  I will say that not only was I able to condense this functionality to one single function, I was able to drop the code base of [Norio Nomuras CLI example](https://github.com/norio-nomura/usernotification) by about 75% (from ~80 lines to ~20 lines).  I was also able to disassemble this in Hopper and re-write this in C quite easily and pretty much just a succinctly as done here (will post that project at a later time). 

I have also looked around to see if any one else has done/used this method for swizzling and could not find any results. This is either really cool or REALLY bad.  Take that information with you should you decide to use this in a project.

**Further Reading**
https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html

https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40007502

http://alexanderyolkin.com/display-user-notification-cocoa/

http://nshipster.com/method-swizzling/

http://www.galloway.me.uk/2012/10/a-look-inside-blocks-episode-1/ 

http://www.friday.com/bbum/2011/03/17/ios-4-3-imp_implementationwithblock/

http://www.cocoawithlove.com/2008/02/imp-of-current-method.html

https://blog.newrelic.com/2014/04/16/right-way-to-swizzle/
