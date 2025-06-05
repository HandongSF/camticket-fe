class TicketOptionDetail {
  final int optionId;
  final String name;
  final int price;
  final int availableCount;

  TicketOptionDetail({
    required this.optionId,
    required this.name,
    required this.price,
    required this.availableCount,
  });

  factory TicketOptionDetail.fromJson(Map<String, dynamic> json) {
    return TicketOptionDetail(
      optionId: json['optionId'],
      name: json['name'],
      price: json['price'],
      availableCount: json['availableCount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'optionId': optionId,
        'name': name,
        'price': price,
        'availableCount': availableCount,
      };
}
