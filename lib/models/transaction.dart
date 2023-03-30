class Transaction {
  late String id;
  late String title;
  late double price;
  late DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.price,
      required this.date});
}
