# Platform 17 Development Progress

## March 18, 2017

### Overview

- Designed the command dispatcher

### Command Dispatcher

When a command is inputed, the command dispatcher would pass it through several command layers in the following order
- Top-level commands: the non-overridable commands of the system (e.g HELP, QUIT, REPORT...)
- Room-level commands: commands understood by the room the user is in. This could be the typical command set for a normal room, or a special room, or a scripted room --- depending on the room
- Global commands: commands that are generally applicable regardless of where the user is, e.g. LOOK, SMILE, GIVE object TO person
- Item-level commands: if none of the above layers yields a match for the command, all the items are checked in a specific matching order to see if any of the items supports the command

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

- Make input text field bigger
- Create a dedicated channel for text output instead of console.log()
- Implement the command dispatcher on the front end
- Design the API for the terminal


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