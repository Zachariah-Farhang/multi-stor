import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../screens/minor_screens/search.dart';

class SearchBottom extends StatelessWidget {
  const SearchBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScreen()));
      },
      child: Container(
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.yellow, width: 1.4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  AutoSizeText(
                    'دنبال چی میگردی؟',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 32,
                width: 75,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(25)),
                child: const Center(
                  child: AutoSizeText(
                    'جستجو',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
