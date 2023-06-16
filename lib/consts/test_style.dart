// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'colors.dart';

const Bold = "Bold";
const regular = "regularText";


tStyle ({double? size = 14.0 , color = whiteColor ,family = "regularText"  }) 
{
  return TextStyle (
          fontSize: size ,
          color: color, 
          fontFamily: family,
        );
        }