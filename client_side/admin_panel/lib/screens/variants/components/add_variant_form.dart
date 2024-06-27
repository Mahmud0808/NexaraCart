import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/variant.dart';
import '../../../models/variant_type.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/variant_provider.dart';

class VariantSubmitForm extends StatelessWidget {
  final Variant? variant;

  const VariantSubmitForm({super.key, this.variant});

  @override
  Widget build(BuildContext context) {
    context.variantProvider.setDataForUpdateVariant(variant);

    return SingleChildScrollView(
      child: Form(
        key: context.variantProvider.addVariantsFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<VariantsProvider>(
                      builder: (context, variantProvider, child) {
                        List<VariantType> _sortedVariantTypes =
                            List.from(context.dataProvider.variantTypes);
                        _sortedVariantTypes.sort((a, b) {
                          if (a.name == null && b.name == null) {
                            return 0;
                          } else if (a.name == null) {
                            return 1;
                          } else if (b.name == null) {
                            return -1;
                          } else {
                            return a.name!.compareTo(b.name!);
                          }
                        });

                        return CustomDropdown(
                          initialValue: variantProvider.selectedVariantType,
                          items: _sortedVariantTypes,
                          hintText: 'Select Variant Type',
                          displayItem: (VariantType? variantType) =>
                              variantType?.name ?? '',
                          onChanged: (newValue) {
                            variantProvider.selectedVariantType = newValue;
                            variantProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a Variant Type';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.variantProvider.variantCtrl,
                      labelText: 'Variant Name',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a variant name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context
                          .variantProvider.addVariantsFormKey.currentState!
                          .validate()) {
                        context.variantProvider.addVariantsFormKey.currentState!
                            .save();
                        context.variantProvider.submitVariant();

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the category popup
void showAddVariantForm(BuildContext context, Variant? variant) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Add Variant'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: VariantSubmitForm(variant: variant),
      );
    },
  );
}
