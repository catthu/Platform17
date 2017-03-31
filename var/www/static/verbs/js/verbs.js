function getVerbs(obj) {
    let verbs = {};
    for (prop in obj) {
        if (prop.indexOf("verb_")) {
            verbs[prop.slice(5)] = login[prop];
        }
    }
    return verbs;
}

function doVerb(input, obj, block = false, retry_msg = null) {
    // return falsy if can find things, truthy if can
    shortcuts = {
        "'": 'say',
        'l': 'look'
    };
    const start = input.indexOf(" ");
    let verb;
    if (start !== -1) {
        verb = input.slice(0, start);
    } else {
        verb = input;
    }
    if (shortcuts.hasOwnProperty(verb)) {
        verb = shortcuts[verb];
    }
    if (obj["verb_" + verb]) {
        if (start !== -1) {
            return obj["verb_" + verb](input.slice(start).trim());
        } else {
            return obj["verb_" + verb]();
        }
    }
    if (block == true) {
        if (retry_msg) {
            writeLine(retry_msg);
        }
        return true;
    }
    return null;
}