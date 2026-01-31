const express = require("express");
const oracledb = require("oracledb");
const path = require("path");

const app = express();
app.use(express.json()); // parse JSON bodies
app.use(express.urlencoded({ extended: true })); // parse form data

// Serve static frontend files (like signup.html, style.css)
app.use(express.static(path.join(__dirname, "web"))); // Make sure signup.html is in "web" folder

// Oracle DB config – CHANGE these to your credentials
const dbConfig = {
  user: "system",
  password: "Afnan@123",
  connectString: "localhost/orclpdb"// XE is default Oracle Express DB
};

// Handle signup POST request
app.post("/signup", async (req, res) => {
    const { name, email, password, phone, role } = req.body;

    let con;
    try {
        con = await oracledb.getConnection(dbConfig);

        await con.execute(
            `INSERT INTO users (name, email, pass, phone, role)
             VALUES (:name, :email, :pass, :phone, :role)`,
            { name, email, pass: password, phone, role },
            { autoCommit: true }
        );

        res.send("Signup successful!");
    } catch (err) {
        console.error(err);
        // Handle unique constraint (email already exists)
        if (err.errorNum === 1) {
            res.status(400).send("User with this email already exists");
        } else {
            res.status(500).send("Database error");
        }
    } finally {
        if (con) await con.close();
    }
});

// Start server on port 3000
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
