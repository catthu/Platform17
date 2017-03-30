// Top command layer commands here
var top_commands = {

    parseInput: (input) => {
        return doVerb(input, top_commands);
    },

    verb_quit: async (input = null) => {
        const url = "auth/signout/"
        const init = {
            method: 'POST',
            credentials: 'include'
        }
        let res = await fetch(url, init)
        writeLine("Alright. Goodbye now.");
        return true;
    }
}