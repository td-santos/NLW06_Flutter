import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController{

  final formkey = GlobalKey<FormState>();
  BoletoModel boletoModel = BoletoModel();

  String? vaidateName(String? value) => 
    value?.isEmpty ?? true ? "O nome nao pode ser vazio" : null;

  String? vaidateVencimento(String? value) => 
    value?.isEmpty ?? true ? "A data de vencimento nao pode ser vazio" : null;

  String? vaidateValor(double value) => 
    value == 0  ? "Insira um valor maior que R\$ 0,00" : null;

  String? vaidateCodigo(String? value) => 
    value?.isEmpty ?? true ?"O código do boleto não pode ser vazio" : null;



  Future<void> cadastrarBoleto()async{
    final form = formkey.currentState;
    if(form!.validate()){
      return await saveBoleto();
    }
  }

  Future<void> saveBoleto()async{
    try{
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList("boletos") ?? <String>[];
      boletos.add(boletoModel.toJson());
      await instance.setStringList('boletos', boletos);
      return;
    }catch (e){

    }
  }

  void onChange({String? name, String? dueDate, double? value, String? barcode}){
    boletoModel = boletoModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }
}