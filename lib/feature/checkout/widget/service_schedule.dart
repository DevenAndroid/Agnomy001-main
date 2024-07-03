import 'dart:developer';

import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

import '../../../components/service_center_dialog1.dart';
import '../../../data/model/quotelist-model.dart';
import '../../service/widget/service_overview.dart';


class ServiceSchedule extends GetView<ScheduleController> {
   ServiceSchedule({Key? key}) : super(key: key);
   RxInt refereshInt = 0.obs;
   void initState() {


   }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>( init: controller, builder: (scheduleController){
      return
        Column( children: [

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
                Text(" ${DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(0,2)}",
                  style: ubuntuMedium.copyWith( color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeOverLarge),
                ),
                Text(DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(2),
                  style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.primary,),
                ),
              ]),

              const SizedBox(width: Dimensions.paddingSizeDefault),
              Container(height: 40, width: 1, color: Theme.of(context).colorScheme.primary,),
              const SizedBox(width: Dimensions.paddingSizeDefault),

              Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text( DateConverter.dateToWeek(scheduleController.selectedData),
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                ),
                const SizedBox(height: Dimensions.paddingSizeMini,),
                Text( DateConverter.dateToTimeOnly(scheduleController.selectedData),
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                ),
              ]),
            ])),

            InkWell( onTap: () {
              scheduleController.selectDate();
             // _selectDate(context);

              },


                child: Image.asset(Images.editButton,width: 20.0,height: 20.0,)),

          ])),
        ),

        const SizedBox(height: Dimensions.paddingSizeDefault),

      ]);},
    );



  }

  // DateTime selectedDate = DateTime.saturday.ma
  // bool _predicate(DateTime day) {
  //   if ((day.isAfter(DateTime(2020, 1, 5)) &&
  //       day.isBefore(DateTime(2020, 1, 9)))) {
  //     return true;
  //   }
  //
  //   if ((day.isAfter(DateTime(2020, 1, 10)) &&
  //       day.isBefore(DateTime(2020, 1, 15)))) {
  //     return true;
  //   }
  //   if ((day.isAfter(DateTime(2020, 2, 5)) &&
  //       day.isBefore(DateTime(2020, 2, 17)))) {
  //     return true;
  //   }
  //
  //   return false;
  // }
  //
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     selectableDayPredicate: _predicate,
  //     firstDate: DateTime(2019),
  //     lastDate: DateTime(2036),
  //     // builder: (context, child) {
  //     //
  //     //   return Theme(
  //     //     data: ThemeData(
  //     //         primaryColor: Colors.orangeAccent,
  //     //         disabledColor: Colors.brown,
  //     //         textTheme:
  //     //         TextTheme(bodyLarge: TextStyle(color: Colors.blueAccent)),
  //     //         indicatorColor: Colors.yellow),
  //     //     child:child ,
  //     //   );
  //     //}
  //   );
  //   if (picked != null && picked != selectedDate)
  //     selectedDate = picked;
  //
  // }

   DateTime? selectedDate;
   TimeOfDay? selectedStartTime;

   final List<String> weekends = ["saturday", "sunday"];
   Map<String, String> timeSchedule = {
     "start_time": "14:44",
     "end_time": "",
   };
   int getDayValue(String day) {
     switch (day.toLowerCase()) {
       case "monday":
         return DateTime.monday;
       case "tuesday":
         return DateTime.tuesday;
       case "wednesday":
         return DateTime.wednesday;
       case "thursday":
         return DateTime.thursday;
       case "friday":
         return DateTime.friday;
       case "saturday":
         return DateTime.saturday;
       case "sunday":
         return DateTime.sunday;
       default:
         return -1; // Invalid day name
     }
   }

//date
   Future<void> _selectDate(BuildContext context) async {
     final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: selectedDate ?? DateTime.now(),
       firstDate: DateTime(2000),
       lastDate: DateTime(2101),
       selectableDayPredicate: (DateTime date) {



        for(var element in weekends){

          log("ddddddd");
           if(date.weekday==getDayValue(element)){
             return false;
           }
        }

        return true;
       },
     );
     if (picked != null && picked != selectedDate) {
      print("Date:=> ${selectedDate}");
      // setState(() {
         selectedDate = picked;
      _selectStartTime(context);
       //});
     }
   }
// timestart
//   Future<void> _selectStartTime(BuildContext context) async {
// //     final TimeOfDay? picked = await showTimePicker(
// //       context: context,
// //       initialTime: selectedStartTime ?? TimeOfDay.now(),
// //     );
// //     if (picked != null && picked != selectedStartTime) {
// //      //setState(() { // Ensure the state is updated
// //         selectedStartTime = picked;
// //         timeSchedule["start_time"] = picked.format(context);
// //         print("Start Time: ${timeSchedule["start_time"]}");
// //       //});
// //     }
// //   }
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedStartTime) {
      // Check if the selected time is between 1 AM and 5 AM
      if ((picked.hour >= 1 && picked.hour < 5)) {
        // Show an error message or perform any desired action
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a time outside the range of 1 AM to 5 AM')),
        );
      } else {
        selectedStartTime = picked;
        timeSchedule["start_time"] = picked.format(context);
        print("Start Time: ${timeSchedule["start_time"]}");
      }
    }
  }








}

