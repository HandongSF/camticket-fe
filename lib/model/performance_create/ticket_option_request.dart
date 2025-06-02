class TicketOptionRequest {
  final String name;
  final int price;
  final int count;

  TicketOptionRequest({
    required this.name,
    required this.price,
    required this.count,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'count': count,
      };
}
