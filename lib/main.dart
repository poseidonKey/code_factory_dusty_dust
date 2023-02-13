import 'package:f_test/model/stat_model.dart';
import 'package:f_test/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = "test";
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<StatModel>(
    StatModelAdapter(),
  );
  Hive.registerAdapter<ItemCode>(
    ItemCodeAdapter(),
  );
  await Hive.openBox(testBox);
  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      // home: const TestScreen(),
      home: const HomeScreen(),
    ),
  );
}
