import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  // Split String
  List<String> splitByLength(int length) {
    String currentString = this;
    List<String> result = [];
    List<String> collectedCharacters = [];

    int count = 0;
    for (var rune in currentString.runes) {
      collectedCharacters.add(String.fromCharCode(rune));
      count += 1;
      if(count == length){
        count = 0;
        currentString = currentString.substring(4);
        result.add(collectedCharacters.join());
        collectedCharacters = [];
      }
    }

    // Append the remainder
    if (collectedCharacters.isNotEmpty) {
        result.add(collectedCharacters.join());
    }

    return result;
  }
  String getSha1(){
    var string = this;
    return sha1.convert(utf8.encode(string)).toString();
  }

}