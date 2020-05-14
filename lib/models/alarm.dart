import 'package:flutter/material.dart';

import 'medicine.dart';


class Alarm {
  TimeOfDay time;

  List<Medicine> medicines;

  Alarm(this.time, this.medicines);
}
