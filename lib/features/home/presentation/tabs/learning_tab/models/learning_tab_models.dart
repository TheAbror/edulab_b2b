import 'package:json_annotation/json_annotation.dart';

part 'learning_tab_models.g.dart';

// {
//     "streak": {
//         "days": {
//             "monday": true,
//             "tuesday": false,
//             "wednesday": true,
//             "thursday": false,
//             "friday": true,
//             "saturday": false,
//             "sunday": false
//         },
//         "label": "You're on a 18-day streak!"
//     },
//     "total_time_learning": "47 hours 29 minutes",
//     "in_progress": "1 course",
//     "completed": "4 courses"
// }

@JsonSerializable(includeIfNull: true)
class LearningTabStatisticsResponse {
  @JsonKey()
  final StreakResponse streak;
  @JsonKey(defaultValue: '', name: 'total_time_learning')
  final String totalTimeLearning;
  @JsonKey(defaultValue: '', name: 'in_progress')
  final String inProgress;
  @JsonKey(defaultValue: '')
  final String completed;

  LearningTabStatisticsResponse({
    required this.streak,
    required this.totalTimeLearning,
    required this.inProgress,
    required this.completed,
  });

  factory LearningTabStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$LearningTabStatisticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LearningTabStatisticsResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class StreakResponse {
  @JsonKey()
  final StreakDaysResponse days;
  @JsonKey(defaultValue: '')
  final String label;

  StreakResponse({
    required this.days,
    required this.label,
  });

  factory StreakResponse.fromJson(Map<String, dynamic> json) =>
      _$StreakResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StreakResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class StreakDaysResponse {
  @JsonKey(defaultValue: false)
  final bool monday;
  @JsonKey(defaultValue: false)
  final bool tuesday;
  @JsonKey(defaultValue: false)
  final bool wednesday;
  @JsonKey(defaultValue: false)
  final bool thursday;
  @JsonKey(defaultValue: false)
  final bool friday;
  @JsonKey(defaultValue: false)
  final bool saturday;
  @JsonKey(defaultValue: false)
  final bool sunday;

  StreakDaysResponse({
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.monday,
  });

  factory StreakDaysResponse.fromJson(Map<String, dynamic> json) =>
      _$StreakDaysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StreakDaysResponseToJson(this);
}
