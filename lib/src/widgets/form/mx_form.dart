import 'package:flutter/material.dart';

class MXForm extends StatefulWidget {
  const MXForm({super.key, this.padding = 16});

  final double padding;

  @override
  State<MXForm> createState() => _MXFormState();
}

class _MXFormState extends State<MXForm> {
  Widget _buildBody() {
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.padding),
      child: _buildBody(),
    );
  }
}
