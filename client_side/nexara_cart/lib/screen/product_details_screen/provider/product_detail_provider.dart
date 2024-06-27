import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:nexara_cart/utility/snack_bar_helper.dart';
import 'package:nexara_cart/utility/utility_extention.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';

class ProductDetailProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailProvider(this._dataProvider);

  void addToCart(Product product) {
    if (product.proVariantId!.isNotEmpty && selectedVariant == null) {
      SnackBarHelper.showErrorSnackBar('Please select a variant.');
      return;
    }

    double? price = product.offerPrice != product.price
        ? product.offerPrice
        : product.price;

    flutterCart.addToCart(
        cartModel: CartModel(
      productId: '${product.sId}',
      productName: '${product.name}',
      variants: [
        ProductVariant(
          price: price ?? 0,
          color: selectedVariant,
        )
      ],
      productDetails: '${product.description}',
      productImages: ['${product.images.safeElementAt(0)?.url}'],
    ));

    selectedVariant = null;
    SnackBarHelper.showSuccessSnackBar(
        '${product.name} has been added to cart.');

    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }
}
