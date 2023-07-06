const express = require("express");
const mongoose = require("mongoose");

const authRoute = require("./route/auth");
const { booksSchema } = require("./models/books");
const booksRoute = require("./route/books");

const PORT = process.env.PORT || 8080;
const app = express();
const DB = "mongodb+srv://mohit:mohit%40123@cluster0.67beuxh.mongodb.net/?retryWrites=true&w=majority"



mongoose.connect(DB).then(() => {console.log("Connection Successful");
})
.catch((e) => {
    console.log(e);
});

app.use(express.json());
app.use(authRoute);
app.use(booksRoute);


app.listen(PORT, "0.0.0.0", () => {console.log(`Connected at port ${PORT}`);
});