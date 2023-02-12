import 'package:f_test/component/category_card.dart';
import 'package:f_test/component/hourly_card.dart';
import 'package:f_test/component/main_app_bar.dart';
import 'package:f_test/component/main_drawer.dart';
import 'package:f_test/const/colors.dart';
import 'package:f_test/const/regions.dart';
import 'package:f_test/model/stat_model.dart';
import 'package:f_test/repository/stat_repository.dart';
import 'package:f_test/utils/data_utils.dart';
import 'package:flutter/material.dart';
import '../component/main_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};
    List<Future> futures = [];
    for (ItemCode itemCode in ItemCode.values) {
      if (itemCode == ItemCode.PM10 || itemCode == ItemCode.PM25) {
        futures.add(
          StatRepository.fetchData(itemCode: itemCode),
        );
        // final statModels = await StatRepository.fetchData(itemCode: itemCode);
        // stats.addAll({itemCode: statModels});
      }
    }
    final results = await Future.wait(futures);
    ItemCode key = ItemCode.PM10;
    var value = results[0];
    stats.addAll({key: value});
    key = ItemCode.PM25;
    value = results[1];
    stats.addAll({key: value});

    return stats;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
          selectedRegion: region,
          onRegionTab: (String region) {
            setState(() {
              this.region = region;
            });
            Navigator.of(context).pop();
          }),
      backgroundColor: primaryColor,
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            Map<ItemCode, List<StatModel>> stats = snapshot.data!;
            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];
            final status = DataUtils.getStatusFromItemCodeAndValue(
                value: pm10RecentStat.seoul, itemCode: ItemCode.PM10);

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  stat: pm10RecentStat,
                  status: status,
                  region: region,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      SizedBox(
                        height: 160,
                        child: MainCard(
                          child: CategoryCard(),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      HourlyCard(),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
