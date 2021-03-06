# RAC It Up
#### A short tour of ReactiveCocoa with some practical examples

***

# ReactiveCocoa

^3.0 coming which will deprectate some of this
^Work on 3.0 was in progress when Swift was introduced, the new 3.0 will see most reimplemented in Swift, with bridging headers for use from Objective-C

- Functional reactive programming framework for ObjC
- Currently 2.3.1
- Inspired by Reactive Extensions
- Alternative to traditional KVO paradigm / completion block as last argument
- Created by GitHub & used in GitHub for Mac (Hi Coby!)

***

# ReactiveCocoa

^Macros help with short-handing common patterns as we'll see

^Categories on existing classes, including UIKit

^Signals conform to ARC etc

- Handy macros
- Handy categories
- Good memory management semantics
- Tuples!

***

# ReactiveCocoa is good for you :+1:

- Handle asynchronous / event-driven data sources
- Chain dependent operations
- Parallelise independent work
- Simplify collection transformations
- Manage and minimise state

***

# Our Example

^ We'll build a simple login form with validation and show how the UI can respond dynamically to user input, then submit the form via a network request.

- Login form
- Field validation
- Dynamic UI
- Network request

****

# RACSignal

Represents an event source, or stream of values delivered over time.

Three types of event:

  * Next (Value)
  * Error
  * Completed

***

# Subscription (1)

^ Mention `subscribeNext:`
^ Discouraged to explicitly subscribe - use `RAC` macro
^ Wide selection of operators that often can accomplish what you want instead

Each event for a signal is delivered to its subscribers.

Most often used is `subscribeNext:`

It takes a block which is executed for every value received

***

# Subscription (1)

^ UIKit is mostly not KVO compliant, `RAObserve`ing the `text` property on `UITextField` won't work

This is like KVO but for common UIKit elements!

ReactiveCocoa provides categories to help like `rac_textSignal` for `UITextField`

Let's see how this works...

^ tag: 1

***

# Operations (2)

^ Form validation

^ Signals are lazy (or cold), so you can compose everything before running it

Lots of signal operations available (`map`, `filter`, `skip`, `take`, `ignore`, `collect`, to name a few)

We can use `map:` to help with form validation

***

# Operations (2)

^ Map takes a transformation block which is applied to each value sent on the signal
^ In our example we'll examine the content of the email text field and map it to a BOOL representing its validity

Map `NSString` to an `NSNumber` representing a `BOOL`

- UI state management
- User feedback
- Compact logic

***

# Macros (2)

^ RAC is a shortcut macro which allows updating a property on an object with values sent on a signal
^ RACObserve performs KVO on a property and returns a signal of all values resulting from property changes

Macros like `RAC()` are handy shortcuts for UI state management

Logic automatically updates UI

Like CocoaBindings for iOS and Mac

^ tag: 2

***

# Combining Signals (3)

But what about validating the form as a whole?

The operator `combineLatest:reduce:` helps

***

# Combining with tuples (3)

^ `combineLatest:` takes an array of inputs signals, and returns a signal that when any input signal sends a value sends a tuple containing the latest value sent by each.
^ Could use `map:` and receive and unpack a tuple to operate on.
^ This is a common use case though, `combineLatest:reduce:` will take a block with as many arguments as input signals

The `combineLatest:` operator takes an array of signals
So, `reduce:` maps a tuple to block arguments

^ tag: 3

***

# Logical Operators (4)

Combined validation is a common pattern

ReactiveCocoa offers methods for boolean signals

Let's rewrite our form validation...

***

# Moar Logic (4)

^ if:then:else 

ReactiveCocoa offers lots of logic as signals

- and
- or
- not
- switch:cases:default:
- if:then:else:

^ tag: 4

***

# Target:selector pattern is for the bin (5)

^Ok, so notification center has blocks but still...

- UIControlEvent

  `[UIControl rac_signalForControlEvents:]`

- RACCommand

  `UIButton`, `UIBarButtonItem`, `UIRefreshControl`, `rac_command` property

***

# Other categories / alternatives (5)

- Timers

  `[RACSignal interval:onScheduler:]`
  `[RACSignal delay:]`

- NSNotificationCenter

  `[NSNotificationCenter rac_addObserverForName:object:]`

- `@weakify` / `@strongify` macros are helpful

***

# Don't retain your delegates, release yourself now (5)

^Many more available, e.g. action sheets
^We'll probably get a solution for the return-value-delegate-type issue in 3.0

For example:

- UIGestureRecogniser (`rac_gestureSignal`)
- UIAlertView (`rac_buttonClickedSignal`)
- Note: can't be used if delegate method returns a value :pensive:

^ tag: 5

***

# The chain will keep us together (6)

^Or a background process that must write files, delete duplicates and then upload

Chaining dependent, asynchronous operations allows for streamlining complex tasks

E.g. a network operation that needs to do a number of fetches

^ tag: 6

***

# Disposables (7)

^ Disposables are related to subscriptions
^ They encapsulate any clean-up necessary when a signal is being torn down (through error, completion or unsubscription)
^ From the previous examples, removing KVO or notification observers added.
^ A signal delivering the results of a network request would cancel the request

A subscription wraps a number of disposables

Can be useful for cancelling any ongoing work.

E.g. cancelling an ongoing network request.

^ tag: 7

***

# Sequences

^ Underscore AND RAC - Why not use both?

- Some other libs provide collection operations, e.g. Underscore
- Working with signals allows for chaining though
- Filtering, mapping etc.
- Collections are treated as streams
- Lazily executed

***

# Downsides

^Timers: the timing aspect seems well suited but not for precision

Some places, ReactiveCocoa doesn't offer **huge** benefit as it requires additonal management

E.g. table view cell reuse & timers

And no Swift support... yet.


***

# Extensions

^ Many efforts to bring existing frameworks into the reactive world, replacing delegates with signals, etc

^ Core Data - ReactiveCoreData
^ HTTP client - AFNetworking-RACExtensions
^ ReactiveCocoaLayout - A work in progress with an interesting approach / alternative to auto layout, using signals and operations to express layout changes, animations etc

- HTTP (AFNetworking-RACExtensions)
- Core Data (ReactiveCoreData)
- Core Bluetooth (ReactiveCoreBluetooth)
- Layout (ReactiveCocoaLayout)

[And Many More...](http://cocoapods.org/?q=reactive)

***

# That's all folks

#### Feel free to get in touch!
#### @ominiom
#### @imnk
