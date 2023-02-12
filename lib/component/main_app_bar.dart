import 'package:f_test/model/stat_model.dart';
import 'package:f_test/model/status_model.dart';
import 'package:f_test/utils/data_utils.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status; // 가공한 모델링 데이터
  final StatModel stat; //원시 데이터
  final String region;
  const MainAppBar(
      {super.key,
      required this.status,
      required this.stat,
      required this.region});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );
    return SliverAppBar(
      backgroundColor: status.primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  region,
                  style: ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  status.label,
                  style: ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  status.comment,
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
