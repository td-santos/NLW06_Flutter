import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final boletoListController = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(TextSpan(
                  text: 'Olá, ',
                  style: TextStyles.titleRegular,
                  children: [
                    TextSpan(
                        text: '${widget.user.name}',
                        style: TextStyles.titleBoldBackground)
                  ])),
              subtitle: Text(
                'Mantenha sua contas em dia',
                style: TextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(widget.user.photoUrl!))),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: [
          
          MeusBoletosPage(
            key: UniqueKey(),
          ),
          ExtractPage(
            key: UniqueKey(),
          ),
        ][homeController.currentPage],
      ),
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: homeController.currentPage == 0
                      ? AppColors.primary
                      : AppColors.body,
                ),
                onPressed: () {
                  homeController.setPage(0);
                  setState(() {});
                }),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, "/barcode_scanner");
                setState(() {});
                //Navigator.pushNamed(context, "/insert_boleto");
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.description_outlined,
                  color: homeController.currentPage == 1
                      ? AppColors.primary
                      : AppColors.body,
                ),
                onPressed: () {
                  homeController.setPage(1);
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
