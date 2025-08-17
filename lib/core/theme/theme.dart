import 'package:flutter/material.dart';
import 'package:lavagem_app/data/enum/enum_status.dart';

extension StatusExtension on Status {
  Color get color {
    switch (this) {
      case Status.cadastrado:
        return const Color(0xff717C89);
      case Status.lavando:
        return const Color(0xffE3DBDB);
      case Status.finalizado:
        return const Color(0xff90BAAD);
      }
  }
}
