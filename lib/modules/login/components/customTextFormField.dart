import 'package:flutter/material.dart';
import 'package:g20newapp/modules/login/bloc/states.dart';
import 'package:g20newapp/shared/util/masks.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget customTextFormField(
    {required LoginState state,
    required String? Function(String? value) validator,
    required String hintText,
    required String labelText,
    required IconData suffixIcon,
      bool obscureText =false,
      MaskTextInputFormatter? mask
    }) {
  return TextFormField(
    obscureText: obscureText,
      inputFormatters: mask!=null?[mask]:[],
      style: TextStyle(color: Colors.white),
      enabled: !(state is LoginLoadingState),
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(24))),
          disabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(24))),
          labelStyle: TextStyle(color: Colors.white),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          labelText: labelText,
          suffixIcon: (state is LoginErroState)
              ? Icon(
                  Icons.error,
                  color: Colors.white,
                )
              : Icon(
                  suffixIcon,
                  color: Colors.white,
                )),
      validator: validator);
}


