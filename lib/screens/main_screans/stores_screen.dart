import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/reuseable_matrial_continer.dart';

import 'visit_store_screen.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({
    super.key,
  });

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final Stream<QuerySnapshot> productsStreem =
      FirebaseFirestore.instance.collection('suppliers').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "فروشگاها ",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: StreamBuilder(
          stream: productsStreem,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemBuilder: ((context, index) {
                  return MaterialReuseableCotiner(
                    imagePath: snapshot.data!.docs[index]['profileImage'],
                    text: snapshot.data!.docs[index]['storeName'],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VisitStore(
                                    userId: snapshot.data!.docs[index]['sid'],
                                  )));
                    },
                  );
                }),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'در حال دریافت اطلاعات',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'اطلاعات یافت نشد در حال بررسی!',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              );
            }
          },
        ));
  }
}
