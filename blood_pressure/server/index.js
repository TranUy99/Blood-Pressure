const express = require("express");
const cors = require('cors')
const mongoose = require("mongoose");
require('dotenv').config()
// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const bloodPressureRouter = require("./routes/bloodPressure");
const doctorRouter = require("./routes/doctor")
const scheduleRouter =require("./routes/schedule")
const bookingRouter = require("./routes/booking")
const AccountController =require("./routes/account")


// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB =
  "mongodb+srv://uy:uy123@cluster0.m776gwd.mongodb.net/?retryWrites=true&w=majority";

// middleware
app.use(express.json());
app.use(cors());
app.use(authRouter);
app.use(bloodPressureRouter);
app.use(doctorRouter);
app.use(scheduleRouter);
app.use(bookingRouter);
app.use(AccountController);


// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});