// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_tab_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningTabStatisticsResponse _$LearningTabStatisticsResponseFromJson(
  Map<String, dynamic> json,
) => LearningTabStatisticsResponse(
  totalTimeLearning: json['total_time_learning'] as String? ?? '',
  inProgress: json['in_progress'] as String? ?? '',
  completed: json['completed'] as String? ?? '',
);

Map<String, dynamic> _$LearningTabStatisticsResponseToJson(
  LearningTabStatisticsResponse instance,
) => <String, dynamic>{
  'total_time_learning': instance.totalTimeLearning,
  'in_progress': instance.inProgress,
  'completed': instance.completed,
};
