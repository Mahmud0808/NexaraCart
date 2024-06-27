const mongoose = require("mongoose");

const variantSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    variantTypeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "VariantType",
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Variant", variantSchema);
