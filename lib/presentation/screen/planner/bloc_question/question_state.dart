import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class PlannerQuestionState {
  const PlannerQuestionState();

  @override
  List<Object> get props => [];
}

class PlannerNextQuestion extends PlannerQuestionState {}

class PlannerPreviousQuestion extends PlannerQuestionState {}

class PlannerQuestionInitial extends PlannerQuestionState {}

class PlannerQuestionCompleted extends PlannerQuestionState {}

class PlannerQuestionError extends PlannerQuestionState {
  final String message;
  PlannerQuestionError({required this.message});
}
