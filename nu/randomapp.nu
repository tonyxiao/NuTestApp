;; randomapp.nu
;;  Aaron Hillegass' RandomApp example, completely Nu-ed.
;;
;;  Copyright (c) 2007 Tim Burks, Radtastical Inc.

;; create a standard button
(function standard-cocoa-button (frame)
     (((NSButton alloc) initWithFrame:frame)
      set: (bezelStyle:NSRoundedBezelStyle)))

;; create a standard textfield
(function standard-cocoa-textfield (frame)
     (((NSTextField alloc) initWithFrame:frame)
      set: (bezeled:0 editable:0 alignment:NSCenterTextAlignment drawsBackground:0)))

;; define the window controller class
(class RandomAppWindowController is NSObject     
     (- (id) init is
          (super init)
          (let (w ((NSWindow alloc)
                   initWithContentRect: '(300 200 340 120)
                   styleMask: (+ NSTitledWindowMask NSClosableWindowMask NSMiniaturizableWindowMask)
                   backing: NSBackingStoreBuffered
                   defer: 0))
               (w set: (title:"Random App"))
               (let (v ((NSView alloc) initWithFrame:(w frame)))
                    (let (b (standard-cocoa-button '(20 75 300 25)))
                         (b set: (title: "Seed random number generator with time" target: self action:"seed:"))
                         (v addSubview:b)
                         (set @seedButton b))
                    (let (b (standard-cocoa-button '(20 45 300 25)))
                         (b set: (title: "Generate random number" target: self action:"generate:"))
                         (v addSubview:b)
                         (set @generateButton b))
                    (let (t (standard-cocoa-textfield '(20 20 300 20)))
                         (t setObjectValue:(NSCalendarDate calendarDate))
                         (v addSubview:t)
                         (set @textField t))
                    (w setContentView:v))
               (w center)
               (set @window w)
               (w makeKeyAndOrderFront:self))
          self)
     
     (- (void) seed: (id) sender is
          (NuMath srandom:((NSCalendarDate calendarDate) timeIntervalSince1970))
          (@textField setStringValue:"generator seeded"))
     
     (- (void) generate: (id) sender is
          (@textField setIntValue:(NuMath random))))
