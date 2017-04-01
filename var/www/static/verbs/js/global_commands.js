// This is the list and functions for all the global commands

var global_commands = {

    parseInput: async (input) => {
        if (await !doVerb(input, global_commands)) {
            // This is the last layer, if the command isn't understood then
            // write "I don't understand that"
            writeLine("I don't understand that.");
            // Maybe add suggestions
            return true;
        }
    },

    verb_say: (input) => {
        // If there's no argument, print "Say what?"
        if (!input) {
            writeLine("Say what?");
            return true;
        }
        // Otherwise, properly format the string and print it to the terminal
        input = processText.prepareForWriteLine(input);        
        let text = '"' + input + '"';
        writeLine("You say, <span class = 'dialogue'>" + text + "</span>")

        // If a socket is open (not in login or chargen), format the push
        // message and push to everyone in the same room

        if (socket) {
            let push_msg = processText.capitalizeEveryWord(ME['first_name'] + " " + ME['last_name']) + " says, <span class = 'dialogue'>" + text + "</span>"
            push(push_msg, CURRENT_ROOM.code_name);
        }
        return true;
    },

    verb_look: (input) => {
        // Currently only support LOOK and LOOK ME
        // Will need to support more in the future
        // Print the room name, info and characters here
        if (!input) {
            writeLine("<span class = 'room-name'>----- " + CURRENT_ROOM.name + " -----</span>");
            writeLine(CURRENT_ROOM.description);
            writeCharactersList(CURRENT_ROOM.characters_here)
            return true;
        }

        // If LOOK ME, print out character name

        if (input.trim() === 'me') {
            writeLine("You are " + me.first_name + " " + me.last_name + ".")
            return true;
        }
    },

    verb_meow: (input) => {
        // Meeeeeeooowww
        writeLine("You meow.");
        return true;
    }
}