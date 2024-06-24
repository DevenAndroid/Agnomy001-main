import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/helper/date_converter.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';

class SingleServiceSchedule extends StatefulWidget {
  const SingleServiceSchedule({super.key});

  @override
  State<SingleServiceSchedule> createState() => _SingleServiceScheduleState();
}

class _SingleServiceScheduleState extends State<SingleServiceSchedule> {
  @override
  Widget build(BuildContext context) {
    return Column( children: [

      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Text("service_schedule".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
      ),

      Container(
        height: 70, width: Get.width,
        padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSeven),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 0.5),
          color: Theme.of(context).hoverColor,
        ),
        child: Center(child: Row( children: [

          Expanded( flex: 7, child: Row( children: [

            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("test1",
                //" ${DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(0,2)}",
                style: ubuntuMedium.copyWith( color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeOverLarge),
              ),
              Text("test2",
                //DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(2),
                style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.primary,),
              ),
            ]),

            const SizedBox(width: Dimensions.paddingSizeDefault),
            Container(height: 40, width: 1, color: Theme.of(context).colorScheme.primary,),
            const SizedBox(width: Dimensions.paddingSizeDefault),

            Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("test3",
                //DateConverter.dateToWeek(scheduleController.selectedData),
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
              const SizedBox(height: Dimensions.paddingSizeMini,),
              Text("test4",
                //DateConverter.dateToTimeOnly(scheduleController.selectedData),
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
          ])),

          InkWell( onTap: () =>
              selectDate(),

              child: Image.asset(Images.editButton,width: 20.0,height: 20.0,)),

        ])),
      ),

      const SizedBox(height: Dimensions.paddingSizeDefault),

    ]);;
  }

  DateTime _selectedDate = DateTime.now().add(const Duration(hours: AppConstants.scheduleTime));
  DateTime get selectedDate => _selectedDate;

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        // Disable Saturdays and Sundays
        if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
          return false;
        }
        return true;
      },
    );

    if (picked != null) {
      _selectedDate = picked;
      update();
      await selectTimeOfDay();
    }
  }

  Future<void> selectTimeOfDay() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay(hour: DateTime.now().hour + AppConstants.scheduleTime, minute: DateTime.now().minute),
    );

    if (pickedTime != null) {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      update();
      await _buildSchedule();
    }
  }

  String _schedule = '';
  String? _postId;
  Future<void> _buildSchedule() async {
    _schedule = DateConverter.dateToDateAndTime(_selectedDate);

    if (_postId != null && _schedule.isNotEmpty) {
      //  updatePostInformation(_postId!,_schedule);
    }
    // _schedule = "${DateConverter.dateTimeStringToDateOnly(_selectedDate.toString())} ${_selectedDate.hour.toString().padLeft(2,'0')}:${_selectedDate.minute.toString().padLeft(2,'0')}:00";
    update();
  }

  void update([List<Object>? ids, bool condition = true]) {
    if (!condition) {
      return;
    }
    if (ids == null) {
      // refresh();
    } else {
      for (final id in ids) {
        //  refreshGroup(id);
      }
    }
  }



}
