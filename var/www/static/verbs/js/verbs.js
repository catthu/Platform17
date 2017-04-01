// Functions that process verb-related tasks 

function getVerbs(obj) {
    /*
    getVerbs
    Given an objects, get all the verbs understood by it, but not by any of its parents
    (maybe fix that?)
    Argument:
        obj: an object, likely a game object
    Return value:
        verbs (dict) of verb : (name of function for that verb)
    */
    let verbs = {};
    for (prop in obj) {
        if (prop.indexOf("verb_")) {
            verbs[prop.slice(5)] = obj[prop];
        }
    }
    return verbs;
}

function doVerb(input, obj, block = false, retry_msg = null) {
    // return falsy if can find things, truthy if can
    /*
    doVerb
    This function is called by every layer's parseInput functions.
    It executes the verb's function on the layer if the function exists, and
    then generally return truthy if the verb was found and some function was
    executed.
    Otherwise, in most cases, it would want to move to the next layer and thus return falsy.
    Arguments:
        input(str): the input as entered through the terminal
        obj(object): the object to check for the verb inside
            This object should have a parseInput function, where doVerb is called
        block(bool): false if the command should be cascaded down to the lower layers
            , true if it shouldn't be
        retry_msg(str): if block is true, and this retry_msg is not null,
            then print the retry msg to the terminal
    Return value:
        Truthy if a command is found and executed
        Falsy otherwise 
    */

    // List of command shortcuts and their full commands mapping

    shortcuts = {
        "'": 'say',
        'l': 'look'
    };

    // Extracting the first word of the input as the verb

    const start = input.indexOf(" ");
    let verb;
    if (start !== -1) {
        verb = input.slice(0, start);
    } else {
        verb = input;
    }

    // Check whether it's a shortcut

    if (shortcuts.hasOwnProperty(verb.toLowerCase())) {
        verb = shortcuts[verb];
    }

    // Check if object has verb
    // If it does, then execute the verb
    // All verb takes as input the rest of the command, not including the verb itself
    // This part of the input is trimmed before passed into the verb function

    if (obj["verb_" + verb]) {
        if (start !== -1) {
            return obj["verb_" + verb](input.slice(start).trim());
        } else {
            return obj["verb_" + verb]();
        }
    }

    // If command doesn't cascade down, then return true
    // and optionally print the retry_msg
    // Otherwise return null

    if (block == true) {
        if (retry_msg) {
            writeLine(retry_msg);
        }
        return true;
    }
    return null;
}