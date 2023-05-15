

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/appColor/appColor.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Widget? leading;
  final Widget? trailIcon;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool? readOnly;
  final Color? borderColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? textColor;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isPassword;



  const InputFieldWidget({super.key,  required this.hintText, required this.labelText, required this.controller, this.leading, this.keyboardType, this.onTap, this.readOnly, this.trailIcon, this.isPassword, this.validator, this.maxLines, this.maxLength, this.enabled, this.onChanged, this.borderColor, this.labelColor, this.hintColor, this.textColor, this.focusNode, this.inputFormatters, });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        focusNode: focusNode,
        obscureText: isPassword ?? false,
        cursorHeight: 25,
        validator: validator,
        maxLines: maxLines == null ? 1 : null ,
        minLines: 1,
        maxLength: maxLength ,
        enabled: enabled,
        onTap: onTap,
        inputFormatters: inputFormatters,
        style: TextStyle(color: textColor ?? Colors.black),
        onChanged: onChanged,
        decoration: InputDecoration(


            hintText: hintText,
            prefixIcon: leading,
            suffixIcon: trailIcon,

            label: labelText != null ? Padding(
              padding: const  EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(labelText ?? "", style: TextStyle(color: labelColor ?? AppColors.primaryColor),),
            ): null,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.primaryColor),
                gapPadding: 0,
                borderRadius: BorderRadius.circular(8)
            ),

            focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.primaryColor),
                gapPadding: 0,
                borderRadius: BorderRadius.circular(8)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.primaryColor),
                gapPadding: 0,
                borderRadius: BorderRadius.circular(8)
            )

        ),
        );

    }
}










































// import 'package:flutter/material.dart';
//
// class InputField extends StatelessWidget {
//   final TextEditingController controller ;
//   final String? hintText;
//   final Widget? leading;
//   final Widget? suffixIcon;
//   final TextInputType? keyboardType;
//   final String? labelText;
//   final Function()? onTap;
//   final bool? readOnly;
//   const InputField({Key? key, required this.controller, this.hintText, this.leading, this.keyboardType, this.suffixIcon, this.labelText, this.onTap, this.readOnly}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       readOnly : readOnly ?? false,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10)
//           ),
//           prefixIcon: leading,
//           hintText: hintText,
//             suffixIcon: suffixIcon,
//             labelText: labelText,
//         ),
//     );
//   }
// }
