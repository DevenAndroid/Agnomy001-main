class ProviderAvailabilityModel {
  String? responseCode;
  String? message;
  Content? content;


  ProviderAvailabilityModel(
      {this.responseCode, this.message, this.content});

  ProviderAvailabilityModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }

    return data;
  }
}

class Content {
  TimeSchedule? timeSchedule;
  List<String>? weekends;

  Content({this.timeSchedule, this.weekends});

  Content.fromJson(Map<String, dynamic> json) {
    timeSchedule = json['time_schedule'] != null
        ? new TimeSchedule.fromJson(json['time_schedule'])
        : null;
    weekends = json['weekends'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeSchedule != null) {
      data['time_schedule'] = this.timeSchedule!.toJson();
    }
    data['weekends'] = this.weekends;
    return data;
  }
}

class TimeSchedule {
  String? startTime;
  String? endTime;

  TimeSchedule({this.startTime, this.endTime});

  TimeSchedule.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
