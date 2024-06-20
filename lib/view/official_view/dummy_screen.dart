
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/view_model/contract_linking.dart';
import 'package:fyp/view_model/counter_provider.dart';
import 'package:provider/provider.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();


  StreamController<List<Map<String, String>>> _streamController =
  StreamController<List<Map<String, String>>>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contractLinking = Provider.of<ContractLinking>(context);
    final counter = Provider.of<CounterProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [
              Text("DAPP"),

              Text(contractLinking.deployedName.toString()),

              ElevatedButton(onPressed: (){
                contractLinking.setMessage("This is Dapp");
              }, child: Text("Set Message")),


              Form(child: Column(children: [

                Padding(

                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                        hintText: 'Enter price',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                        hintText: 'Enter quantity',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),

                ElevatedButton(onPressed: (){
                  if(nameController.text == '' || priceController.text == '' || quantityController.text == ''){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter all fields")));
                  }
                  else {
                    counter.addProduct(context, nameController.text,
                        priceController.text, quantityController.text);

                    setState(() {

                    });
                  }
                }, child: Text('Add Product'))

              ],)),

              Expanded(
                child: FutureBuilder(
                  future: counter.getProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Show loading indicator while fetching data
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}')); // Show error message if fetching data fails
                    } else {
                      // If data is successfully fetched, display it in a ListView.builder
                      return ListView.builder(
                        itemCount: counter.product.length,
                        itemBuilder: (context, index) {
                          final product = counter.product[index];
                          return ListTile(
                            title: Text(product['name']),
                            subtitle: Text('Price: ${product['price']}'),
                            // Add more widgets to display additional product information
                          );
                        },
                      );
                    }
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


//
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:fyp/view_model/contract_linking.dart';
// import 'package:fyp/view_model/counter_provider.dart';
// import 'package:provider/provider.dart';
//
// class DummyScreen extends StatefulWidget {
//   const DummyScreen({super.key});
//
//   @override
//   State<DummyScreen> createState() => _DummyScreenState();
// }
//
// class _DummyScreenState extends State<DummyScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//
//   StreamController<List<Map<String, String>>> _streamController =
//   StreamController<List<Map<String, String>>>();
//
//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final contractLinking = Provider.of<ContractLinking>(context);
//     final counter = Provider.of<CounterProvider>(context);
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Text("DAPP"),
//               Text(contractLinking.deployedName.toString()),
//               ElevatedButton(
//                 onPressed: () {
//                   contractLinking.setMessage("This is Dapp");
//                 },
//                 child: Text("Set Message"),
//               ),
//               Form(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextFormField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter name',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextFormField(
//                         controller: priceController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter price',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextFormField(
//                         controller: quantityController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter quantity',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (nameController.text == '' ||
//                             priceController.text == '' ||
//                             quantityController.text == '') {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text("Please enter all fields")),
//                           );
//                         } else {
//                           counter.addProduct(
//                             context,
//                             nameController.text,
//                             priceController.text,
//                             quantityController.text,
//                           );
//                           setState(() {});
//                         }
//                       },
//                       child: Text('Add Product'),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: StreamBuilder<List<Map<String, String>>>(
//                   stream: _streamController.stream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text('Error: ${snapshot.error}'),
//                       );
//                     } else {
//                       // If data is successfully fetched, display it in a ListView.builder
//                       return ListView.builder(
//                         itemCount: snapshot.data?.length,
//                         itemBuilder: (context, index) {
//                           final product = snapshot.data?[index];
//                           return ListTile(
//                             title: Text(product?['name'] ?? ''),
//                             subtitle: Text('Price: ${product?['price'] ?? ''}'),
//                             // Add more widgets to display additional product information
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
