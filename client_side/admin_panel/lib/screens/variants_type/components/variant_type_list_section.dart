import 'package:admin/utility/extensions.dart';
import 'package:admin/utility/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/variant_type.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import 'add_variant_type_form.dart';

class VariantsTypeListSection extends StatelessWidget {
  const VariantsTypeListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Consumer<DataProvider>(
          builder: (context, dataProvider, child) {
            return DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Variant Name"),
                ),
                DataColumn(
                  label: Text("Variant Type"),
                ),
                DataColumn(
                  label: Text("Added Date"),
                ),
                DataColumn(
                  label: Text("Edit"),
                ),
                DataColumn(
                  label: Text("Delete"),
                ),
              ],
              rows: List.generate(
                dataProvider.variantTypes.length,
                (index) => variantTypeDataRow(
                  context,
                  dataProvider.variantTypes[index],
                  index + 1,
                  edit: () {
                    showAddVariantsTypeForm(
                        context, dataProvider.variantTypes[index]);
                  },
                  delete: () {
                    context.variantTypeProvider
                        .deleteVariantType(dataProvider.variantTypes[index]);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

DataRow variantTypeDataRow(
    BuildContext context, VariantType VariantTypeInfo, int index,
    {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(
                index.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(VariantTypeInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(VariantTypeInfo.type ?? '')),
      DataCell(Text(formatTimestamp(context, VariantTypeInfo.createdAt) ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
