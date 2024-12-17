part of 'open_ai_bloc.dart';

sealed class OpenAiState extends Equatable {
  const OpenAiState();
  
  @override
  List<Object> get props => [];
}

final class OpenAiInitial extends OpenAiState {}
