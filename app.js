// Temporary array to store users
let users = [];

// SIGN-UP FORM
const signupForm = document.getElementById('signupForm');
if (signupForm) 
    {
    signupForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const phone = document.getElementById('phone').value;
        const role = document.getElementById('role').value;

        //If email is used once
        const exists = users.find(u => u.email === email);
        if (exists) 
            {
            alert("Email already used");
            return;
        }

        // Store user in array
        users.push({ name, email, password, phone, role });
        alert("Sign-Up successful!");

        // Clear form
        signupForm.reset();

        console.log("Current Users:", users); // For testing
    });
}

// SIGN-IN FORM (from before)
const signinForm = document.getElementById('signinForm');
if (signinForm) {
    signinForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        const user = users.find(u => u.email === email && u.password === password);
        if (user) {
            alert(`Welcome ${user.name}! Role: ${user.role}`);
        } else {
            alert("Invalid email or password!");
        }
    });
}
