const express = require("express");
const asyncHandler = require("express-async-handler");
const router = express.Router();
const Coupon = require("../model/couponCode");
const Product = require("../model/product");

// Get all coupons
router.get(
  "/",
  asyncHandler(async (req, res) => {
    try {
      const coupons = await Coupon.find()
        .populate("applicableCategory", "id name")
        .populate("applicableSubCategory", "id name")
        .populate("applicableProduct", "id name");
      res.json({
        success: true,
        message: "Coupons retrieved successfully.",
        data: coupons,
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Get a coupon by ID
router.get(
  "/:id",
  asyncHandler(async (req, res) => {
    try {
      const couponID = req.params.id;
      const coupon = await Coupon.findById(couponID)
        .populate("applicableCategory", "id name")
        .populate("applicableSubCategory", "id name")
        .populate("applicableProduct", "id name");
      if (!coupon) {
        return res
          .status(404)
          .json({ success: false, message: "Coupon not found." });
      }
      res.json({
        success: true,
        message: "Coupon retrieved successfully.",
        data: coupon,
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Create a new coupon
router.post(
  "/",
  asyncHandler(async (req, res) => {
    const {
      couponCode,
      discountType,
      discountAmount,
      minimumPurchaseAmount,
      endDate,
      status,
      applicableCategory,
      applicableSubCategory,
      applicableProduct,
    } = req.body;
    if (
      !couponCode ||
      !discountType ||
      !discountAmount ||
      !endDate ||
      !status
    ) {
      return res
        .status(400)
        .json({
          success: false,
          message:
            "Code, discountType, discountAmount, endDate, and status are required.",
        });
    }

    try {
      const coupon = new Coupon({
        couponCode,
        discountType,
        discountAmount,
        minimumPurchaseAmount,
        endDate,
        status,
        applicableCategory,
        applicableSubCategory,
        applicableProduct,
      });

      const newCoupon = await coupon.save();
      res.json({
        success: true,
        message: "Coupon created successfully.",
        data: null,
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Update a coupon
router.put(
  "/:id",
  asyncHandler(async (req, res) => {
    try {
      const couponID = req.params.id;
      const {
        couponCode,
        discountType,
        discountAmount,
        minimumPurchaseAmount,
        endDate,
        status,
        applicableCategory,
        applicableSubCategory,
        applicableProduct,
      } = req.body;
      console.log(req.body);
      if (
        !couponCode ||
        !discountType ||
        !discountAmount ||
        !endDate ||
        !status
      ) {
        return res
          .status(400)
          .json({
            success: false,
            message:
              "CouponCode, discountType, discountAmount, endDate, and status are required.",
          });
      }

      const updatedCoupon = await Coupon.findByIdAndUpdate(
        couponID,
        {
          couponCode,
          discountType,
          discountAmount,
          minimumPurchaseAmount,
          endDate,
          status,
          applicableCategory,
          applicableSubCategory,
          applicableProduct,
        },
        { new: true }
      );

      if (!updatedCoupon) {
        return res
          .status(404)
          .json({ success: false, message: "Coupon not found." });
      }

      res.json({
        success: true,
        message: "Coupon updated successfully.",
        data: null,
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Delete a coupon
router.delete(
  "/:id",
  asyncHandler(async (req, res) => {
    try {
      const couponID = req.params.id;
      const deletedCoupon = await Coupon.findByIdAndDelete(couponID);
      if (!deletedCoupon) {
        return res
          .status(404)
          .json({ success: false, message: "Coupon not found." });
      }
      res.json({ success: true, message: "Coupon deleted successfully." });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  })
);

// Check coupon
router.post(
  "/check-coupon",
  asyncHandler(async (req, res) => {
    console.log(req.body);
    const { couponCode, productIds, purchaseAmount } = req.body;

    try {
      // Find the coupon with the provided coupon code
      const coupon = await Coupon.findOne({ couponCode });

      // If coupon is not found, return false
      if (!coupon) {
        return res.json({ success: false, message: "Coupon not found." });
      }

      // Check if the coupon is expired
      const currentDate = new Date();
      if (coupon.endDate < currentDate) {
        return res.json({ success: false, message: "Coupon is expired." });
      }

      // Check if the coupon is active
      if (coupon.status !== "active") {
        return res.json({ success: false, message: "Coupon is inactive." });
      }

      // Check if the purchase amount is greater than the minimum purchase amount specified in the coupon
      if (
        coupon.minimumPurchaseAmount &&
        purchaseAmount < coupon.minimumPurchaseAmount
      ) {
        return res.json({
          success: false,
          message: "Minimum purchase amount not met.",
        });
      }

      // Check if the coupon is applicable for all orders
      if (
        !coupon.applicableCategory &&
        !coupon.applicableSubCategory &&
        !coupon.applicableProduct
      ) {
        return res.json({
          success: true,
          message: "Coupon is applied for all orders.",
          data: coupon,
        });
      }

      // Fetch the products from the database using the provided product IDs
      const products = await Product.find({ _id: { $in: productIds } });

      // Check if any product in the list is not applicable for the coupon
      const isValid = products.every((product) => {
        if (
          coupon.applicableCategory &&
          coupon.applicableCategory.toString() !==
            product.proCategoryId.toString()
        ) {
          return false;
        }
        if (
          coupon.applicableSubCategory &&
          coupon.applicableSubCategory.toString() !==
            product.proSubCategoryId.toString()
        ) {
          return false;
        }
        if (
          coupon.applicableProduct &&
          !product.proVariantId.includes(coupon.applicableProduct.toString())
        ) {
          return false;
        }
        return true;
      });

      if (isValid) {
        return res.json({
          success: true,
          message: "Coupon is applied for the provided product(s).",
          data: coupon,
        });
      } else {
        return res.json({
          success: false,
          message: "Coupon is not applicable for the provided product(s).",
        });
      }
    } catch (error) {
      console.error("Error checking coupon code:", error);
      return res
        .status(500)
        .json({ success: false, message: "Internal server error." });
    }
  })
);

module.exports = router;
