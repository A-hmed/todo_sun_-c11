import 'package:flutter/material.dart';
import 'package:todo_sun_c11/model/user_dm.dart';
import 'package:todo_sun_c11/ui/screens/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo_sun_c11/ui/screens/home/tabs/list/list_tab.dart';
import 'package:todo_sun_c11/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo_sun_c11/ui/utils/app_colors.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  GlobalKey<ListTabState> listTabKey = GlobalKey();
  List<Widget> tabs = [];

  @override
  void initState() {
    super.initState();
    tabs = [
      ListTab(
        key: listTabKey,
      ),
      const SettingsTab()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${UserDM.currentUser!.userName}"),
      ),
      body: tabs[currentIndex],
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (tappedIndex) {
              currentIndex = tappedIndex;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ]),
      );

  buildFab() => FloatingActionButton(
        onPressed: () async {
          await AddBottomSheet.show(context);
          listTabKey.currentState?.getTodosListFromFireStore();
        },
        backgroundColor: AppColors.primary,
        shape: const StadiumBorder(
            side: BorderSide(color: AppColors.white, width: 3)),
        child: const Icon(Icons.add),
      );
}
