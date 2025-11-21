import 'package:equatable/equatable.dart';

class LocalizationState extends Equatable {
  final String languageCode;

  const LocalizationState({required this.languageCode});
  
  @override
  List<Object?> get props => [languageCode];
}
