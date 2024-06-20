
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CounterProvider with ChangeNotifier{


  int  _counter = 0;

  int get counter => _counter;

  incrementCounter(){

    _counter++;

    notifyListeners();
  }

  String _productName = '';

  String get productName => _productName;

  List product = [];


  Future<void> getProduct() async{
    try{

      final response = await http.get(Uri.parse('http://192.168.100.26:5000/products'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        // print(data[0]['name']);
        // _productName = data['name'];


        product = data;


        // notifyListeners();
      }
      else{
        print(response.statusCode);
      }




    }
    catch(e){
      print(e.toString());
    }
  }

  addProduct(BuildContext context,String name, String price, String quantity) async{
    try{
      final response = await http.post(Uri.parse('http://192.168.100.26:5000/products'),headers: {
        'Content-Type': 'application/json'
      },body: jsonEncode({
        'id': 8,
        'name': name,
        'price': price,
        'quantity': quantity
      }));

      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Added Successfully')));
      }
      else{
        debugPrint(response.statusCode.toString());
      }

    }
    catch(e){
      debugPrint(e.toString());
    }
  }

}



//
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class CounterProvider with ChangeNotifier {
//   int _counter = 0;
//   int get counter => _counter;
//
//   incrementCounter() {
//     _counter++;
//     notifyListeners();
//   }
//
//   String _productName = '';
//   String get productName => _productName;
//
//   List<Map<String, dynamic>> _products = [];
//   List<Map<String, dynamic>> get products => _products;
//
//   // StreamController to handle the stream of product data
//   final StreamController<List<Map<String, dynamic>>> _streamController =
//   StreamController<List<Map<String, dynamic>>>();
//
//   // Constructor to initialize the stream with empty product list
//   CounterProvider() {
//     _streamController.add(_products);
//   }
//
//   // Method to fetch products from the server
//   Future<void> fetchProducts() async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.100.26:5000/products'));
//       if (response.statusCode == 200) {
//         List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
//         _products = data;
//
//         // Notify listeners about the change in product list
//         _streamController.add(_products);
//       } else {
//         print('Failed to load products: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching products: $e');
//     }
//   }
//
//   // Method to add a product
//   Future<void> addProduct(BuildContext context, String name, String price, String quantity) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.100.26:3000/products'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'name': name,
//           'price': price,
//           'quantity': quantity,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         // If the product is added successfully, fetch updated product list
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Added Successfully')));
//       } else {
//         print('Failed to add product: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error adding product: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }
// }
