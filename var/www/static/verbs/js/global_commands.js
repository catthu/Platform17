var global_commands = {

    parseInput: async (input) => {
        if (await !doVerb(input, global_commands)) {
            writeLine("I don't understand that.");
            // Maybe add suggestions
            return true;
        }
    },

    verb_say: (input) => {
        if (!input) {
            writeLine("Say what?");
            return true;
        }
        input = processText.prepareForWriteLine(input);        
        text = '"' + input + '"';
        writeLine("You say, <span class = 'dialogue'>" + text + "</span>")
        return true;
    },

    verb_look: (input) => {
        if (!input) {
            writeLine("<span class = 'room-name'>----- " + current_room.name + " -----</span>");
            writeLine(current_room.description);
            return true;
        }

        if (input.trim() === 'me') {
            console.log('if');
            writeLine("You are " + me.first_name + " " + me.last_name + ".")
            return true;
        }
    },

    verb_meow: (input) => {
        writeLine("You meow.");
        return true;
    }
}