import 'package:formz/formz.dart';

enum TimeInputError { empty }

class TimeInput extends FormzInput<String, TimeInputError> {
  const TimeInput.pure() : super.pure('');
  const TimeInput.dirty([String value = '']) : super.dirty(value);

  @override
  TimeInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TimeInputError.empty;
  }
}