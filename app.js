const express = require("express");
const oracledb = require("oracledb");
const path = require("path");

const app = express();
app.use(express.json()); // parse JSON
app.use(express.urlencoded({ extended: true })); // data

app.use(express.static(path.join(__dirname, "web"))); er

// Oracle er sathe connection
const dbConfig = {
  user: "system",
  password: "Afnan@123",
  connectString: "localhost/orclpdb"
};


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
        // email exist korle baad
        if (err.errorNum === 1) {
            res.status(400).send("User with this email already exists");
        } else {
            res.status(500).send("Database error");
        }
    } finally {
        if (con) await con.close();
    }
});


const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
