import 'dart:developer';

import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';

import '../../../models/category.dart';
import '../../models/brand.dart';
import '../../models/coupon.dart';
import '../../models/my_notification.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/sub_category.dart';
import '../../models/variant.dart';
import '../../models/variant_type.dart';
import '../../services/http_services.dart';
import '../../utility/constants.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];

  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];

  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];

  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];

  List<Variant> get variants => _filteredVariants;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts;

  String _filteredProductsType = ALL_PRODUCTS;

  String get productsType => _filteredProductsType;

  List<Coupon> _allCoupons = [];
  List<Coupon> _filteredCoupons = [];

  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];

  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];

  List<Order> get orders => _filteredOrders;

  List<MyNotification> _allNotifications = [];
  List<MyNotification> _filteredNotifications = [];

  List<MyNotification> get notifications => _filteredNotifications;

  DataProvider() {
    getAllProducts();
    getAllCategories();
    getAllSubCategories();
    getAllBrands();
    getAllVariantTypes();
    getAllVariants();
    getAllPosters();
    getAllCoupons();
    getAllOrders();
    getAllNotifications();
  }

  Future<List<Category>> getAllCategories({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');

      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Category.fromJson(item)).toList(),
        );

        _allCategories = apiResponse.data ?? [];
        _filteredCategories =
            List.from(_allCategories); // copy of _allCategories

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredCategories;
  }

  void filterCategories(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<List<SubCategory>> getAllSubCategories(
      {bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'subCategories');

      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => SubCategory.fromJson(item)).toList(),
        );

        _allSubCategories = apiResponse.data ?? [];
        _filteredSubCategories =
            List.from(_allSubCategories); // copy of _allSubCategories

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredSubCategories;
  }

  void filterSubCategories(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();
      _filteredSubCategories = _allSubCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'brands');

      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(
          response.body,
          (json) => (json as List).map((item) => Brand.fromJson(item)).toList(),
        );

        _allBrands = apiResponse.data ?? [];
        _filteredBrands = List.from(_allBrands); // copy of _allBrands

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredBrands;
  }

  void filterBrands(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();
      _filteredBrands = _allBrands.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<List<VariantType>> getAllVariantTypes({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'variantTypes');

      if (response.isOk) {
        ApiResponse<List<VariantType>> apiResponse =
            ApiResponse<List<VariantType>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => VariantType.fromJson(item)).toList(),
        );

        _allVariantTypes = apiResponse.data ?? [];
        _filteredVariantTypes =
            List.from(_allVariantTypes); // copy of _allVariantTypes

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredVariantTypes;
  }

  void filterVariantTypes(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredVariantTypes = List.from(_allVariantTypes);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();
      _filteredVariantTypes = _allVariantTypes.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<List<Variant>> getAllVariants({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'variants');

      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
            ApiResponse<List<Variant>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Variant.fromJson(item)).toList(),
        );

        _allVariants = apiResponse.data ?? [];
        _filteredVariants = List.from(_allVariants); // copy of _allVariants

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredVariants;
  }

  void filterVariants(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredVariants = List.from(_allVariants);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();
      _filteredVariants = _allVariants.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<List<Product>> getAllProducts({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'products');

      if (response.isOk) {
        ApiResponse<List<Product>> apiResponse =
            ApiResponse<List<Product>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Product.fromJson(item)).toList(),
        );

        _allProducts = apiResponse.data ?? [];
        _filteredProducts = List.from(_allProducts); // copy of _allProducts

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredProducts;
  }

  void filterProducts(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();

      _filteredProducts = _allProducts.where((product) {
        final productNameContainsKeyword =
            (product.name ?? '').toLowerCase().contains(lowerKeyword);
        final categoryNameContainsKeyword =
            product.proCategoryId?.name?.toLowerCase().contains(lowerKeyword) ??
                false;
        final subCategoryNameContainsKeyword = product.proSubCategoryId?.name
                ?.toLowerCase()
                .contains(lowerKeyword) ??
            false;

        return productNameContainsKeyword ||
            categoryNameContainsKeyword ||
            subCategoryNameContainsKeyword;
      }).toList();
    }

    notifyListeners();
  }

  Future<List<Coupon>> getAllCoupons({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'couponCodes');

      if (response.isOk) {
        ApiResponse<List<Coupon>> apiResponse =
            ApiResponse<List<Coupon>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Coupon.fromJson(item)).toList(),
        );

        _allCoupons = apiResponse.data ?? [];
        _filteredCoupons = List.from(_allCoupons); // copy of _allCoupons

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredCoupons;
  }

  void filterCoupons(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredCoupons = List.from(_allCoupons);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();
      _filteredCoupons = _allCoupons.where((coupon) {
        return (coupon.couponCode ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'posters');

      if (response.isOk) {
        ApiResponse<List<Poster>> apiResponse =
            ApiResponse<List<Poster>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Poster.fromJson(item)).toList(),
        );

        _allPosters = apiResponse.data ?? [];
        _filteredPosters = List.from(_allPosters); // copy of _allPosters

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }

    return _filteredPosters;
  }

  void filterPosters(String keyword) {
    keyword = keyword.trim();

    if (keyword.isEmpty) {
      _filteredPosters = List.from(_allPosters);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();
      _filteredPosters = _allPosters.where((poster) {
        return (poster.posterName ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<List<MyNotification>> getAllNotifications(
      {bool showSnack = false}) async {
    try {
      Response response =
          await service.getItems(endpointUrl: 'notification/all-notification');

      if (response.isOk) {
        ApiResponse<List<MyNotification>> apiResponse =
            ApiResponse<List<MyNotification>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => MyNotification.fromJson(item))
                    .toList());

        _allNotifications = apiResponse.data ?? [];
        _filteredNotifications = List.from(_allNotifications);

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      log(e.toString());
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      }
      rethrow;
    }

    return _filteredNotifications;
  }

  void filterNotifications(String keyword) {
    if (keyword.isEmpty) {
      _filteredNotifications = List.from(_allNotifications);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();

      _filteredNotifications = _allNotifications
          .where((notification) =>
              (notification.title ?? '').toLowerCase().contains(lowerKeyword))
          .toList();
    }

    notifyListeners();
  }

  Future<List<Order>> getAllOrders({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'orders');

      if (response.isOk) {
        ApiResponse<List<Order>> apiResponse =
            ApiResponse<List<Order>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Order.fromJson(item))
                    .toList());

        print(apiResponse.message);

        _allOrders = apiResponse.data ?? [];
        _filteredOrders = List.from(_allOrders);

        notifyListeners();

        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      print(e);
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      }
      rethrow;
    }

    return _filteredOrders;
  }

  void filterOrders(String keyword) {
    if (keyword.isEmpty) {
      _filteredOrders = List.from(_allOrders);
    } else {
      final lowerKeyword = keyword.trim().toLowerCase();

      _filteredOrders = _allOrders.where((order) {
        bool nameMatches =
            (order.userID?.name ?? '').toLowerCase().contains(lowerKeyword);
        bool statusMatches =
            (order.orderStatus ?? '').toLowerCase().contains(lowerKeyword);

        return nameMatches || statusMatches;
      }).toList();
    }

    notifyListeners();
  }

  int calculateOrdersWithStatus({String? status}) {
    int totalOrders = 0;

    if (status == null) {
      totalOrders = _allOrders.length;
    } else {
      for (Order order in _allOrders) {
        if (order.orderStatus == status) {
          totalOrders++;
        }
      }
    }

    return totalOrders;
  }

  void filterProductsByQuantity(String productQntType,
      {bool showSnack = false}) {
    _filteredProductsType =
        productQntType.isEmpty ? ALL_PRODUCTS : productQntType;

    if (productQntType == ALL_PRODUCTS) {
      _filteredProducts = List.from(_allProducts);
    } else if (productQntType == STOCK_OUT_PRODUCTS) {
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity == 0;
      }).toList();
    } else if (productQntType == LIMITED_STOCK_PRODUCTS) {
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity == 1;
      }).toList();
    } else if (productQntType == OTHER_PRODUCTS) {
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null &&
            product.quantity != 0 &&
            product.quantity != 1;
      }).toList();
    } else {
      _filteredProducts = List.from(_allProducts);
    }

    if (showSnack) {
      SnackBarHelper.showSuccessSnackBar(
          '${_filteredProductsType} retrieved successfully!');
    }

    notifyListeners();
  }

  int calculateProductWithQuantity({int? quantity}) {
    int totalProducts = 0;

    if (quantity == null) {
      totalProducts = _allProducts.length;
    } else {
      for (Product product in _allProducts) {
        if (product.quantity != null && product.quantity == quantity) {
          totalProducts++;
        }
      }
    }

    return totalProducts;
  }
}
