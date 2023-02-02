import 'package:flutter/material.dart';
import '../const/colors.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );
    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  "서울",
                  style: ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                Text(
                  DateTime.now().toString(),
                  style: ts.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "asset/img/ok.png",
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "아주 좋음",
                  style: ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "나쁘지 않네요",
                  style: ts.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
