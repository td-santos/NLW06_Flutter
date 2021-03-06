import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {

  final String? barcode;

  const InsertBoletoPage({ Key? key, this.barcode }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {

  final controller = InsertBoletoController();

  final moneyInputTextContoller = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ","
    );
  
  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.barcode != null){
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.input,),
      ),
      body: SingleChildScrollView (
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93,),
                child: Text('Preencha od dados do boleto',
                  textAlign: TextAlign.center,
                  style: TextStyles.titleBoldHeading,
                ),
              ),
              SizedBox(height: 24,),
              Form(
                key: controller.formkey,
                child: Column(
                  children: [
                    InputTextWidget(
                label: 'Nome do boleto',
                validator: controller.vaidateName,
                icon: Icons.description_outlined,
                onChanged: (value){
                  controller.onChange(name: value);
                },
              ),

              InputTextWidget(
                controller: dueDateInputTextController,
                label: 'Vencimento',
                validator: controller.vaidateVencimento,
                icon: FontAwesomeIcons.timesCircle,
                onChanged: (value){
                  controller.onChange(dueDate: value);
                },
              ),

              InputTextWidget(
                controller: moneyInputTextContoller,
                label: 'Valor',
                validator: (_) => controller.vaidateValor(moneyInputTextContoller.numberValue),
                icon: Icons.account_balance_wallet_outlined,
                onChanged: (value){
                  controller.onChange(value: moneyInputTextContoller.numberValue);
                },
              ),

              InputTextWidget(
                controller: barcodeInputTextController,
                label: 'C??digo',
                validator: controller.vaidateCodigo,
                icon: FontAwesomeIcons.barcode,
                onChanged: (value){
                  controller.onChange(barcode: value);
                },
              )
                  ],
                )
                
              )
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: 'Cancelar', 
        primaryOnPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }, 
        secondaryLabel: 'Cadastrar', 
        secondaryOnPressed: ()async{
          await controller.cadastrarBoleto();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      ),
    );
  }
}