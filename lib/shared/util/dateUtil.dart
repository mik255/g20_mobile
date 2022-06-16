class AppDateUtil {
 static Map<int, String> month = {
    1: 'Janeiro',
    2: 'Fevereiro',
    3: 'Março',
    4: 'Abril',
    5: 'Maio',
    6: 'Junho',
    7: 'Julho',
    8: 'Agosto',
    9: 'Setembro',
    10: 'Outubro',
    11: 'Novembro',
    12: 'Dezembro',
  };

  static String dateToString(DateTime dateTime){
    return '${dateTime.day} de ${month[dateTime.month]} de ${dateTime.year}';
  }
}
