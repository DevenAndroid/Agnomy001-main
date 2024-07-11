import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/model/crop-types-model.dart';

class CropTypesController extends GetxController {
  Rx<CropTypesModel> cropTypes = CropTypesModel().obs;
  // RxList<bool> checkboxStates = <bool>[].obs;
  RxList<Map<String, dynamic>> checkboxStates = <Map<String, dynamic>>[].obs;


  Future<void> fetchCropTypes() async {
    final String url = 'https://admin.agnomy.com/api/v1/crop-types';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        cropTypes.value = CropTypesModel.fromJson(data);
        // checkboxStates.value = List<bool>.filled(cropTypes.value.content!.length, false);
        checkboxStates.value = cropTypes.value.content!
            .map((title) => {'title': title, 'isChecked': false})
            .toList();
        print('Data fetched: ${cropTypes.value.content}');
        printCheckboxStates();

      } else {
        print('Failed to load crop types. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  void printCheckboxStates() {
    final checkedItems = checkboxStates.where((item) => item['isChecked'] == true).toList();
    for (var item in checkedItems) {
      print(item['title']);
    }
  }
}
