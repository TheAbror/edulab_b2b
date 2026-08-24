import 'package:json_annotation/json_annotation.dart';

part 'learning_tab_models.g.dart';

// {
//     "total_time_learning": "47 hours 29 minutes",
//     "in_progress": "1 course",
//     "completed": "4 courses"
// }

@JsonSerializable(includeIfNull: true)
class LearningTabStatisticsResponse {
  @JsonKey(defaultValue: '', name: 'total_time_learning')
  final String totalTimeLearning;
  @JsonKey(defaultValue: '', name: 'in_progress')
  final String inProgress;
  @JsonKey(defaultValue: '')
  final String completed;

  LearningTabStatisticsResponse({
    required this.totalTimeLearning,
    required this.inProgress,
    required this.completed,
  });

  factory LearningTabStatisticsResponse.initial() {
    return LearningTabStatisticsResponse(
      totalTimeLearning: '',
      inProgress: '',
      completed: '',
    );
  }

  factory LearningTabStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$LearningTabStatisticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LearningTabStatisticsResponseToJson(this);
}
