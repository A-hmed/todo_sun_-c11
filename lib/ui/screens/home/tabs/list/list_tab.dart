import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_sun_c11/model/todo_dm.dart';
import 'package:todo_sun_c11/ui/screens/home/tabs/list/todo.dart';
import 'package:todo_sun_c11/ui/utils/app_colors.dart';
import 'package:todo_sun_c11/ui/utils/app_style.dart';
import 'package:todo_sun_c11/ui/utils/date_time_extension.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedCalendarDate = DateTime.now();
  List<TodoDM> todosList = [];

  @override
  Widget build(BuildContext context) {
    getTodosListFromFireStore();
    return Column(
      children: [
        buildCalendar(),
        Expanded(
          flex: 75,
          child: ListView.builder(
              itemCount: todosList.length,
              itemBuilder: (context, index) {
                print(todosList.length);
                return Todo(
                  item: todosList[index],
                );
              }),
        ),
      ],
    );
  }

  void getTodosListFromFireStore() async {
    // List<String> nums = ["1", "2", "3"];
    // List<int> numbers = [];

    ///Solution1
    // for(int i = 0; i < nums.length; i++){
    //   numbers.add(int.parse(nums[i]));
    // }
    ///Solution2
    // numbers = nums.map((string) => int.parse(string)).toList();
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    print("56- documents size = ${documents.length}");
    todosList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return TodoDM.fromJson(json);
    }).toList();
    todosList = todosList
        .where((todo) =>
            todo.date.year == selectedCalendarDate.year &&
            todo.date.month == selectedCalendarDate.month &&
            todo.date.day == selectedCalendarDate.day)
        .toList();
    print(todosList);
  }

  buildCalendar() {
    return Expanded(
      flex: 25,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                color: AppColors.primary,
              )),
              Expanded(
                  child: Container(
                color: AppColors.bgColor,
              ))
            ],
          ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            focusDate: selectedCalendarDate,
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateChange: (selectedDate) {},
            itemBuilder: (context, date, isSelected, onDateTapped) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCalendarDate = date;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        date.dayName,
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      Spacer(),
                      Text(
                        date.day.toString(),
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      Spacer()
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void onDateTapped() {}
}
