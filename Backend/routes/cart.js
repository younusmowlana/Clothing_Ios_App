const Cart = require("../models/Cart");
const Product = require("../models/Product");
const {
  verifyToken,
  verifyTokenAndAuthorization,
  verifyTokenAndAdmin,
} = require("./verifyToken");

const router = require("express").Router();


router.post("/", async (req, res) => {
  const newCart = new Cart(req.body);

  try {
    const savedCart = await newCart.save();
    res.status(200).json(savedCart);
  } catch (err) {
    console.log(err);
    res.status(500).json(err);
  }
});



//UPDATE
router.put("/:id", verifyTokenAndAuthorization, async (req, res) => {
  try {
    const updatedCart = await Cart.findByIdAndUpdate(
      req.params.id,
      {
        $set: req.body,
      },
      { new: true }
    );
    res.status(200).json(updatedCart);
  } catch (err) {
    res.status(500).json(err);
  }
});

//DELETE
router.delete("/:id", verifyTokenAndAuthorization, async (req, res) => {
  try {
    await Cart.findByIdAndDelete(req.params.id);
    res.status(200).json("Cart has been deleted...");
  } catch (err) {
    res.status(500).json(err);
  }
});

//GET USER CART
router.get("/find/:userId", async (req, res) => {
  try {
    const carts = await Cart.find({ userId: req.params.userId });

    console.log(carts);

    if (!carts || carts.length === 0) {
      return res.status(404).json({ message: "Carts not found" });
    }

    const cartArray = [];

    for (const cart of carts) {
      const product = await Product.findOne({ _id: cart.productId });

      if (!product) {
        console.error(`Product not found for cart: ${cart._id}`);
        continue; 
      }

      const newCart = {
        "_id":cart._id,
        "userId": cart.userId,
        "productId": product._id,
        "title": product.title,
        "desc": product.desc,
        "img": product.img,
        "categories": product.categories,
        "size": cart.size,
        "color": product.color,
        "price": product.price,
        "quantity": cart.quantity
      };

      cartArray.push(newCart);
    }

    res.status(200).json(cartArray);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Internal server error" });
  }
});


// //GET ALL

router.get("/", verifyTokenAndAdmin, async (req, res) => {
  try {
    const carts = await Cart.find();
    res.status(200).json(carts);
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;