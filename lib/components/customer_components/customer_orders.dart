import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/widgets/app_bar_back_button_widget.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';
import 'package:provider/provider.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({super.key});

  @override
  State<CustomerOrders> createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  CollectionReference? collection;
  String userId = '';
  String userName = '';
  String phoneNumber = '';
  String email = '';
  String address = '';

  void getData() {
    try {
      userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseAuth.instance.currentUser!.isAnonymous
          ? collection = FirebaseFirestore.instance.collection('anonymous')
          : collection = FirebaseFirestore.instance.collection('customers');

      collection!.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
        if (mounted) {
          if (documentSnapshot.exists) {
            var data = documentSnapshot.data() as Map<String, dynamic>;
            setState(() {
              userName = data['name'];
              phoneNumber = data['phone'];
              email = data['email'];
              address = data['address'];
            });
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'سفارشات',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          leading: const AppBarBackButton(color: Colors.black87),
        ),
        bottomSheet: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ReuseableButton(
                  color: Colors.amber,
                  child: Text('محاصبه'),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        body: Consumer<Cart>(builder: (context, cart, child) {
          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('نام مشتری : $userName'),
                  Text('شماره تماس مشتری : $phoneNumber'),
                  Text('آدرس مشتری :$address'),
                  Text('آدرس ایمیل مشتری :$email'),
                ],
              ),
              Expanded(child: Container())
            ],
          );
        }),
      ),
    );
  }
}
