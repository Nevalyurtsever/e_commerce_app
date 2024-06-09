import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'reminder.freezed.dart';
part 'reminder.g.dart';

@unfreezed
class Reminder with _$Reminder {
  factory Reminder({
    required String id,
    required String? title,
    required String description,
    required String market,
    required DateTime date,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, Object?> json) =>
      _$ReminderFromJson(json);
}
