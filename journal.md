# Platform 17 Development Progress

## April 5, 2017

## Overview

I've been occupied with packing and other work, but I updated README.md to reflect current status. 

## March 30, 2017

### Overview

Not much time due to shenanigans, but I managed to work on a few things.

- Finished basic user creation and authentication
- Enforced HTTPS redirect
- Implemented some basic global commands (LOOK, SAY, MEOW (super important command))
- Implemented some special room commands
- Wrote chargen room, implemented character creation

### User Creation and Authentication

- For people with basically no knowledge about the authentication process like me ("Session? What's a session?"), there is a surprisingly lack of introductory materials. There are many things that deal with specific issues ("How to access session data on the client?"), but what I really needed was a super basic overview of all the components, best practices and just generally what to consider. In this I was much more reluctant to improvise than in other tasks, since it's security related. Really just a check list like "hash your password server-side, use SSL connection, pass credentials: 'includes' in your data" would have really helped
- The front-end now keeps a global "me" object, to store the user information that the client needs to access. I know everyone loves to hate on global variables, but they exist and there are good cases for using them!
- I will probably write my own basic guide for this after catching up with code comments and documentation

### Enforced HTTPS Redirect

- I learned that the manage.py runserver process doesn't allow HTTPS connection. This was rather non-obvious and not really documented anywhere, so it took much longer to debug than it should be. On production, there's a setting variable I could set to True. For now, heroku took care of the SSL certificate

### Commands Dispatching and Responses

- Some of the special-rooms modified the global commands (like SAY), and did so by first calling them. At some point I realized that this was like inheritance. Am I writing an object-oriented framework from scratch...?
- Speaking of object-oriented, how do the front-end JS and back-end Python interact with each other when dealing with the same objects...?  

### Chargen

- Characters (players) are tied to user accounts right now, in a one-to-one fashion. But the field is just a foreign key to allow players to have more characters later
- From an engine standpoint, I may need a more generic chargen room object

### To Do Next

- Separate production and dev environments / branches
- Automatically log user out when browswer is closed
- Log users in at their last location
- Make login its own separate view and url in url dispatcher
- Set @login_require's redirect to a custom re-authentication view
- Redirect to login view after logout
- Standardize input and output processing, design which steps in the process they get trimmed, formatted. Maybe make dialogues its own getting-ready function. Refactor this section of the code
- Move functions around into appropriate apps with proper separation
- Catch up on function commands and in-line documentation (much JS to comment on )
- Write basic guide for user authentication and sessions
- Figure out how to design the object-oriented-ness of items, how to store them, and how they interact back- and front-end
- Preload the normal room script, put it in the command dispatcher queue
- Maybe debug staticfiles serving
- Look up server pushing to client and race conditions
- Think about this more from an engine standpoint: how to divide code and allow for a lot of customization?
- Write Bertrand Russell Markov generator

## March 28, 2017

### Overview

- Further fleshed out the terminal interface (I think it's fairly complete now)
- Made input fields with password masking
- Refactored different functions into their own apps (with exceptions)
- Did something with static files serving
- Looked into user authentication
- Verb functions, and potentially verb objects
- Wrote a bunch of check functions for the login room

### Terminal Interface

- Changed readLine(): it now takes 2 optinal arguments (input = null, check = () => {return true;})
    - The check function is changed to return not a boolean value but an object of two properties:
        - is_valid: whether the input is valid
        - retry_msg: the retry message to print if the input is not valid. This is because an input can fail in different ways
- Implemented delayedWriteLine(): takes an optional argument (delay). Write something to the terimnal after a delay

### Password Masking

- This was just more concurrency issue -- the function readPassword() has to turn the input field into a password field, get blocked on readLine(), and then turn it back to text afterward

### Refactored Functions and Apps

- In the interest of making modular apps, I assigned functions to the .js files they should be. Right now the only apps are terminal and generics 
- The terminal app now has the document.read() stuff in it, and also a loadRoom() function, which is not directly related to the terminal. I'm thinking the URL dispatcher should direct "/" to somewhere else, and have that place import the terminal app. A 'game' app?

### Static files

- As I'm working with apps in the same projects that interact with each other, I'm trying to figure out how to serve static files. Somehow the STATIC_URL thing is not working, at the moment I have to just prepend /static to my file linking
- STATICFILES_DIR does seem to be working though

### User Authentication

- I set up most things related to user authentication, except for the important part of actually transmitting the data
- It seems industry standard is server-side hashing
- I have yet to figure out how to enforce HTTPS connection, but I have some leads
- Also how to transfer authorization token safely? Somehow very basic information on this is surprisingly hard to find. Gotta ask Taymon 

### Verb Functions

Verbs are like commands (LOOK, TAKE, etc.)

- At the moment, I've decided that all verb functions are implemented with their function names being "verb_", followed by the verb
- All basic verbs are one word, and the object can check the verb with its code to decide whether it supports the whole query
- I'm thinking maybe I'll have to have a "verb" object as the superclass for all verbs. This object should support being asked whether it understands an entire command ("STAB MONSTER WITH SWORD")

### To Do Next

- Finish server call functions for authentication stuff (check existing usernames, send pairs of username and password to authenticate...)
- Enforce HTTPS redirect
- Maybe debug staticfiles serving
- Implement Django authentication
- Look up server pushing to client and race conditions
- Write Bertrand Russell Markov generator

## March 27, 2017

### Overivew

Lots of things happened! I've been occupied with a few urgent personal things and haven't had time to work on much at all, but I made some progress here and there in the last few days.

I completed these TODOs and took notes on some of them:

- Studied promises, generators, async/await; was told I still needed to look at lodash and closure
    - Used them in my code!
- Studied the fetch API
    - Used this too
- Made input text field bigger
- Created a dedicated div for text output
    - It's a div element, id 'terminal-output'
- Debugged scrolling issue
    - I wanted 'scrollHeight' instead of 'height'
    - There are also generally issues where I confused or didn't pay much attention to which were applicable in jQuery vs Javascript
- Implemented the command dispatcher, completely! (kinda)
- Changed function names to more friendly names
    - readLine, writeLine, etc. instead of the harder-to-guess getInput and printToTerminal
- Designed and implemented the API for the terminal (sort of)
    - writeLine(string): print a line to the end of the terminal
    - readLine(string, function = () => {return true}, retry_msg = "Invalid. Try again."): read an input and if the input doesn't satisfy the conditions checked by the function, then print the retry_msg an wait for the input again
        - I actually don't like this implementation of the retry_msg. An input could fail to satisfy the conditions of the requirement in several ways, so the check function should produce the retry_msg
    - readLineAndResponse(string): generally called by the form on submit event. Takes the input, pass it to the command dispatcher to give to things that requested the input, in order
- Loaded room js dynamically and load it into current_room variable
    - Debugged current_room_script in loadRoom()
        - This turned out to be a parallelism issue. The loadRoom() function made a call to the server, get the link to the room script, append it to 'head' in the HTML file, and then assign current_room_script to the new global variable loaded from that script
        - But due to parallelism (or lack of, I think?), the new script wasn't loaded until the function finished executed
        - So I added an event listener (script.onload) to do this variable assignment once the script has finished loading
- Displayed past inputs
    - Incorporated into writeLine()

### Singleplayer vs. Multiplayer

I've been thinking about whether to work toward multiplayer right away, or just with singleplayer and support multiplayer later. Due to potential database design issues I'm seeing with shared vs. private spaces in the game and user authentication, it seems to make sense to support multiplayers right off the bat. Plus I'm sure it will be a great learning experience.

### To Do Next
- Comment my code, functions, and may as well ES6-fy it (I was told there is an ES6 to ES5 translator)
- Redo how readLine() works
- Pre-load 'normalroom', check if a room uses 'normalroom', and connect it 
- Implement readPassword() method to not show password on the screen
- Write server call functions for authentication stuff (check existing usernames, send pairs of username and password to authenticate...)
- Debug concurrency issues with setTimeout in login.js
- Implement Django authentication
- Look up server pushing to client and race conditions
- Write Bertrand Russell Markov generator


## March 22, 2017

### Overview

- Thought about two preliminary base mechanics
    - Player item creation
    - Skill cards
- Probably not the most urgent thing to do at the moment, but good to have an idea before building the infrastructure for it

### Player Item Creation

#### Goals

- Flexible with a low learning curve
- Leverage the ease of creation of a text-based system
- Inspiration: Scribblenauts, Minecraft

#### Implementation

##### Level System

Options I considered for a level system:

- No level, everyone has equal mechanical ability to create powerful items
- Point-buy system, items can have abilities and features up to a certain number of point-buy for the level
- Descriptor system, items can have a up to a number of descriptors for the level, where each descriptor grants some benefits or special ability to the item

##### Item Creation

- Each item is created with: a noun, any number of descriptors, and an optional material component
- **Noun:** the noun puts the item in the basic class of objects. This can be done by the player mannually tagging the item as an object of an existing class, or an automatic tagging system
- **Descriptors:** descriptors modify the item in meaningful way. There can be many types of descriptors, e.g. color, size, material. Effects can range from reactions of certain NPCs who like or dislike it, to environment-changing abilities. The effects of the descriptors may not be apparent, and may be figured out by observing existing objects. Still, the only requirement for creating an object with a certain effects is putting the right descriptor in its name (deliberately or accidentally)
- **Material component:** when fused with the object, it gives the object very special abilities. E.g fusing a mask with a sword may make the sword invisible and can only be seen by its creator. The effect of fusion may not be apparent

### Skill Cards

This is a system I created and used for a one-shot Christmas Special with my FATE tabletop group. It was surprisingly popular, fun and complex. 

#### Goals

- A lot of emergent complexity, but with a good learning curve (not very many options in the beginning, availability of options are introduced slowly so as not to be overwhelming)
- Limited ability for long-time players to hurt new players
- Limited rewards for 1 vs. 1, encourage tactical teamwork play
- Inspiration: Etrian Odyssey, deck building games

#### Implementation

- There are many skill cards in game
    - Skill cards can be related to combat abilities (e.g hit harder, hit with elements)
    - Or can be related status (e.g more hitpoint, faster initiative)
    - Or can be related to battlefield control and tactics (e.g status effects, buffs and debuffs...)
    - Or can be a utility (e.g. unlock doors)
    - [Example of combat cards, from that tabletop game](https://docs.google.com/document/d/1NmjNnMpAYCgTNuovuN1POb5IOu9MqszoCt30blWr5qA/edit)
- Each player start with 10HP, and this number almost never changes
- Each player has 5 active card slots
- Each kind of attack does 1 damage
    - This number can be changed during combat, but never by more than 1
    - So in effect, an attack during combat can deal 0-2 damage
- On each player's turn, they take one action
- There are elements that interact with each other: water > fire > earth > lightning > water
- I may also implement a simple spatial system to encourage more tactics, although I haven't thought about how yet
- Many (most?) cards interact with "teammates" rather than self
- Turn order determined by an initiative roll (players can have card that increases their initiative, but this takes one card slot)
- Later on, can also use a class system

#### Effects

- With 10HP and the ability to deal 0-2 damage each turn, and limited card synergy with self, 1v1 is hopefully not as interesting or deadly (any player can escape if they want)
- But team vs. team (e.g 4v4) can be interesting

## March 18, 2017

### Overview

- Designed the command dispatcher

### Command Dispatcher

When a command is inputed, the command dispatcher would pass it through several command layers in the following order
- Top-level commands: the non-overridable commands of the system (e.g HELP, QUIT, REPORT...)
- Room-level commands: commands understood by the room the user is in. This could be the typical command set for a normal room, or a special room, or a scripted room --- depending on the room
- Item-level commands: all the items are checked in a specific matching order to see if any of the items supports the command
- Global commands: commands that are generally applicable regardless of where the user is, e.g. LOOK, SMILE, GIVE object TO person


### The Item Layer

Them item layer checks items in the order established by the item matcher (items the user is wielding, then items in the user's inventory, then items in the room, then items of other users). 

Two approaches I'm thinking:

1. Each item could yield a matching score and the item with the highest matching score will be selected. E.g STAB MONSTER WITH DAGGER would be understood by both SWORD and DAGGER, but would yield higher matching score for DAGGER.

2. Each item could understand only a certain syntax, and we select the item that understands the command completely. E.g both SWORD and DAGGER would understand STAB MONSTER, but only the DAGGER understands STAB MONSTER WITH DAGGER.

### Effects

- Important commands (HELP, QUIT...) cannot be overriden by other things in the system
- There is a default at the global layer for common commands like LOOK, but the room layer can choose to override or modify these commands if they want to do something unusual
- Special rooms (such as the login or the chargen room) can execute its own script and prevent the command dispatcher from looking down at the layers under it
- Potential to add other layers (such as a Quest layer) later

### To Do Next

- Check (in order): promises, generators, async/await, lodash
- And closure (not as urgent)
- Make input text field bigger
- Create a dedicated channel for text output instead of console.log()
- Implement the command dispatcher on the front end
- Implement Django authentication
- Design the API for the terminal
- Look up server pushing to client and race conditions


## March 17, 2017

### Overview

- Added two apps: terminal and generics
- Terminal: interaction between the user (through the browswer) and the backend
- Generics: models (_generics_) for the basic, non-extending objects 

### Terminal

- Appearance: added the CSS to look like a terminal
- Input: the input can done on a masked form text field
- Output: the text appears at the end of existing texts and pushes the input field down

### Generics

- Added Rooms, Characters, Items, and Puzzles

### Contents

- Added the first few rooms (login, waiting room, platform)

### To Do Next

- Make input text field bigger
- Create a dedicated channel for text output instead of console.log()
- Design the API for the terminal

### To Figure Out

- How to design a system similar to stdin/stdout for certain rooms (done)