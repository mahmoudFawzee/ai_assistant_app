part of 'localization_cubit.dart';

sealed class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object> get props => [];
}

final class LocalizationInitialState extends LocalizationState {
  const LocalizationInitialState();
}

final class GetLangErrorState extends LocalizationState {
  const GetLangErrorState();
}

final class GotLangState extends LocalizationState {
  final String langCode;
  const GotLangState(this.langCode);
  @override
  List<Object> get props => [langCode];
}

final class LangChangedState extends LocalizationState {
  final String langCode;
  const LangChangedState(this.langCode);
  @override
  List<Object> get props => [langCode];
}
