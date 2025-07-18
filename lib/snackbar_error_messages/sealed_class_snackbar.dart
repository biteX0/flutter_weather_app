import 'package:weather/snackbar_error_messages/snackbar_messages_enum.dart';

sealed class AppSnackBar {
  String get message;
}

class PredefinedMessage extends AppSnackBar {
  final SnackBarMessages key;

  PredefinedMessage(this.key);

  @override
  String get message => key.msg;
}

class ErrorMessage extends AppSnackBar {
  final String message;
  ErrorMessage(this.message);
}