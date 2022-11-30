import 'package:flutter/material.dart';

Widget textfromfielde({
  required String label,
  TextEditingController? controller,
  required TextInputType type,
  required IconData prefix,
  required Function vildate,
  Function? onchange,
  Function? onsubmaited,
  bool isscure = false,
  IconData? suffixicon,
  Function? onpressedicon,
  Function? ontap,
}) =>
    TextFormField(
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },

      onFieldSubmitted: (value) {
        onsubmaited != null ? onsubmaited(value) : null;
      },
      // ignore: unnecessary_null_comparison
      onChanged: (value) {
        if (onchange != null) {
          onchange(value);
        }
      },
      validator: (value) {
        return vildate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffixicon != null
            ? IconButton(
                onPressed: () {
                  onpressedicon!();
                },
                icon: Icon(suffixicon))
            : null,
      ),
      keyboardType: type,
      controller: controller,
      obscureText: isscure,
    );
vildateemail(value) {
  if (value!.isEmpty) {
    return 'failed is reuierd';
  }
  String pattern = r'\w+@\w+\.\w+';
  if (!RegExp(pattern).hasMatch(value)) {
    return 'Invalid E-mail Address format.';
  }
  return null;
}