import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/reuseable_bottun.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: 140,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  centerTitle: true,
                  title: AnimatedOpacity(
                    opacity: constraints.biggest.height <= 100 ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Text(
                      'پروفایل',
                      style: TextStyle(color: Colors.black87, fontSize: 29),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  background: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                    Colors.yellow,
                    Colors.brown,
                  ]))),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableCotiner(
                      text: "سبدخرید",
                      decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      onPressed: () {},
                    ),
                    ReusableCotiner(
                      text: "سفارشات",
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                      ),
                      onPressed: () {},
                    ),
                    ReusableCotiner(
                      text: "موردعلاقه ها",
                      decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 150,
                child: Image(
                  image: AssetImage("assets/images/tabImages/bags.png"),
                ),
              ),
              const ReuseableSizedBox(
                text: "اطلاعات حساب",
              ),
              Container(
                margin: const EdgeInsets.all(8),
                height: 260,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: const Column(
                  children: [
                    ReusableListTile(
                      title: "ایمیل آدرس",
                      subTitle: "example@gmail.com",
                      icon: Icons.email,
                    ),
                    ReuseableDivider(),
                    ReusableListTile(
                      title: "شماره تماس",
                      subTitle: "+۹۳۷۹۲۱۲۳۴۵۶",
                      icon: Icons.phone,
                    ),
                    ReuseableDivider(),
                    ReusableListTile(
                      title: "آدرس",
                      subTitle: "شهرنو،مارکت حضرتها،درب شیشم",
                      icon: Icons.location_on,
                    ),
                  ],
                ),
              ),
              const ReuseableSizedBox(text: "تنظیمات حساب"),
              Container(
                margin: const EdgeInsets.all(8),
                height: 260,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: const Column(
                  children: [
                    ReusableListTile(
                      title: "ایمیل آدرس",
                      subTitle: "example@gmail.com",
                      icon: Icons.email,
                    ),
                    ReuseableDivider(),
                    ReusableListTile(
                      title: "شماره تماس",
                      subTitle: "+۹۳۷۹۲۱۲۳۴۵۶",
                      icon: Icons.phone,
                    ),
                    ReuseableDivider(),
                    ReusableListTile(
                      title: "آدرس",
                      subTitle: "شهرنو،مارکت حضرتها،درب شیشم",
                      icon: Icons.location_on,
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class ReuseableDivider extends StatelessWidget {
  const ReuseableDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.amber,
        thickness: 1,
      ),
    );
  }
}

class ReusableListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const ReusableListTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      leading: Icon(icon),
    );
  }
}

class ReuseableSizedBox extends StatelessWidget {
  final String text;
  const ReuseableSizedBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableCotiner extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final BoxDecoration decoration;
  const ReusableCotiner({
    super.key,
    required this.text,
    required this.onPressed,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: decoration,
      child: ReuseableButton(
        onPressed: onPressed,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(color: Colors.yellow, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
