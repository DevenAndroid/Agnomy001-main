import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:path/path.dart';
import 'package:time_range_picker/time_range_picker.dart';

class ScheduleController extends GetxController{

  final ScheduleRepo scheduleRepo;
  ScheduleController({required this.scheduleRepo});

  ///Selected date of day
  DateTime _selectedDate = DateTime.now().add(const Duration(hours: AppConstants.scheduleTime));
  DateTime get selectedData => _selectedDate;
 // DateTime get selectedEndDate => _selectedEndDate;




  ///Selected time of day
  // TimeOfDay _selectedTimeOfDay = TimeOfDay(hour: DateTime.now().hour + AppConstants.SCHEDULE_TIME, minute: DateTime.now().minute);
  // TimeOfDay get selectedTimeOfDay => _selectedTimeOfDay;

  String _schedule = '';
  String get schedule => _schedule;

  RxInt refreshIt = 0.obs;

  DateTime sselectedEndDate=DateTime.now();
 // DateTime get selectedEndDate => sselectedEndDate;


  // String _scheduleend = '';
  // String get scheduleend => _scheduleend;

  String? _postId;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // initializeTime();
  //  // _buildSchedule();
  // }



  // Future<void> selectDate() async {
  //   final DateTime? picked = await showDatePicker(
  //       context: Get.context!,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now().subtract(const Duration(days: 0)),
  //       lastDate: DateTime(2101),
  //   );
  //
  //   if (picked != null) {
  //     _selectedDate = picked;
  //     update();
  //     selectTimeOfDay();
  //   }
  // }
 // DateTime? _selectedStartDate;


  Future<void> selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: Get.context!,
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)),
      ),
      firstDate: DateTime(2019),
      lastDate: DateTime(2101),
        builder: (context, child) {
          return Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: 400.0, maxHeight: 700.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: child,
                ),
              )
            ],
          );
        }
    );

    if (picked != null) {
      // setState(() {
      _selectedDate = picked.start;
      sselectedEndDate = picked.end;
      refreshIt.value=DateTime.now().microsecondsSinceEpoch.toInt();
        // Call a method to handle the selected date range if needed
        handleDateRangePicked();

          update();
          selectTimeOfDay();// frst time
      selectTimeOfDayEndTime();//sendtime
      // });
    }
  }
  void handleDateRangePicked() {
    // Handle the selected date range
   // print('Start Date: $_selectedStartDate');
    print('End Date: $sselectedEndDate');
  }






  Future<void> selectTimeOfDay() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay(hour: DateTime.now().hour + AppConstants.scheduleTime, minute: DateTime.now().minute));

    if (pickedTime != null) {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, pickedTime.hour, pickedTime.minute);
      update();

     _buildSchedule();
    }
  }

  Future<void> selectTimeOfDayEndTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay(hour: DateTime.now().hour + AppConstants.scheduleTime, minute: DateTime.now().minute));

    if (pickedTime != null) {
      sselectedEndDate = DateTime(sselectedEndDate.year, sselectedEndDate.month, sselectedEndDate.day, pickedTime.hour, pickedTime.minute);
      update();

      _buildScheduleSend();
    }
  }


  Future<void> _buildSchedule() async {
    _schedule = DateConverter.dateToDateAndTime(_selectedDate);

    if(_postId!=null && _schedule.isNotEmpty){
      updatePostInformation(_postId!,_schedule);
    }
    //_schedule = "${DateConverter.dateTimeStringToDateOnly(_selectedDate.toString())} ${_selectedDate.hour.toString().padLeft(2,'0')}:${_selectedDate.minute.toString().padLeft(2,'0')}:00";
    update();
  }

  Future<void> _buildScheduleSend() async {
    _schedule = DateConverter.dateToDateAndTime(sselectedEndDate);

    if(_postId!=null && _schedule.isNotEmpty){
      updatePostInformation(_postId!,_schedule);
    }
    //_schedule = "${DateConverter.dateTimeStringToDateOnly(_selectedDate.toString())} ${_selectedDate.hour.toString().padLeft(2,'0')}:${_selectedDate.minute.toString().padLeft(2,'0')}:00";
    update();
  }

  bool checkScheduleTime(){
    return  _selectedDate.difference(DateTime.now()) > const Duration(hours: AppConstants.scheduleTime, minutes: -15);
  }

  void updateSelectedDate(String? date){
    if(date!=null){
      _selectedDate = DateConverter.dateTimeStringToDate(date);
    }else{
      _selectedDate = DateTime.now().add(const Duration(hours: AppConstants.scheduleTime));
    }
  }
  Future<void> updatePostInformation(String postId,String scheduleTime) async {
    Response response = await scheduleRepo.changePostScheduleTime(postId,scheduleTime);

    if(response.statusCode==200 && response.body['response_code']=="default_update_200"){
      customSnackBar("service_schedule_updated_successfully".tr,isError: false);
    }
  }

  void setPostId(String postId){
    _postId = postId;
  }

}