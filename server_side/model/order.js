const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema({
  userID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  orderDate: {
    type: Date,
    default: Date.now,
  },
  orderStatus: {
    type: String,
    enum: ["Pending", "Processing", "Shipped", "Delivered", "Cancelled"],
    default: "Pending",
  },
  items: [
    {
      productID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
        required: true,
      },
      productName: {
        type: String,
        required: true,
      },
      quantity: {
        type: Number,
        required: true,
      },
      price: {
        type: Number,
        required: true,
      },
      variant: {
        type: String,
      },
    },
  ],
  totalPrice: {
    type: Number,
    required: true,
  },
  shippingAddress: {
    phone: String,
    street: String,
    city: String,
    state: String,
    postalCode: String,
    country: String,
  },

  paymentMethod: {
    type: String,
    enum: ["COD", "Prepaid"],
  },

  couponCode: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Coupon",
  },
  orderTotal: {
    subTotal: Number,
    discount: Number,
    total: Number,
  },
  trackingUrl: {
    type: String,
  },
});

const Order = mongoose.model("Order", orderSchema);

module.exports = Order;
