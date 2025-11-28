// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_tab_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningTabStatisticsResponse _$LearningTabStatisticsResponseFromJson(
        Map<String, dynamic> json) =>
    LearningTabStatisticsResponse(
      streak: StreakResponse.fromJson(json['streak'] as Map<String, dynamic>),
      totalTimeLearning: json['total_time_learning'] as String? ?? '',
      inProgress: json['in_progress'] as String? ?? '',
      completed: json['completed'] as String? ?? '',
    );

Map<String, dynamic> _$LearningTabStatisticsResponseToJson(
        LearningTabStatisticsResponse instance) =>
    <String, dynamic>{
      'streak': instance.streak,
      'total_time_learning': instance.totalTimeLearning,
      'in_progress': instance.inProgress,
      'completed': instance.completed,
    };

StreakResponse _$StreakResponseFromJson(Map<String, dynamic> json) =>
    StreakResponse(
      days: StreakDaysResponse.fromJson(json['days'] as Map<String, dynamic>),
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$StreakResponseToJson(StreakResponse instance) =>
    <String, dynamic>{
      'days': instance.days,
      'label': instance.label,
    };

StreakDaysResponse _$StreakDaysResponseFromJson(Map<String, dynamic> json) =>
    StreakDaysResponse(
      tuesday: json['tuesday'] as bool? ?? false,
      wednesday: json['wednesday'] as bool? ?? false,
      thursday: json['thursday'] as bool? ?? false,
      friday: json['friday'] as bool? ?? false,
      saturday: json['saturday'] as bool? ?? false,
      sunday: json['sunday'] as bool? ?? false,
      monday: json['monday'] as bool? ?? false,
    );

Map<String, dynamic> _$StreakDaysResponseToJson(StreakDaysResponse instance) =>
    <String, dynamic>{
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
    };
