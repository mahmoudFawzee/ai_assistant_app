part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

final class ResetSettingsState extends SettingsState {
  const ResetSettingsState();
}