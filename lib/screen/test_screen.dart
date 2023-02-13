import 'package:f_test/screen/test2_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box(testBox).listenable(),
            builder: (context, box, widget) {
              return Column(
                children: box.values
                    .map(
                      (e) => Text(e.toString()),
                    )
                    .toList(),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys : ${box.keys.toList()}');
              print('values : ${box.values.toList()}');
            },
            child: const Text(
              '박스 프린트하기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // 데이터를 생성하거나
              // 업데이트할때
              box.put(1000, '새로운 데이터!!!');
            },
            child: const Text(
              '데이터 넣기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              print(box.getAt(3));
            },
            child: const Text(
              '특정 값 가져오기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              box.deleteAt(2);
            },
            child: const Text(
              '삭제하기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const Test2Screen(),
                ),
              );
            },
            child: const Text(
              '다음화면!',
            ),
          ),
        ],
      ),
    );
  }
}
