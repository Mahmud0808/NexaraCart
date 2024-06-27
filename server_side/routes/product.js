const express = require("express");
const router = express.Router();
const Product = require("../model/product");
const multer = require("multer");
const { uploadProduct } = require("../uploadFile");
const asyncHandler = require("express-async-handler");

// Get all products
router.get(
  "/",
  asyncHandler(async (req, res) => {
    try {
      const products = await Product.find()
        .populate("proCategoryId", "id name")
        .populate("proSubCategoryId", "id name")
        .populate("proBrandId", "id name")
        .populate("proVariantTypeId", "id type")
        .populate("proVariantId", "id name");
      res.json({
        success: true,
        message: "Products retrieved successfully.",
        data: products,
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Get a product by ID
router.get(
  "/:id",
  asyncHandler(async (req, res) => {
    try {
      const productID = req.params.id;
      const product = await Product.findById(productID)
        .populate("proCategoryId", "id name")
        .populate("proSubCategoryId", "id name")
        .populate("proBrandId", "id name")
        .populate("proVariantTypeId", "id name")
        .populate("proVariantId", "id name");
      if (!product) {
        return res
          .status(404)
          .json({ success: false, message: "Product not found." });
      }
      res.json({
        success: true,
        message: "Product retrieved successfully.",
        data: product,
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// create new product
router.post(
  "/",
  asyncHandler(async (req, res) => {
    try {
      // Execute the Multer middleware to handle multiple file fields
      uploadProduct.fields([
        { name: "image1", maxCount: 1 },
        { name: "image2", maxCount: 1 },
        { name: "image3", maxCount: 1 },
        { name: "image4", maxCount: 1 },
        { name: "image5", maxCount: 1 },
      ])(req, res, async function (err) {
        if (err instanceof multer.MulterError) {
          // Handle Multer errors, if any
          if (err.code === "LIMIT_FILE_SIZE") {
            err.message =
              "File size is too large. Maximum filesize is 5MB per image.";
          }
          console.log(`Add product: ${err}`);
          return res.json({ success: false, message: err.message });
        } else if (err) {
          // Handle other errors, if any
          console.log(`Add product: ${err}`);
          return res.json({ success: false, message: err });
        }

        // Extract product data from the request body
        const {
          name,
          description,
          quantity,
          price,
          offerPrice,
          proCategoryId,
          proSubCategoryId,
          proBrandId,
          proVariantTypeId,
          proVariantId,
        } = req.body;

        // Check if any required fields are missing
        if (
          !name ||
          !quantity ||
          !price ||
          !proCategoryId ||
          !proSubCategoryId
        ) {
          return res
            .status(400)
            .json({ success: false, message: "Required fields are missing." });
        }

        // Initialize an array to store image URLs
        const imageUrls = [];

        // Iterate over the file fields
        const fields = ["image1", "image2", "image3", "image4", "image5"];
        fields.forEach((field, index) => {
          if (req.files[field] && req.files[field].length > 0) {
            const file = req.files[field][0];
            const imageUrl = `/image/products/${file.filename}`;
            imageUrls.push({ image: index + 1, url: imageUrl });
          }
        });

        // Create a new product object with data
        const newProduct = new Product({
          name,
          description,
          quantity,
          price,
          offerPrice,
          proCategoryId,
          proSubCategoryId,
          proBrandId,
          proVariantTypeId,
          proVariantId,
          images: imageUrls,
        });

        // Save the new product to the database
        await newProduct.save();

        // Send a success response back to the client
        res.json({
          success: true,
          message: "Product created successfully.",
          data: null,
        });
      });
    } catch (error) {
      // Handle any errors that occur during the process
      console.error("Error creating product:", error);
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Update a product
router.put(
  "/:id",
  asyncHandler(async (req, res) => {
    const productId = req.params.id;
    try {
      // Execute the Multer middleware to handle file fields
      uploadProduct.fields([
        { name: "image1", maxCount: 1 },
        { name: "image2", maxCount: 1 },
        { name: "image3", maxCount: 1 },
        { name: "image4", maxCount: 1 },
        { name: "image5", maxCount: 1 },
      ])(req, res, async function (err) {
        if (err) {
          console.log(`Update product: ${err}`);
          return res.status(500).json({ success: false, message: err.message });
        }

        const {
          name,
          description,
          quantity,
          price,
          offerPrice,
          proCategoryId,
          proSubCategoryId,
          proBrandId,
          proVariantTypeId,
          proVariantId,
        } = req.body;

        // Find the product by ID
        const productToUpdate = await Product.findById(productId);
        if (!productToUpdate) {
          return res
            .status(404)
            .json({ success: false, message: "Product not found." });
        }

        // Update product properties if provided
        productToUpdate.name = name || productToUpdate.name;
        productToUpdate.description =
          description || productToUpdate.description;
        productToUpdate.quantity = quantity || productToUpdate.quantity;
        productToUpdate.price = price || productToUpdate.price;
        productToUpdate.offerPrice = offerPrice || productToUpdate.offerPrice;
        productToUpdate.proCategoryId =
          proCategoryId || productToUpdate.proCategoryId;
        productToUpdate.proSubCategoryId =
          proSubCategoryId || productToUpdate.proSubCategoryId;
        productToUpdate.proBrandId = proBrandId || productToUpdate.proBrandId;
        productToUpdate.proVariantTypeId =
          proVariantTypeId || productToUpdate.proVariantTypeId;
        productToUpdate.proVariantId =
          proVariantId || productToUpdate.proVariantId;

        // Iterate over the file fields to update images
        const fields = ["image1", "image2", "image3", "image4", "image5"];
        fields.forEach((field, index) => {
          if (req.files[field] && req.files[field].length > 0) {
            const file = req.files[field][0];
            const imageUrl = `/image/products/${file.filename}`;
            // Update the specific image URL in the images array
            let imageEntry = productToUpdate.images.find(
              (img) => img.image === index + 1
            );
            if (imageEntry) {
              imageEntry.url = imageUrl;
            } else {
              // If the image entry does not exist, add it
              productToUpdate.images.push({ image: index + 1, url: imageUrl });
            }
          }
        });

        // Save the updated product
        await productToUpdate.save();
        res.json({ success: true, message: "Product updated successfully." });
      });
    } catch (error) {
      console.error("Error updating product:", error);
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Delete a product
router.delete(
  "/:id",
  asyncHandler(async (req, res) => {
    const productID = req.params.id;
    try {
      const product = await Product.findByIdAndDelete(productID);
      if (!product) {
        return res
          .status(404)
          .json({ success: false, message: "Product not found." });
      }
      res.json({ success: true, message: "Product deleted successfully." });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

module.exports = router;
