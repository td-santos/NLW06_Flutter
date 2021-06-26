import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class BoletoTileWidget extends StatelessWidget {

  final BoletoModel model;

  const BoletoTileWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(model.name!, style: TextStyles.titleListTile,),
        subtitle: Text('Vence em ${model.dueDate}',
          style: TextStyles.captionBody,),
        trailing: Text.rich(TextSpan(
          text: "R\$ ",
          style: TextStyles.trailingRegular,
          children: [
            TextSpan(
              text: '${model.value!.toStringAsFixed(2)}',
              style: TextStyles.trailingBold
            )
          ]
        )),
      ),
    );
  }
}
