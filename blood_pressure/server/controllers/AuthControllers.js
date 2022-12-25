const User = require('../models/User')
const bcryptjs = require("bcryptjs");
const jwt = require('jsonwebtoken')

class AuthController{
    async registerUser(req,res){
      try{
        const { username, email,password } = req.body

	// Simple validation
	const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      username,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
}


  async loginUser(req,res){
        const { email, password } = req.body

	// Simple validation
	if (!email || !password)
		return res
			.status(400)
			.json({ success: false, message: 'Missing username and/or password' })

	try {
		// Check for existing user
		const user = await User.findOne({ email })
		if (!user)
			return res
				.status(400)
				.json({ success: false, message: 'User with same email already exists!' })

		// Username found
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, process.env.ACCESS_TOKEN_SECRET,);
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
}


    async tokenIsvalid (req,res){
        try {
            const token = req.header("Authorization");
            if (!token) return res.json(false);
            const verified = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
            if (!verified) return res.json(false);
        
            const user = await User.findById(verified.id);
            if (!user) return res.json(false);
            res.json(true);
          } catch (e) {
            res.status(500).json({ error: e.message });
          }
    }


    async getUser(req,res){
        const user = await User.findById(req.userId);
        res.json({ ...user._doc, token: req.token });
      }
}
module.exports= new AuthController() 