import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';

class BoxTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  RxBool? obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
 double? textSize;
  final String? errorText;
  final String? labelText;
  final RxString hintText;
  final Widget? prefix;
  final Widget? suffixIcon;
  List<TextInputFormatter>? inputFormatters1 = [];

  BoxTextField({
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
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.suffixIcon,
    this.textSize = 0,
    this.inputFormatters1,
  });

  @override
  State<BoxTextField> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends State<BoxTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RxString hintTextValue = widget.hintText.value.obs;
    switch (hintTextValue.value) {
      case 'Password':
        {}
        break;
      case 'Current Password':
        {}
        break;
      case 'New Password':
        {}
        break;
      case 'Confirm Password':
        {}
        break;
    }
    return Obx(() {
      return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters1,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          textInputAction: TextInputAction.next,
          // autofocus: autofocus,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: widget.hintText == hintTextValue ? widget.obSecure!.value : false,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            errorMaxLines: 2,
            fillColor: AppTheme.primaryColor.withOpacity(.05),
            hintText: widget.hintText.value,
            errorText: widget.errorText,
            /*errorStyle: TextStyle(
              fontSize: widget.textSize == 0 ? AddSize.font14*.9 : widget.textSize
            ),*/
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            /*  suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obSecure!.value = !widget.obSecure!.value;
                    print("ksajdfg" + widget.obSecure.toString());
                    print("ksajdfgsdsf" + hintTextValue.toString());
                  });
                },
                child: Icon(
                  widget.suffixIcon,
                  color: AppTheme.primaryColor,
                )),
*/
            // labelStyle: TextStyle(fontSize: lableFontSize()),
            // labelText: label,
            hintStyle: TextStyle(color: Color(0xff596681), fontSize: AddSize.font14*.92),
            contentPadding:
                const EdgeInsets.only(right: 0, left: 10, top: 14, bottom: 14),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
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

            // enabledBorder: textFieldfocused(),
            // border: textFieldfocused(),
            // focusedBorder: textFieldfocused(),
            // errorBorder: errorrTextFieldBorder(),
            // focusedErrorBorder: errorrTextFieldBorder(),
          ),
          validator: widget.validator);
    });
  }
}
