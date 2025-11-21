import 'package:flutter/material.dart';

import '../utility/validations/validation.dart';

extension ValidatorContextExtension on BuildContext {
  Validator get validator => Validator(this);
}
