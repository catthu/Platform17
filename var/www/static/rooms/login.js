var login = {

    parseRoomLayer : (input) => {
        // only do this most of the time
        // but sometimes may want special behaviors
        // define those here
        return doVerb(input, login);
    },

    verb_new: async () => {

        writeLine("OK. What username do you want?");
        let username = await readLine(null, checkExistingUsername);

        let pass1 = null;
        let pass2 = "";

        while (pass1 !== pass2) {
            if (pass1 !== null) {
                writeLine("Those are not the same passwords. Try again.");
            }
            writeLine("Now give me your password.");
            pass1 = await readPassword(null, checkValidPassword);

            writeLine("And password, again.");
            pass2 = await readPassword(null);
        }

        writeLine("I know you're grumpy about checking emails, so I won't ask for an email address or anything.");
        await delayedWriteLine("If you lose your password, you'll just have to start everything over.");
        await delayedWriteLine("It probably won't be more than 1,000 hours of progress.");
        await delayedWriteLine("Or, you know, just give me your email address already.");
        let email = await readLine(null, checkValidEmail);
        
        writeLine("What's your bank account number?");
        await delayedWriteLine("Just kidding. I don't really want it.");
        await delayedWriteLine("Yet.");

        //await createUser(username, pass1, email);

        await delayedWriteLine("Cool, you're all set. Welcome to Platform 17! Your train may be coming soon.");

        async function checkExistingUsername(username) {
            if (!username.match(/^\w+$/)) {
                return {
                    'is_valid': false,
                    'retry_msg': "Letters, numbers and _ only. Try again, without anything funky."
                };
            }
            const url = "auth/checkusername/" + username + "/";
            let res = await fetch(url);
            res = await res.json();
            if (res.username_exists) {
                return {
                    'is_valid': false,
                    'retry_msg': "You have a popular username, or you're just forgetful about having signed up. Eitherway, this username already exists. Try again."
                };
            }
            return {'is_valid': true};
        }

        function checkValidPassword(password) {
            if (password.length < 6) {
                return {
                    'is_valid': false,
                    'retry_msg': "It may be hard to remember anything too long, but password must be more than 6 characters."
                };
            }
            return {'is_valid': true};
        }

        function checkValidEmail(email) {
            if (!email.match(/^\w+@\w+\.\w/)) {
                return {
                    'is_valid': false,
                    'retry_msg': "That's not a valid email address. Now enter something real."
                };
            }
            return {'is_valid': true};
        }

        // TODO: look up how to transfer user sign up / sign in information over http
        function createUser(username, password, email = null) {
            /*const url = "auth/createuser/";
            const init = {
                method: 'POST',
                headers: {
                    "Authorization": , // only for when authenticating?
                }
            }
            let res = await fetch(url);*/
        }
    },

    verb_sign: async () => {

        // SIGN IN branch:
        // OK. What's your username?
        // And password?
        // Welcome back, brave warrior! (or first name)
    }
}

