var chargen = {

    parseInput: (input) => {
        return doVerb(input, chargen, true, "Again, please? Just SAY and your first name. 'SAY ALEX', for example, if your first name is Alex.");
    },

    verb_say: async (input) => {
        await global_commands.verb_say(input);
        let first_name = processText.capitalize(input);
        writeLine("She scribbles your name on a notepad. <span class ='dialogue'>\"" + first_name + ", got it. And your last name?\"</span>");
        let last_name = await readLine(null, checkLastName);
        last_name = last_name.slice(last_name.indexOf(" "));
        last_name = processText.capitalize(last_name);
        writeLine("She writes that down to. <span class ='dialogue'>\"Spleeendid.\"");
        await delayedWriteLine("The train pulls to a stop. While you were talking, The Interstellar Express has somehow boarded the space station and is now sitting at Platform 17. Fast, isn't it? ");
        await delayedWriteLine("Feel free to take a look around. When you're ready, EXIT.");
        createPlayer(first_name, last_name);
        me['first_name'] = first_name;
        me['last_name'] = last_name;
        current_room_script = normalroom;
        return true;

        async function checkLastName(input) {
            input.trim();
            let start = input.indexOf(" ");
            let verb = input.slice(0, start);
            if (start === -1 && input.toLowerCase() === "say") {
                return {
                    'is_valid': false,
                    'retry_msg': "You don't just SAY. You SAY your last name. You can do it! I believe in you!"
                }
            }
            if (verb.toLowerCase() !== 'say') {
                return {
                    'is_valid': false,
                    'retry_msg': "The woman arches her eyebrows at your apparent inability to SAY basic things. "
                };
            }
            let last_name = input.slice(start);
            await global_commands.verb_say(last_name);
            return {
                'is_valid': true
            };

        }

        async function createPlayer(first_name, last_name) {
            first_name = first_name.trim();
            last_name = last_name.trim();
            const url = "auth/createplayer/"
            const data = JSON.stringify({
                first_name,
                last_name
            });
            const init = {
                method: 'POST',
                credentials: 'include',
                body: data
            }
            let res = await fetch(url, init)
            return true;
        }
    }
}