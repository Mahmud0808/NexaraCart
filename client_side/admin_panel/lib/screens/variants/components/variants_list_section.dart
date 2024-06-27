import 'package:admin/utility/extensions.dart';
import 'package:admin/utility/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/variant.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import 'add_variant_form.dart';

class VariantsListSection extends StatelessWidget {
  const VariantsListSection({
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
                  label: Text("Variant"),
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
                dataProvider.variants.length,
                (index) => variantDataRow(
                    context, dataProvider.variants[index], index + 1, edit: () {
                  showAddVariantForm(context, dataProvider.variants[index]);
                }, delete: () {
                  context.variantProvider
                      .deleteVariant(dataProvider.variants[index]);
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

DataRow variantDataRow(BuildContext context, Variant VariantInfo, int index,
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
              child: Text(VariantInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(VariantInfo.variantTypeId?.name ?? '')),
      DataCell(Text(formatTimestamp(context, VariantInfo.createdAt))),
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
