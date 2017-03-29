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

        await createUser(username, pass1, email);

        await delayedWriteLine("Cool, you're all set. Welcome to Platform 17! Your train may be coming soon.");

        async function checkExistingUsername(username) {
            if (!login.usernameMeetsRequirements(username)) {
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
            if (!login.passwordMeetsRequirements(password)) {
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

        async function createUser(username, password, email = null) {
            const url = "auth/createuser/";
            const data = JSON.stringify({
                username,
                password,
                email
            })
            const init = {
                method: 'POST',
                body: data
            }
            let res = await fetch(url, init);
        }
    },

    verb_sign: async () => {

        // SIGN IN branch:
        let username = null;
        let password = null;
        while (username === null || !(await authenticate(username, password))) {
            writeLine("OK. What's your username?");
            username = await readLine(null);

            writeLine("And password?");
            password = await readPassword(null);

        }

        //Welcome back, brave warrior! (or first name)

        async function authenticate(username, password) {
            if (!login.usernameMeetsRequirements(username) || !login.passwordMeetsRequirements(password)) {
                writeLine("Did you get that right?");
                writeLine("Usernames can only contain letters, numbers or _");
                writeLine("And password has to be more than 6 characters.")
                writeLine("Once more, now.");
                return false;
            } else {
                const url = 'auth/signin/'
                const data = JSON.stringify({
                    username,
                    password
                })
                const init = {
                    method: 'POST',
                    body: data
                }
                let res = await fetch(url, init);
                if (res.status == 401) {
                    writeLine("That doesn't seem right. Try again.");
                    return false;
                } else {
                    writeLine("Welcome back!");
                    user_data = await res.json();
                    console.log(user_data.id);  
                    return true;                  
                }
            }
        }
    },

    verb_guest: async () => {
        return null;
    },

    usernameMeetsRequirements: (username) => {
        if (!username.match(/^\w+$/)) {
            return false;
        }
        return true;
    },

    passwordMeetsRequirements: (password) => {
        if (password.length < 6) {
            return false;
        }
        return true;
    }
}

