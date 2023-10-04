import 'package:intl/intl.dart';

class Formatter {
  static String currency(String valor) {
    final value = valor.isEmpty == true ? 0 : double.parse(valor);

    return NumberFormat.currency(name: '', locale: 'pt_BR').format(value).toString();
  }

  static String doubleToCurrency(double valor) => NumberFormat.currency(
        name: 'R\$',
        locale: 'pt_BR',
        decimalDigits: 2,
      ).format(valor).toString();

  static String mileage(int value) =>
      NumberFormat.compactLong(locale: 'pt_BR').format(value).toString();
}
