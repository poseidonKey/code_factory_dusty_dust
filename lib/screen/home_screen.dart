import 'package:f_test/component/category_card.dart';
import 'package:f_test/component/hourly_card.dart';
import 'package:f_test/component/main_app_bar.dart';
import 'package:f_test/component/main_drawer.dart';
import 'package:f_test/const/colors.dart';
import 'package:f_test/const/data.dart';
import 'package:flutter/material.dart';
import '../component/main_card.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await Dio().get(
        "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty",
        queryParameters: {
          "serviceKey": serviceKey,
          "returnType": "json",
          "numOfRows": 40,
          "pageNo": 1,
          "sidoName": "전국",
          "ver": "1.0"
        });
    print(response.data["response"]["body"]["items"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          const MainAppBar(),
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
      ),
    );
  }
}
