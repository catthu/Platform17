var login = {
    parseRoomLayer : async (input) => {

        acceptable_inputs = ["new", "sign", "sign in", "guest"];        
        // NEW branch:

        if (acceptable_inputs.indexOf(input) === -1) {
            console.log('different input');
            return false;
        }

        if (input === 'new') {
            writeLine("OK. What username do you want?");
            var r = await readLine(null, input => {return input == 'catthu'; });
            writeLine("And password?");
            var p = await readLine(null, input => {return input == 'ok'; });
            writeLine("And password, again?");
            var p = await readLine(null, input => {return input == 'ok'; });
            writeLine("I know you're grumpy about checking emails, so I won't ask for an email address or anything.");
            setTimeout(writeLine("If you lose your password, you'll just have to start everything over."), 1000);
            setTimeout(writeLine("It probably won't be more than 1,000 hours of progress."), 1000);
            setTimeout(writeLine("Or, you know, just give me your email address already."), 1000);
            var p = await readLine(null, input => {return input == 'ok'; });


            writeLine("What's your bank account number?");
            setTimeout(writeLine("Just kidding. I don't really want it."), 1000);
            setTimeout(writeLine("Yet."), 1000);
            var p = await readLine(null, input => {return input == 'ok'; });

            writeLine("Cool, you're all set. Welcome to Platform 17! Your train may be coming soon.");
            }

    // SIGN IN branch:
    // OK. What's your username?
    // And password?
    // Welcome back, brave warrior! (or first name)*/

    },

    checkExistingUsername: (usename) => {
        // validate required input pattern too, like alphanumeric
    }
}

