import 'package:f_test/component/main_app_bar.dart';
import 'package:f_test/component/main_drawer.dart';
import 'package:f_test/const/regions.dart';
import 'package:f_test/model/stat_model.dart';
import 'package:f_test/repository/stat_repository.dart';
import 'package:f_test/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../container/category_card.dart';
import '../container/hourly_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = true;
  String region = regions[0];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    // Map<ItemCode, List<StatModel>> stats = {};
    List<Future> futures = [];
    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(itemCode: itemCode),
      );
      // if (itemCode == ItemCode.PM10 ||
      //     itemCode == ItemCode.PM25 ||
      //     itemCode == ItemCode.SO2) {
      //   futures.add(
      //     StatRepository.fetchData(itemCode: itemCode),
      //   );
      // final statModels = await StatRepository.fetchData(itemCode: itemCode);
      // stats.addAll({itemCode: statModels});
      // }
    }

    final results = await Future.wait(futures);

    // raw  데이터 모으기
    // ItemCode key = ItemCode.PM10;
    // var value = results[0];
    // final box = Hive.box<StatModel>(key.name);
    // for (StatModel stat in value) {
    //   box.put(stat.dataTime.toString(), stat);
    // }
    // key = ItemCode.PM25;
    // value = results[1];
    // for (StatModel stat in value) {
    //   box.put(stat.dataTime.toString(), stat);
    // }
    // key = ItemCode.SO2;
    // value = results[2];
    // for (StatModel stat in value) {
    //   box.put(stat.dataTime.toString(), stat);
    // }
    for (int i = 0; i < results.length; i++) {
      // ItemCode
      final key = ItemCode.values[i];
      // List<StatModel>
      final value = results[i];

      final box = Hive.box<StatModel>(key.name);

      for (StatModel stat in value) {
        box.put(stat.dataTime.toString(), stat);
      }

      final allKeys = box.values.toList();
      if (allKeys.length > 24) {
        final deleteKey = allKeys.sublist(0, allKeys.length - 24);
        box.deleteAll(deleteKey);
      }
    }

    // return stats;
    // final statModels = await StatRepository.fetchData();
    // return statModels;
    // print(statModels);
    // final response = await Dio().get(
    //     "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty",
    //     queryParameters: {
    //       "serviceKey": serviceKey,
    //       "returnType": "json",
    //       "numOfRows": 40,
    //       "pageNo": 1,
    //       "sidoName": "전국",
    //       "ver": "1.0"
    //     });
    // print(response.data["response"]["body"]["items"]);
    // print(
    //   response.data["response"]["body"]["items"].map(
    //     (item) => StatModel.fromJson(json: item),
    //   ),
    // );
    // final statModels = await StatRepository.fetchData();
    // print(statModels);
    // final response = {
    //   "items": [
    //     {
    //       'daegu': "16",
    //       'chungnam': "10",
    //       'incheon': "9",
    //       'daejeon': "13",
    //       'gyeongbuk': "20",
    //       'sejong': "13",
    //       'gwangju': "9",
    //       'jeonbuk': "11",
    //       'gangwon': "18",
    //       'ulsan': "28",
    //       'jeonnam': "9",
    //       'seoul': "18",
    //       'busan': "12",
    //       'jeju': "9",
    //       'chungbuk': null,
    //       'gyeongnam': "12",
    //       'dataTime': "2023-02-12 08:00",
    //       'itemCode': "PM10",
    //       'gyeonggi': "12"
    //     },
    //     {
    //       'daegu': "0.002",
    //       'chungnam': "0.002",
    //       'incheon': "0.002",
    //       'daejeon': "0.002",
    //       'gyeongbuk': "0.002",
    //       'sejong': "0.002",
    //       'gwangju': "0.002",
    //       'jeonbuk': "0.002",
    //       'gangwon': "0.002",
    //       'ulsan': "0.002",
    //       'jeonnam': "0.002",
    //       'seoul': "0.002",
    //       'busan': "0.002",
    //       'jeju': "0.002",
    //       'chungbuk': "0.002",
    //       'gyeongnam': "0.002",
    //       'dataTime': "2023-02-12 08:00",
    //       'itemCode': "PM2.5",
    //       'gyeonggi': "0.002"
    //     },
    //   ]
    // };
    // final statModels =
    //     response["items"]!.map((item) => StatModel.fromJson(json: item));
    // print(statModels);
  }

  void scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;
    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        final recentStat = box.values.toList().last as StatModel;
        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: recentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );
        return Scaffold(
          drawer: MainDrawer(
            selectedRegion: region,
            onRegionTab: (String region) {
              setState(() {
                this.region = region;
              });
              Navigator.of(context).pop();
            },
            darkColor: status.darkColor,
            lightColor: status.lightColor,
          ),
          // backgroundColor: primaryColor,
          body: Container(
            color: status.primaryColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainAppBar(
                  isExpanded: isExpanded,
                  stat: recentStat,
                  status: status,
                  region: region,
                  dateTime: recentStat.dataTime,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 160,
                        child: CategoryCard(
                          region: region,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ...ItemCode.values.map((itemCode) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: HourlyCard(
                            region: region,
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                            itemCode: itemCode,
                          ),
                        );
                      }).toList(),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
