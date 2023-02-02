import 'package:f_test/component/card_title.dart';
import 'package:flutter/material.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardTitle(title: "종류별 통계"),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              children: List.generate(
                100,
                (index) => MainStat(
                    width: constraints.maxWidth / 3,
                    category: "미세먼지$index",
                    imgPath: "asset/img/best.png",
                    level: "최고",
                    stat: "0 ㎍/㎥"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
