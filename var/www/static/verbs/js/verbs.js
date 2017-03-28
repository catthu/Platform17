function getVerbs(obj) {
    let verbs = {};
    for (prop in obj) {
        if (prop.indexOf("verb_")) {
            verbs[prop.slice(5)] = login[prop];
        }
    }
    return verbs;
}

function doVerb(input, obj) {
    // return falsy if can find things, truthy if can
    let verb = input.split(" ")[0];
    if (obj["verb_" + verb]) {
        return obj["verb_" + verb](input);
    }
    return null;
}