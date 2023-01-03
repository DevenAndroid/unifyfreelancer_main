import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';

class CustomTextFieldForTimesheet extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  RxBool? obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final   ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final RxString hintText;
  final Widget? suffixIcon;
  final Widget? prefix;

  List<TextInputFormatter>? inputFormatters1 = [];

  CustomTextFieldForTimesheet({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters1,
    this.onFieldSubmitted ,

  });

  @override
  State<CustomTextFieldForTimesheet> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldForTimesheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
          textAlign: TextAlign.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: widget.onFieldSubmitted ,
          inputFormatters: widget.inputFormatters1,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          obscureText: widget.obSecure!.value,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            counter: const Offstage(),
            filled: true,
            errorMaxLines: 2,
            enabled: widget.enabled,
            fillColor: AppTheme.whiteColor,
            hintText: widget.hintText.value,
            errorText: widget.errorText,
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black),
            prefixIcon: widget.prefix,
            suffixIcon:  widget.suffixIcon,
            hintStyle: const TextStyle(
              color: Color(0xff596681),
              fontSize: 15,
            ),
            /*errorStyle: const TextStyle(
              overflow: TextOverflow.clip,
            ),*/
            contentPadding: const EdgeInsets.only(left: 5,top: 2),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                borderRadius: BorderRadius.circular(8.0)),
          ),
          validator: widget.validator);
    });
  }
}
