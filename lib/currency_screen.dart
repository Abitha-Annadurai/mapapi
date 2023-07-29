import 'dart:io';

import 'currency_repository.dart';
import 'package:flutter/material.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  Map<String, dynamic> selectedValue = {};

  Future<Map<String, dynamic>> getCurrencies() async {
    try{
      Map<String, dynamic> currency = await CurrencyRepository().
      getCurrencySymbols();
      if(currency.isNotEmpty){
        setState(() => selectedValue = currency);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Something wwents wrong')));
      }
      return currency;
    }on SocketException catch(_){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No internet connection')));
      rethrow;
    }
  }


  @override
  void initState() {
    super.initState();
    getCurrencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedValue.isEmpty ?
      Center(child: CircularProgressIndicator()) :
      ListView(
        children: List.generate(
            selectedValue.length,
                (index) => Column(
                  children: selectedValue.entries.map((e) => ListTile(
                    leading: CircleAvatar(
                      child: Text(e.key),
                    ),
                    title: Text(e.value.toString()),
                  )).toList()
                ))
      ),
    );
  }
}
