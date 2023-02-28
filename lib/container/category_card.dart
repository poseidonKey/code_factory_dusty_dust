import 'package:f_test/component/card_title.dart';
import 'package:f_test/component/main_card.dart';
import 'package:f_test/model/stat_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../component/main_stat.dart';
import '../utils/data_utils.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    super.key,
    required this.region,
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
                  children: ItemCode.values
                      .map(
                        (ItemCode itemCode) => ValueListenableBuilder<Box>(
                          valueListenable:
                              Hive.box<StatModel>(itemCode.name).listenable(),
                          builder: (context, box, widget) {
                            final stat = (box.values.last as StatModel);
                            final status =
                                DataUtils.getStatusFromItemCodeAndValue(
                              itemCode: itemCode,
                              value: stat.getLevelFromRegion(region),
                            );
                            return MainStat(
                                category: DataUtils.getItemCodeKrString(
                                    itemCode: itemCode),
                                imgPath: status.imagePath,
                                level: status.label,
                                stat:
                                    "${stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: itemCode)}",
                                width: constraints.maxWidth / 3);
                          },
                        ),
                      )
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
