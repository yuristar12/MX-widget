class MXCountDownModel {
  MXCountDownModel();

  String day = '0';

  String hour = '0';

  String minute = '0';

  String second = '0';

  void setModel(int day, int hour, int minute, int second) {
    this.day = day < 10 ? '0$day' : '$day';
    this.hour = hour < 10 ? '0$hour' : '$hour';
    this.minute = minute < 10 ? '0$minute' : '$minute';
    this.second = second < 10 ? '0$second' : '$second';
  }
}
