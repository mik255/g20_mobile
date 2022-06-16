


String paymentToStringView(String? payment) {
  switch (payment) {
    case 'Cartão':
      return 'card';
    case 'Pix':
      return 'pix';
    case 'Lojista':
      return 'logist';
    case 'Dinheiro':
      return 'money';
  }
  return 'null';
}

String toStringViewPayment(String? payment) {
  switch (payment) {
    case 'card':
      return 'Cartão';
    case 'pix':
      return 'Pix';
    case 'logist':
      return 'Lojista';
    case 'money':
      return 'Dinheiro';
  }
  return 'null';
}