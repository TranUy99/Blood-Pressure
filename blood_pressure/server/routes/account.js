const router = require("express").Router()  
const verifyToken = require('../middleware/auth')

const AccountController = require("../controllers/AccountController");

//SIGN UP
router.patch("/api/updateAccount", verifyToken,AccountController.updateAccount)
router.patch("/api/changePassword", verifyToken,AccountController.changePassword)



  module.exports = router;