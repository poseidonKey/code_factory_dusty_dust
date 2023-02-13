import 'package:f_test/component/card_title.dart';
import 'package:f_test/component/main_card.dart';
import 'package:f_test/model/stat_and_status_model.dart';
import 'package:f_test/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final List<StatAndStatusModel> models;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    super.key,
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: "종류별 통계",
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const PageScrollPhysics(),
                  children: models
                      .map((model) => MainStat(
                          category: DataUtils.getItemCodeKrString(
                              itemCode: model.itemCode),
                          imgPath: model.status.imagePath,
                          level: model.status.label,
                          stat:
                              "${model.stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: model.itemCode)}",
                          width: constraints.maxWidth / 3))
                      .toList(),
                  //  List.generate(
                  //   100,
                  //   (index) => MainStat(
                  //       width: constraints.maxWidth / 3,
                  //       category: "미세먼지$index",
                  //       imgPath: "asset/img/best.png",
                  //       level: "최고",
                  //       stat: "0 ㎍/㎥"),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
