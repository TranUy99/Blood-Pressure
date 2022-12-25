const User = require('../models/User')
const bcryptjs = require("bcryptjs");
const jwt = require('jsonwebtoken')
class AccountController{


    async updateAccount(req,res){

        try {
            const token = req.headers.token
            // const accountInfo = JSON.parse(Buffer.from(token.split('.')[1], 'base64').toString())
            // const acc_id = accountInfo.id
            // const user = await User.findOne({acc_id: acc_id})
            await User.updateOne({$set: req.body})
            res.status(200).json("Personal page update successfully")
        } catch (err) {
            if(err.name === "ValidationError") {
                res.status(500).json(Object.values(err.errors).map(val => val.message))
            } else {
                res.status(500).json(err)
            }
        }
    }
    async changePassword(req,res){
        try {
            const token = req.headers.token
            const { email, password,newPass,repeatPass} = req.body
            const user = await User.findOne({ email })
            const validOldPass = await bcryptjs.compare(password, user.password);
            if(newPass != repeatPass) {
                return res.status(404).json("Re-entered password does not match")
            }
            else if(!validOldPass) {
                return res.status(404).json("Wrong password")
            }
            else if (validOldPass && newPass == repeatPass) {
                const hashed = await bcryptjs.hash(newPass, 10)     
                await User.updateOne({$set: {"password": hashed}})
                res.status(200).json("Update successful")
            }    
        }catch (e) {
    res.status(500).json({ error: e.message });
  }
    }
}

module.exports = new AccountController()