import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text_style.dart';

class CarplateTextFiled extends StatefulWidget {
  const CarplateTextFiled({
    super.key,
    this.onChanged,
    this.validator,
  });

  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<CarplateTextFiled> createState() => _CarplateTextFiledState();
}

class _CarplateTextFiledState extends State<CarplateTextFiled> {
  late TextEditingController textEditingController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: textEditingController,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      onTapOutside: (_) => focusNode.unfocus(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      style: customTextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: '----',
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
