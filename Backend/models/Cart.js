const mongoose = require("mongoose");

const CartSchema = new mongoose.Schema(
  {
    userId: { type: String, required: true },
    productId:{
      type:String,
      },
    quantity:{
        type:Number,
        default:1,
    },
    size: { type: String, required: false },
    
    
  },
  { timestamps: true }
);

module.exports = mongoose.model("Cart", CartSchema);