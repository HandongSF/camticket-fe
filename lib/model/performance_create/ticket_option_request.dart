class TicketOptionRequest {
  final String name;
  final int price;

  TicketOptionRequest({
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
      };
}
