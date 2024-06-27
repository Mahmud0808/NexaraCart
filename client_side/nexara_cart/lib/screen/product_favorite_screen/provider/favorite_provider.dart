import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nexara_cart/utility/constants.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  final box = GetStorage();
  List<Product> favoriteProduct = [];

  FavoriteProvider(this._dataProvider);

  updateToFavoriteList(String productId) {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];

    if (favoriteList.contains(productId)) {
      favoriteList.remove(productId);
    } else {
      favoriteList.add(productId);
    }

    box.write(FAVORITE_PRODUCT_BOX, favoriteList);
    loadFavoriteItems();

    notifyListeners();
  }

  bool checkIsItemFavorite(String productId) {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    bool isExist = favoriteList.contains(productId);
    return isExist;
  }

  void loadFavoriteItems() {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];

    favoriteProduct = _dataProvider.products
        .where((product) => favoriteList.contains(product.sId))
        .toList();

    notifyListeners();
  }

  clearFavoriteList() {
    box.remove(FAVORITE_PRODUCT_BOX);
  }
}
