import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexara_cart/utility/constants.dart';

import '../../../utility/functions.dart';

class ProductRatingSection extends StatelessWidget {
  const ProductRatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          initialRating: 3.2,
          direction: Axis.horizontal,
          itemBuilder: (_, __) => const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          onRatingUpdate: (_) {},
          allowHalfRating: true,
          itemSize: 28,
        ),
        const Spacer(),
        Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              "(${formatCurrency(context, 4500).replaceFirst(CURRENCY_SYMBOL, '')} Reviews)",
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
