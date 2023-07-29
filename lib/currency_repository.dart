import 'dart:convert';
import 'package:http/http.dart';

class CurrencyRepository {
  final client = Client();
  final baseUrl = 'https://api.metalpriceapi.com/v1/latest?api_key=5cd53bd36052db79255652503c7325f7&base=INR&currencies=XAU,XAG,XPT';

  Future<Map<String, dynamic>> getCurrencySymbols() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      final json = jsonDecode(response.body);
      Map<String, dynamic> data = json['rates'];
      print(data);
      return data;
    }else{
      throw Exception('Faileddddd');
    }
  }
}