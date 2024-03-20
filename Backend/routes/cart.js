const Cart = require("../models/Cart");
const Product = require("../models/Product");
const {
  verifyToken,
  verifyTokenAndAuthorization,
  verifyTokenAndAdmin,
} = require("./verifyToken");

const router = require("express").Router();


router.post("/", async (req, res) => {
  const { userId, products } = req.body;

  try {
    const updatedProducts = await Promise.all(
      products.map(async (product) => {
        const { productId } = product;
        const fetchedProduct = await Product.findOne({ _id: productId });
        if (!fetchedProduct) {
          throw new Error(`Product with ID ${productId} not found`);
        }

        // Fill in missing fields
        return {
          productId: fetchedProduct._id,
          quantity: product.quantity || 1, // Use the provided quantity or default to 1
          title: fetchedProduct.title,
          desc: fetchedProduct.desc,
          img: fetchedProduct.img,
          categories: fetchedProduct.categories,
          size:  products[0].size,
          color: fetchedProduct.color,
          price: fetchedProduct.price,
          inStock: fetchedProduct.inStock,
        };
      })
    );

    const newCart = new Cart({ userId, products: updatedProducts });

    const savedCart = await newCart.save();
    res.status(200).json(savedCart);
  } catch (err) {
    res.status(500).json({ error: err.message });
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
    res.status(200).json(cart);
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