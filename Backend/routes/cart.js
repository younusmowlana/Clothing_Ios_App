const Cart = require("../models/Cart");
const Product = require("../models/Product");
const {
  verifyToken,
  verifyTokenAndAuthorization,
  verifyTokenAndAdmin,
} = require("./verifyToken");

const router = require("express").Router();


router.post("/", async (req, res) => {
  const { userId, productId, size } = req.body;

  try {
    const fetchedProduct = await Product.findOne({ _id: productId });

    if (!fetchedProduct) {
      return res.status(404).json({ message: "Product not found" });
    }

    const newCart = new Cart({
      userId,
      productId: fetchedProduct._id,
      quantity: 1,
      title: fetchedProduct.title,
      desc: fetchedProduct.desc,
      img: fetchedProduct.img,
      categories: fetchedProduct.categories,
      size,
      color: fetchedProduct.color,
      price: fetchedProduct.price,
      inStock: fetchedProduct.inStock,
    });

    const savedCart = await newCart.save();
    res.status(200).json(savedCart);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Internal server error" });
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
    const cart = await Cart.findOne({ userId: req.params.userId });
    const cartArray = cart ? [cart] : [];
    res.status(200).json(cartArray);
  } catch (err) {
    res.status(500).json(err);
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