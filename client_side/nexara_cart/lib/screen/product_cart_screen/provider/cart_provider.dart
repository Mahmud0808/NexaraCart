import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nexara_cart/models/api_response.dart';
import 'package:nexara_cart/utility/utility_extention.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../models/coupon.dart';
import '../../../services/http_services.dart';
import '../../../utility/constants.dart';
import '../../../utility/snack_bar_helper.dart';
import '../../auth_screen/provider/user_provider.dart';

class CartProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final box = GetStorage();
  Razorpay razorpay = Razorpay();
  final UserProvider _userProvider;
  var flutterCart = FlutterCart();
  List<CartModel> myCartItems = [];

  final GlobalKey<FormState> buyNowFormKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  bool isExpanded = false;

  Coupon? couponApplied;
  double couponCodeDiscount = 0;
  String selectedPaymentOption = PAYMENT_METHOD_COD;

  CartProvider(this._userProvider);

  void updateCart(CartModel cartItem, int quantity) {
    quantity = cartItem.quantity + quantity;
    flutterCart.updateQuantity(cartItem.productId, cartItem.variants, quantity);

    notifyListeners();
  }

  double getCartSubTotal() {
    return flutterCart.subtotal;
  }

  double getGrandTotal() {
    return getCartSubTotal() - couponCodeDiscount;
  }

  getCartItems() {
    myCartItems = flutterCart.cartItemsList;

    notifyListeners();
  }

  clearCartItems() {
    flutterCart.clearCart();

    notifyListeners();
  }

  checkCoupon() async {
    try {
      if (couponController.text.isEmpty) {
        SnackBarHelper.showErrorSnackBar('Enter a coupon code.');
        return;
      }

      List<String> productIds =
          myCartItems.map((cartItem) => cartItem.productId).toList();

      Map<String, dynamic> couponData = {
        'couponCode': couponController.text,
        'purchaseAmount': getCartSubTotal(),
        'productIds': productIds,
      };

      final response = await service.addItem(
          endpointUrl: 'couponCodes/check-coupon', itemData: couponData);

      if (response.isOk) {
        final ApiResponse<Coupon> apiResponse = ApiResponse<Coupon>.fromJson(
            response.body,
            (json) => Coupon.fromJson(json as Map<String, dynamic>));

        if (apiResponse.success == true) {
          Coupon? coupon = apiResponse.data;

          if (coupon != null) {
            couponApplied = coupon;
            couponCodeDiscount = getCouponDiscountAmount(coupon);
          }

          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('coupon is valid');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to validate coupon: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }

      notifyListeners();
    } catch (e) {
      log(e.toString());
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  double getCouponDiscountAmount(Coupon coupon) {
    String discountType = coupon.discountType ?? 'fixed';

    if (discountType == 'fixed') {
      return coupon.discountAmount ?? 0;
    } else {
      double discountPercentage = coupon.discountAmount ?? 0;
      double amountAfterDiscountPercentage =
          getCartSubTotal() * (discountPercentage / 100);
      return amountAfterDiscountPercentage;
    }
  }

  Future<String?> submitOrder() async {
    if (selectedPaymentOption == PAYMENT_METHOD_COD) {
      return await addOrder();
    } else {
      return await stripePayment(operation: () async {
        return await addOrder();
      });
    }
  }

  Future<String?> addOrder() async {
    try {
      Map<String, dynamic> order = {
        'userID': _userProvider.getLoginUsr()?.sId ?? '',
        'orderStatus': ORDER_STATUS_PENDING,
        'items': cartItemToOrderItem(myCartItems),
        'totalPrice': getCartSubTotal(),
        'shippingAddress': {
          'phone': phoneController.text,
          'street': streetController.text,
          'city': cityController.text,
          'state': stateController.text,
          'postalCode': postalCodeController.text,
          'country': countryController.text
        },
        'paymentMethod': selectedPaymentOption,
        'couponCode': couponApplied?.sId,
        'orderTotal': {
          'subTotal': getCartSubTotal(),
          'discount': couponCodeDiscount,
          'total': getGrandTotal()
        }
      };

      final response =
          await service.addItem(endpointUrl: 'orders', itemData: order);

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          log('order added');
          return null;
        } else {
          return 'Failed to order: ${apiResponse.message}';
        }
      } else {
        return 'Error: ${response.body?['message'] ?? response.statusText}';
      }
    } catch (e) {
      log(e.toString());
      return 'An error occurred: $e';
    }
  }

  List<Map<String, dynamic>> cartItemToOrderItem(List<CartModel> cartItems) {
    return cartItems
        .map((cartItem) => {
              'productID': cartItem.productId,
              'productName': cartItem.productName,
              'quantity': cartItem.quantity,
              'price': cartItem.variants.safeElementAt(0)?.price ?? 0,
              'variant': cartItem.variants.safeElementAt(0)?.color ?? ''
            })
        .toList();
  }

  clearCouponDiscount() {
    couponApplied = null;
    couponCodeDiscount = 0;
    couponController.text = '';
    notifyListeners();
  }

  void retrieveSavedAddress() {
    phoneController.text = box.read(PHONE_KEY) ?? '';
    streetController.text = box.read(STREET_KEY) ?? '';
    cityController.text = box.read(CITY_KEY) ?? '';
    stateController.text = box.read(STATE_KEY) ?? '';
    postalCodeController.text = box.read(POSTAL_CODE_KEY) ?? '';
    countryController.text = box.read(COUNTRY_KEY) ?? '';
  }

  Future<String?> stripePayment(
      {required Future<String?> Function() operation}) async {
    try {
      Map<String, dynamic> paymentData = {
        "email": _userProvider.getLoginUsr()?.name,
        "name": _userProvider.getLoginUsr()?.name,
        "address": {
          "line1": streetController.text,
          "city": cityController.text,
          "state": stateController.text,
          "postal_code": postalCodeController.text,
          "country": "US"
        },
        "amount": getGrandTotal() * 100,
        "currency": "usd",
        "description": "Your transaction description here"
      };

      Response response = await service.addItem(
          endpointUrl: 'payment/stripe', itemData: paymentData);

      final data = await response.body;
      final paymentIntent = data['paymentIntent'];
      final ephemeralKey = data['ephemeralKey'];
      final customer = data['customer'];
      final publishableKey = data['publishableKey'];

      Stripe.publishableKey = publishableKey;

      BillingDetails billingDetails = BillingDetails(
        email: _userProvider.getLoginUsr()?.name,
        phone: '91234123908',
        name: _userProvider.getLoginUsr()?.name,
        address: Address(
            country: 'US',
            city: cityController.text,
            line1: streetController.text,
            line2: stateController.text,
            postalCode: postalCodeController.text,
            state: stateController.text
            // Other address details
            ),
        // Other billing details
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'MOBIZATE',
          paymentIntentClientSecret: paymentIntent,
          customerEphemeralKeySecret: ephemeralKey,
          customerId: customer,
          style: ThemeMode.light,
          billingDetails: billingDetails,
          // googlePay: const PaymentSheetGooglePay(
          //   merchantCountryCode: 'US',
          //   currencyCode: 'usd',
          //   testEnv: true,
          // ),
          // applePay: const PaymentSheetApplePay(merchantCountryCode: 'US')
        ),
      );

      await Stripe.instance.presentPaymentSheet().then((value) {
        log('payment success');
        //? do the success operation
        return operation();
      }).onError((error, stackTrace) {
        if (error is StripeException) {
          return 'Error: ${error.error.localizedMessage}';
        } else {
          return 'Stripe Error: $error';
        }
      });
    } catch (e) {
      log(e.toString());
      return 'An error occurred: $e';
    }

    return null;
  }

  Future<String?> razorpayPayment(
      {required Future<String?> Function() operation}) async {
    try {
      Response response =
          await service.addItem(endpointUrl: 'payment/razorpay', itemData: {});

      final data = await response.body;
      String? razorpayKey = data['key'];

      if (razorpayKey != null && razorpayKey != '') {
        var options = {
          'key': razorpayKey,
          'amount': getGrandTotal() * 100,
          'name': "user",
          "currency": 'INR',
          'description': 'Your transaction description',
          'send_sms_hash': true,
          "prefill": {
            "email": _userProvider.getLoginUsr()?.name,
            "contact": ''
          },
          "theme": {'color': '#4A77FF'},
          "image":
              'https://store.rapidflutter.com/digitalAssetUpload/rapidlogo.png',
        };

        razorpay.open(options);
        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
            (PaymentSuccessResponse response) {
          log('payment success');
          //? do the success operation
          return operation();
        });
        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
            (PaymentFailureResponse response) {
          log('payment failed');
          return 'Error: ${response.message}';
        });
      }
    } catch (e) {
      log(e.toString());
      return 'An error occurred: $e';
    }

    return null;
  }

  void updateUI() {
    notifyListeners();
  }
}
