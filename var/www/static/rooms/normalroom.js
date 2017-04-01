// This is the room-layer command dispatcher
// It resolves commands that a normal, typical room understands

var normalroom = {
    
    parseInput: (input) => {
        return doVerb(input, normalroom);
    },

    verb_exit: (input = null) => {
        // Return false if the current room's exit isn't set
        // And move the player to the exit room, otherwise
        if (!CURRENT_ROOM.exit) {
            return false;
        }
        loadRoom(CURRENT_ROOM.exit);
        return true;
    }
}