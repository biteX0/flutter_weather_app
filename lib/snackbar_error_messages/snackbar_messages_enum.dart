enum SnackBarMessages {
  userNotFound('Пользователь не найден'),
  accountExists('Данный аккаунт уже существует'),
  passwordsDontMatch('Пароли не совпадают'),
  emailSend('Письмо для сброса пароля отправлено: '),
  errorResetPassword('Ошибка сброса пароля'),
  enterCityName('Введите название города'),
  notFoundCity('Не удалось найти город'),
  ethernetConnectionNotFound('Нет подключения к интернету'),
  locationPermissionDenied('Нет доступа к местоположению'),
  serverIsNotResponding('Сервер не отвечает');

  final String msg;

  const SnackBarMessages(this.msg);
}
