import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/divider_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/internet_provider.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/snackbarr_widget.dart';
import 'package:path/path.dart' as path;

String mainCagtegory = '';
String subCagtegory = '';
double price = 0.0;
String descount = '';
String qntty = '';
String nameOfProduct = '';
String detielsOfProduct = '';
String proId = '';

class UplodeProduct extends StatefulWidget {
  const UplodeProduct({super.key});

  @override
  State<UplodeProduct> createState() => _UplodeProductState();
}

class _UplodeProductState extends State<UplodeProduct> {
  List<String> images = [];
  List<String> urlOfImages = [];
  final List<DropdownMenuEntry<String>> mainCateg =
      <DropdownMenuEntry<String>>[];
  List<DropdownMenuEntry<String>> subCateg = <DropdownMenuEntry<String>>[];

  String? selectedMianItem = '';
  String? selectedSubItem = '';
  bool uplodingProduct = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> pickImages() async {
    List<XFile> imageFiles = await ImagePicker()
        .pickMultiImage(maxHeight: 400, maxWidth: 400, imageQuality: 80);
    if (imageFiles.isNotEmpty) {
      setState(() {
        images = imageFiles.map((file) => file.path).toList();
      });
    }
  }

  @override
  void initState() {
    for (final String value in maincateg) {
      mainCateg.add(
        DropdownMenuEntry<String>(value: value, label: value),
      );
    }
    subCateg.add(const DropdownMenuEntry(
        value: 'دسته بندی فرعی', label: 'دسته بندی فرعی'));
    super.initState();
  }

  Future<void> uplodProduct() async {
    await uplodImages().whenComplete(() async {
      try {
        if (_formKey.currentState!.validate() && images.isNotEmpty) {
          CollectionReference productRef =
              FirebaseFirestore.instance.collection('products');

          proId = const Uuid().v4();
          await productRef.doc(proId).set({
            'maincatig': mainCagtegory,
            'subcatig': subCagtegory,
            'product_name': nameOfProduct,
            'product_detiels': detielsOfProduct,
            'product_price': price,
            'product_qnnty': qntty,
            'product_descount': descount,
            'proId': proId,
            'sid': FirebaseAuth.instance.currentUser!.uid,
            'product_images': urlOfImages,
          });
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  Future<void> uplodImages() async {
    try {
      if (images.isNotEmpty) {
        if (urlOfImages.isNotEmpty) urlOfImages.clear();
        for (var image in images) {
          Reference ref = FirebaseStorage.instance
              .ref('product-images/${path.basename(image)}');
          await ref.putFile(File(image)).whenComplete(() async {
            await ref.getDownloadURL().then((value) {
              urlOfImages.add(value);
            });
          });
        }
      } else {
        Snackbar(
                key: _scafoldKey,
                content: 'لطفا حد اقل یک عکس برای محصول خود انتخاب کنید')
            .showsnackBar();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ScaffoldMessenger(
      key: _scafoldKey,
      child:
          Consumer<ConnectivityProvider>(builder: (context, connection, child) {
        return Stack(
          children: [
            Scaffold(
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: double.maxFinite,
                                child: images.isEmpty
                                    ? const Center(
                                        child: Text(
                                            'هنوز هیچ تصویری انتخاب نکرده اید!'),
                                      )
                                    : ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: images.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            height: 200,
                                            child: Image.file(
                                              File(images[index]),
                                              fit: BoxFit.contain,
                                            ),
                                          );
                                        }),
                              ),
                              const ReuseableDivider(),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                            'لطفا دسته بندی محصول خود را انتخاب کنید!'),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          DropdownMenu<String>(
                                            label: const Text('دسته بندی اصلی'),
                                            initialSelection: maincateg.first,
                                            dropdownMenuEntries: mainCateg,
                                            onSelected: (String? value) {
                                              setState(() {
                                                selectedMianItem = value!;
                                                mainCagtegory = value;
                                                subCateg = <DropdownMenuEntry<
                                                    String>>[];
                                                switch (value) {
                                                  case 'مردانه':
                                                    for (final String value
                                                        in men) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  case 'زنانه':
                                                    for (final String value
                                                        in women) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  case 'لوازم جانبی':
                                                    for (final String value
                                                        in accessories) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  case 'الکترونیک':
                                                    for (final String value
                                                        in electronics) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }

                                                    break;
                                                  case 'کفش':
                                                    for (final String value
                                                        in shoes) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  case 'خانه و باغ':
                                                    for (final String value
                                                        in homeandgarden) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  case 'زیبایی':
                                                    for (final String value
                                                        in beauty) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  case 'کودکان':
                                                    for (final String value
                                                        in kids) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  case 'کیف و کوله':
                                                    for (final String value
                                                        in bags) {
                                                      subCateg.add(
                                                        DropdownMenuEntry<
                                                                String>(
                                                            value: value,
                                                            label: value),
                                                      );
                                                    }
                                                    break;
                                                  default:
                                                }
                                              });
                                            },
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          DropdownMenu<String>(
                                            label: const Text('دسته بندی فرعی'),
                                            dropdownMenuEntries: subCateg,
                                            onSelected: (String? value) {
                                              setState(() {
                                                selectedSubItem = value!;
                                                subCagtegory = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const ReuseableDivider(),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ResuseableTextField(
                                        fieldName: 'price',
                                        maxLength: 20,
                                        inputType: TextInputType.number,
                                        labelText: 'قیمت',
                                        hintText: '9,9',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: ResuseableTextField(
                                        fieldName: 'descount',
                                        maxLength: 2,
                                        labelText: 'تخفیف ٪',
                                        hintText: 'تخفیف',
                                        inputType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ResuseableTextField(
                                  fieldName: 'covantity',
                                  maxLength: 10,
                                  inputType: TextInputType.number,
                                  labelText: 'تعداد',
                                  hintText: '2',
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ResuseableTextField(
                                  fieldName: 'productName',
                                  maxLength: 100,
                                  inputType: TextInputType.text,
                                  labelText: 'نام محصول',
                                  hintText: 'ساعت',
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ResuseableTextField(
                                  fieldName: 'productDetiels',
                                  maxLength: 1000,
                                  inputType: TextInputType.text,
                                  maxLines: 10,
                                  minLines: 5,
                                  labelText: 'اطلااعات محصول',
                                  hintText:
                                      'این ساعت از برند مشهور و جهانی رولکس است',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          FloatingActionButton(
                              child: uplodingProduct
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Icon(Icons.upload),
                              onPressed: () async {
                                setState(() {
                                  uplodingProduct = true;
                                });
                                await uplodProduct().whenComplete(() {
                                  setState(() {
                                    images.clear();
                                    _formKey.currentState!.reset();
                                    urlOfImages.clear();
                                    uplodingProduct = false;
                                  });
                                });
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          images.isNotEmpty
                              ? FloatingActionButton(
                                  child: const Icon(Icons.delete_forever),
                                  onPressed: () {
                                    setState(() {
                                      images.clear();
                                    });
                                  })
                              : FloatingActionButton(
                                  child: const Icon(Icons.image_rounded),
                                  onPressed: () {
                                    pickImages();
                                  })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!connection.isInternetStable)
              NoInternetScreen(context: context).showModel()
          ],
        );
      }),
    ));
  }
}

String? validateValue(String value, String feildName) {
  RegExp numericStartPattern = RegExp(r'^\d');

  if (value.isEmpty) {
    if (feildName == 'price') {
      return 'لطفا عدد وارد کنید';
    } else if (feildName == 'descount') {
      return 'لطفا عدد وارد کنید';
    } else if (feildName == 'covantity') {
      return 'لطفا عدد وارد کنید';
    } else if (feildName == 'productName') {
      return 'لطفا نام محصول خود را وارد کنید';
    } else if (feildName == 'productDetiels') {
      return 'لطفا اطلاعات محصول خود را وارد کنید';
    }
  } else {
    if (feildName == 'price' && !numericStartPattern.hasMatch(value)) {
      return ' عدد وارد کنید';
    } else if (feildName == 'descount' &&
        !numericStartPattern.hasMatch(value)) {
      return ' عدد وارد کنید';
    } else if (feildName == 'covantity' &&
        !numericStartPattern.hasMatch(value)) {
      return ' عدد وارد کنید';
    }
  }

  return null;
}

class ResuseableTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final int maxLength;
  final TextInputType inputType;
  final int maxLines;
  final int minLines;
  final String fieldName;
  const ResuseableTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.maxLines = 1,
    this.minLines = 1,
    required this.inputType,
    required this.maxLength,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) => validateValue(value!, fieldName),
        onChanged: (value) {
          switch (fieldName) {
            case 'price':
              price = double.parse(value);
              break;
            case 'descount':
              descount = value;

              break;
            case 'productName':
              nameOfProduct = value;

              break;
            case 'covantity':
              qntty = value;

              break;
            case 'productDetiels':
              detielsOfProduct = value;
              break;
            default:
          }
        },
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: inputType,
        buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) =>
            Text("$currentLength/$maxLength"),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        ));
  }
}
