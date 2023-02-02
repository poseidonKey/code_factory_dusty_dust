import 'package:f_test/const/colors.dart';
import 'package:f_test/const/regions.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              "지역 선택",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          ...regions
              .map((e) => ListTile(
                    tileColor: Colors.white,
                    selected: true,
                    selectedColor: Colors.black,
                    selectedTileColor: lightColor,
                    onTap: () {},
                    title: Text(e),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
