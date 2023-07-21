class MXCascaderOptions {
  MXCascaderOptions({required this.label, required this.value, this.children});

  String label;

  String value;

  List<MXCascaderOptions>? children;

  get name => null;
}
