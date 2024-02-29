enum PaymentType {
  cash,
  creditCard,
}

int paymentTypeToInt(PaymentType paymentType) => paymentType.index;

PaymentType intToPaymentType(int index) => PaymentType.values[index];
