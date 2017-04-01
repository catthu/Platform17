var chargen = {

    parseInput: (input) => {
        // Does not allow commands to propogate down to lower layers during chargen
        // Then turn the room into a normal room afterward
        return doVerb(input, chargen, true, "Again, please? Just SAY and your first name. 'SAY ALEX', for example, if your first name is Alex.");
    },

    verb_say: async (input) => {
        // First step of chargen: give first name
        // Extends the global command SAY
        await global_commands.verb_say(input);
        let first_name = processText.capitalize(input);
        writeLine("She scribbles your name on a notepad. <span class ='dialogue'>\"" + first_name + ", got it. And your last name?\"</span>");
        
        // Then last name
        let last_name = await readLine(null, checkLastName);
        last_name = last_name.slice(last_name.indexOf(" "));
        last_name = processText.capitalize(last_name);
        
        writeLine("She writes that down to. <span class ='dialogue'>\"Spleeendid.\"");
        await delayedWriteLine("The train pulls to a stop. While you were talking, The Interstellar Express has somehow boarded the space station and is now sitting at Platform 17. Fast, isn't it? ");
        await delayedWriteLine("Feel free to take a look around. When you're ready, EXIT.");
        
        // Create a character with the given names
        // First and last names are saved into the database capitalized

        createCharacter(first_name, last_name);
        
        // Save character information into the environment ME variable

        ME['first_name'] = first_name;
        ME['last_name'] = last_name;

        CURRENT_ROOM_SCRIPT = {
            // After chargen, turn the room into a normal room
            parseInput: (input) => {
                return null
            }
        }

        // Open a websocket

        openWebSocket("chargen");

        return true;

        /////////////// Helper functions for chargen /////////////////

        async function checkLastName(input) {
            // readLine check function
            // The readLine for this understands 'SAY' but not "'" for some reason
            let start = input.indexOf(" ");
            let verb = input.slice(0, start);
            // Prompt again if only 'SAY' but no last name
            if (start === -1 && input.toLowerCase() === "say") {
                return {
                    'is_valid': false,
                    'retry_msg': "You don't just SAY. You SAY your last name. You can do it! I believe in you!"
                }
            }
            // Prompt again if the command is not 'SAY'
            if (verb.toLowerCase() !== 'say') {
                return {
                    'is_valid': false,
                    'retry_msg': "The woman arches her eyebrows at your apparent inability to SAY basic things. "
                };
            }
            // If command is SAY, gets the last name and run it
            // Through the global SAY command
            let last_name = input.slice(start).trim();
            await global_commands.verb_say(last_name);
            return {
                'is_valid': true
            };

        }

        async function createCharacter(first_name, last_name) {
            // Create a character from the given first name and last name
            first_name = first_name.trim();
            last_name = last_name.trim();
            const url = "auth/createcharacter/"
            const data = JSON.stringify({
                first_name,
                last_name
            });
            const init = {
                method: 'POST',
                credentials: 'include',
                body: data
            }
            let res = await fetch(url, init);
            return true;
        }
    },

}