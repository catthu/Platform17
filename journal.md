# Platform 17 Development Progress

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