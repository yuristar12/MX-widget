class MXCalendarValueByRange {
  MXCalendarValueByRange({
    this.startTime,
    this.endTime,
  });

  DateTime? startTime;

  DateTime? endTime;

  void cleanTime() {
    startTime = null;
    endTime = null;
  }
}
