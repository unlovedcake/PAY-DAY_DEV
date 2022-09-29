// ignore_for_file: file_names

import 'package:flutter/material.dart';
gkTxtField(
    String txtLbl,
    TextEditingController txtController,
    {TextInputType keyboardType = TextInputType.text,
      InputBorder txtBorder = InputBorder.none,
      bool isSecured = false}) {

  return TextField(
    textInputAction: TextInputAction.next,
    maxLength: 10,
    keyboardType: keyboardType,
    controller: txtController,
    obscureText: isSecured,
    style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
    decoration: InputDecoration(
        counter:const Offstage(),
        contentPadding: const EdgeInsets.fromLTRB(0, -7, 0, 0),
        alignLabelWithHint: true,
        border: txtBorder,
        labelText: txtLbl,
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.never
    ),
    onChanged: (text){
      txtController = TextEditingController(text: text);
    },
  );
}

TextField pwdTxtField(
    Function setState,
    BuildContext context,
    String txtLbl,
    TextEditingController txtController,
    {TextInputType keyboardType = TextInputType.text,
      InputBorder txtBorder = InputBorder.none,
      bool isSecured = false}) {

  return TextField(
    keyboardType: keyboardType,
    controller: txtController,
    obscureText: !isSecured,
    style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      alignLabelWithHint: true,
      border: txtBorder,
      labelText: txtLbl,
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIcon:
      IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          isSecured
              ? Icons.visibility
              : Icons.visibility_off,
          color: Theme.of(context).primaryColorDark,
        ),
        onPressed: () {
          isSecured = !isSecured;
        },
      ),
    ),
    onChanged: (text){
      txtController = TextEditingController(text: text);
    },
  );
}

class PwdTextField extends StatefulWidget {
  TextEditingController textController;
  final txtLbl;
  final icon;
  final keyboardType;
  final onTap;
  final readOnly;
  final text;

  PwdTextField({Key? key,
    required this.textController,
    this.txtLbl,
    this.icon,
    this.keyboardType,
    this.onTap,
    this.readOnly,
    this.text
  }) : super(key: key);

  @override
  State<PwdTextField> createState() => _PwdTextFieldState();
}

class _PwdTextFieldState extends State<PwdTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return
      TextField(
        controller: widget.textController,
        obscureText: _obscureText,
        style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(8, -4, 0, 0),
          alignLabelWithHint: true,
          border: InputBorder.none,
          labelText: widget.txtLbl,
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon:
          IconButton(
            iconSize: 17,
            padding: const EdgeInsets.only(left: 25),
            icon: Icon(
              // Based on passwordVisible state choose the icon
              !_obscureText
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        onChanged: (text){
          widget.textController = TextEditingController(text: text);
          widget.textController.selection = TextSelection.fromPosition(TextPosition(offset: text.length));
        },
      );
  }
}

TextStyle pdyTxtStyle(
    {
      double fSize = 20,
      FontWeight fWeight = FontWeight.w500,
      Color fColor = Colors.white
    }
    ){
  return
    TextStyle(fontSize: fSize, fontWeight: fWeight, color: fColor);
}