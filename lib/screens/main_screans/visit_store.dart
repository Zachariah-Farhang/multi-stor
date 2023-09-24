import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VisitStore extends StatefulWidget {
  final String userId;
  const VisitStore({super.key, required this.userId});

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  CollectionReference customer =
      FirebaseFirestore.instance.collection('suppliers');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: customer.doc(widget.userId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                flexibleSpace:
                    Image.asset('assets/images/inapp/coverimage.jpg'),
              ),
            );
          }

          return Text("loading");
        });
  }
}
