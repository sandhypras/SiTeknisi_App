import 'package:flutter/material.dart';

/// Model untuk kategori layanan (Printer, Komputer, Laptop)
class ServiceCategory {
  const ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.colorHex,
    required this.displayOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      iconName: json['icon_name'] as String,
      colorHex: json['color_hex'] as String,
      displayOrder: json['display_order'] as int,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  final String id;
  final String name;
  final String description;
  final String iconName;
  final String colorHex;
  final int displayOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon_name': iconName,
      'color_hex': colorHex,
      'display_order': displayOrder,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Color get color {
    final hexColor = colorHex.replaceAll('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }

  IconData get icon {
    final iconMap = {
      'print_rounded': Icons.print_rounded,
      'desktop_windows_rounded': Icons.desktop_windows_rounded,
      'laptop_mac_rounded': Icons.laptop_mac_rounded,
    };
    return iconMap[iconName] ?? Icons.handyman_rounded;
  }
}

/// Model untuk layanan/produk
class Service {
  const Service({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.estimatedTime,
    required this.features,
    required this.displayOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.iconUrl,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      basePrice: (json['base_price'] as num).toDouble(),
      estimatedTime: json['estimated_time'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      displayOrder: json['display_order'] as int? ?? 0,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      iconUrl: json['icon_url'] as String?,
    );
  }

  final String id;
  final String categoryId;
  final String name;
  final String description;
  final double basePrice;
  final String estimatedTime;
  final List<String> features;
  final int displayOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? iconUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'base_price': basePrice,
      'estimated_time': estimatedTime,
      'features': features,
      'display_order': displayOrder,
      'is_active': isActive,
      'icon_url': iconUrl,
    };
  }
}
