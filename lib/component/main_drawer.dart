import 'package:f_test/const/colors.dart';
import 'package:f_test/const/regions.dart';
import 'package:flutter/material.dart';

typedef OnRegionTab = void Function(String region);

class MainDrawer extends StatelessWidget {
  final String selectedRegion;
  final OnRegionTab onRegionTab;
  const MainDrawer(
      {super.key, required this.onRegionTab, required this.selectedRegion});

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
                    selected: e == selectedRegion,
                    selectedColor: Colors.black,
                    selectedTileColor: lightColor,
                    onTap: () {
                      onRegionTab(e);
                    },
                    title: Text(e),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
