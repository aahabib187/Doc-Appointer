const oracledb = require("oracledb");

const dbConfig = {
  user: "system",
  password: "Afnan@123",
  connectString: "localhost/orclpdb"
};

async function testConnection() {
  let con;
  try {
    con = await oracledb.getConnection(dbConfig);
    console.log("✅ Oracle DB connected successfully!");
  } catch (err) {
    console.error("❌ DB connection failed:", err);
  } finally {
    if (con) await con.close();
  }
}

testConnection();
