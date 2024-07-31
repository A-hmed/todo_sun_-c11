import 'package:flutter/material.dart';
import 'package:todo_sun_c11/ui/utils/app_style.dart';
import 'package:todo_sun_c11/ui/utils/date_time_extension.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddBottomSheet(),
          );
        });
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add new task",
            textAlign: TextAlign.center,
            style: AppStyle.bottomSheetTitle,
          ),
          const TextField(
            decoration: InputDecoration(hintText: "Enter task title"),
          ),
          const SizedBox(
            height: 12,
          ),
          const TextField(
            decoration: InputDecoration(hintText: "Enter task description"),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Select date",
            style: AppStyle.bottomSheetTitle.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate,
                style: AppStyle.normalGreyTextStyle,
                textAlign: TextAlign.center,
              )),
          const Spacer(),
          ElevatedButton(onPressed: () {}, child: const Text("Add"))
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }
}
