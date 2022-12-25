const router = require("express").Router()  
const verifyToken = require('../middleware/auth')
const AuthController =require('../controllers/AuthControllers')

//SIGN UP
router.post("/api/register", AuthController.registerUser)

router.post("/api/login", AuthController.loginUser)
  
router.post("/tokenIsValid", AuthController.tokenIsvalid)
  // get user data
router.get("/", verifyToken, AuthController.getUser)


  module.exports = router;