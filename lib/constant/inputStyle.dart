import 'package:flutter/material.dart';

InputDecoration transparentInputDecoration = InputDecoration(
    border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(50)),
    enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.transparent)),
    focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.transparent)),
    errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.transparent)),
    disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.transparent)),
    focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.transparent)),
    isCollapsed: true,
    counterText: "");
