import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/data/data_provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/snack_bar_helper.dart';

class ProfileProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  final box = GetStorage();

  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController couponController = TextEditingController();

  ProfileProvider(this._dataProvider) {
    retrieveSavedAddress();
  }

  void storeAddress() {
    box.write(PHONE_KEY, phoneController.text);
    box.write(STREET_KEY, streetController.text);
    box.write(CITY_KEY, cityController.text);
    box.write(STATE_KEY, stateController.text);
    box.write(POSTAL_CODE_KEY, postalCodeController.text);
    box.write(COUNTRY_KEY, countryController.text);
    SnackBarHelper.showSuccessSnackBar('Address Stored Successfully');
  }

  // Method to retrieve saved address values
  void retrieveSavedAddress() {
    phoneController.text = box.read(PHONE_KEY) ?? '';
    streetController.text = box.read(STREET_KEY) ?? '';
    cityController.text = box.read(CITY_KEY) ?? '';
    stateController.text = box.read(STATE_KEY) ?? '';
    postalCodeController.text = box.read(POSTAL_CODE_KEY) ?? '';
    countryController.text = box.read(COUNTRY_KEY) ?? '';
  }
}
