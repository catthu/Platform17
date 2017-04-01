var login = {

    // Script for new users sign up and sign in

    parseInput : (input) => {
        // Does not allow commands to propogate down to the lower layers
        // At the moment, understands NEW and SIGN
        // Will support GUEST later
        return doVerb(input, login, true, "Err. NEW or SIGN IN only. Try again.");
    },

    verb_new: async () => {

        // Signing up new users

        writeLine("OK. What username do you want?");
        let username = await readLine(null, checkExistingUsername);

        let pass1 = null;
        let pass2 = "";

        // Check that the two passwords are the same

        while (pass1 !== pass2) {
            if (pass1 !== null) {
                writeLine("Those are not the same passwords. Try again.");
            }
            writeLine("Now give me your password.");
            pass1 = await readPassword(null, checkValidPassword);

            writeLine("And password, again.");
            pass2 = await readPassword(null);
        }

        // Get their email address

        writeLine("I know you're grumpy about checking emails, so I won't ask for an email address or anything.");
        await delayedWriteLine("If you lose your password, you'll just have to start everything over.");
        await delayedWriteLine("It probably won't be more than 1,000 hours of progress.");
        await delayedWriteLine("Or, you know, just give me your email address already.");
        let email = await readLine(null, checkValidEmail);
        
        writeLine("What's your bank account number?");
        await delayedWriteLine("Just kidding. I don't really want it.");
        await delayedWriteLine("Yet.", 500);

        await delayedWriteLine("Cool, you're all set. Welcome to Platform 17! Your train may be coming soon.");

        // Create the User and associated Player

        createUser(username, pass1, email);

        /////////////// Helper functions for NEW /////////////////

        async function checkExistingUsername(username) {
            // readLine check function
            // Check if username meets requirements or already exists
            // Alphanumerics and underscores only
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
            // readLine check function
            // Check if password meets requirements
            // More than 6 characters
            if (!login.passwordMeetsRequirements(password)) {
                return {
                    'is_valid': false,
                    'retry_msg': "It may be hard to remember anything too long, but password must be more than 6 characters."
                };
            }
            return {'is_valid': true};
        }

        function checkValidEmail(email) {
            // readLine check function 
            // Check if email is a valid email according to regex
            if (!email.match(/^\w+@\w+\.\w/)) {
                return {
                    'is_valid': false,
                    'retry_msg': "That's not a valid email address. Now enter something real."
                };
            }
            return {'is_valid': true};
        }

        async function createUser(username, password, email = null) {
            // Create new user and associated player, store in db
            // Then move user to Chargen
            const url = '/auth/createuser/';
            const data = JSON.stringify({
                username,
                password,
                email
            })
            const init = {
                method: 'POST',
                credentials: 'include',
                body: data
            }
            let res = await fetch(url, init);
            loadRoom('chargen');
            return true;
        }
    },

    verb_sign: async () => {

        // Signing in existing users

        let username = null;
        let password = null;

        // Check if valid username and password
        // until valid

        while (username === null || !(await authenticate(username, password))) {
            writeLine("OK. What's your username?");
            username = await readLine(null);

            writeLine("And password?");
            password = await readPassword(null);

        }

        return true;

        /////////////// Helper functions for SIGN /////////////////

        async function authenticate(username, password) {

            // If username or password entered doesn't meet the signing up
            // requirements, prompt user to try again

            if (!login.usernameMeetsRequirements(username) || !login.passwordMeetsRequirements(password)) {
                writeLine("Did you get that right?");
                writeLine("Usernames can only contain letters, numbers or _");
                writeLine("And password has to be more than 6 characters.")
                writeLine("Once more, now.");
                return false;
            }
            
            // If they do meet the requirement, check with server

            const url = '/auth/signin/';
            const data = JSON.stringify({
                username,
                password
            })
            const init = {
                method: 'POST',
                credentials: 'include',
                body: data
            }
            let res = await fetch(url, init);

            // If wrong username / password combination, prompt to try again

            if (res.status == 401) {
                writeLine("That doesn't seem right. Try again.");
                return false;
            }

            // Else put them at their character's last location

            writeLine("Welcome back!");
            character_data = await res.json();

            // If the user doesn't have any character (e.g. they logged out before
            // having created a character), put them in chargen to create one

            if (!character_data.hasCharacter) {
                return loadRoom("chargen");
            }

            // Put character information in the global ME variable

            ME['first_name'] = character_data.first_name;
            ME['last_name'] = character_data.last_name;

            // Move user to their last location
            loadRoom(character_data.location);
            return true;                  
      
        
        }
    },

    usernameMeetsRequirements: (username) => {
        // Returns true if username meets requirement
        // false if it doesn't
        // requirement is alphanumreic and underscores only
        if (!username.match(/^\w+$/)) {
            return false;
        }
        return true;
    },

    passwordMeetsRequirements: (password) => {
        // Returns true if username meets requirement
        // false if it doesn't
        // requirement is 6 characters or more
        if (password.length < 6) {
            return false;
        }
        return true;
    },

}

