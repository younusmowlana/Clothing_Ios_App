const mongoose = require("mongoose");

const CartSchema = new mongoose.Schema(
  {
    userId: { type: String, required: true },
    products: [
        {
            productId:{
                type:String,
            },
            quantity:{
                type:Number,
                default:1,
            },
            title: { type: String, required: false, unique: true },
            desc: { type: String, required: false, },
            img: { type: String, required: false },
            categories: { type: Array },
            size: { type: String, required: false },
            color: { type: Array },
            price: { type: Number, required: false },
            inStock: { type: Boolean, default: true},
        }
    ],
    
    
  },
  { timestamps: true }
);

module.exports = mongoose.model("Cart", CartSchema);