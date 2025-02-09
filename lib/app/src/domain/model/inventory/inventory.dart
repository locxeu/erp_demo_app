class Inventory {
  final String sku;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int qty;
  final String store;

  Inventory({
    required this.sku,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.qty,
    required this.store,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      sku: json['SKU'] ?? '',
      name: json['Name'] ?? '',
      description: json['Description'].toString() ?? '',
      imageUrl: json['ImageUrl'] ?? '',
      price: (json['Price'] ?? 0.0).toDouble(),
      qty: json['Qty'] ?? 0,
      store: json['Store'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Name': name,
      'Description': description,
      'ImageUrl': imageUrl,
      'Price': price,
      'Qty': qty,
      'Store': store,
    };
  }
}