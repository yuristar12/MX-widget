import '../../../config/global_enum.dart';

class MultipleOptionsQuery {
  MultipleOptionsQuery(
      {required this.options, this.initialValue, this.optionProperty});

  late List<Map> options;
  late List<dynamic>? initialValue;
  late Map<MultipleOptionsPropertyEnum, String>? optionProperty;
}
