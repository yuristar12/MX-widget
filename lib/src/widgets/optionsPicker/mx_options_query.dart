import '../../config/global_enum.dart';

class MXOptionsQuery {
  MXOptionsQuery(
      {required this.options, this.initialValue, this.optionProperty});

  late List<List<Map>> options;
  late List<dynamic>? initialValue;
  late Map<OptionsPropertyEnum, String>? optionProperty;
}
