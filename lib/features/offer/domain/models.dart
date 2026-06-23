enum OfferStatus {
  pending,
  accepted,
  rejected,
  expired;

  static OfferStatus fromString(String value) {
    return OfferStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OfferStatus.pending,
    );
  }
}

class ServiceOffer {
  const ServiceOffer({
    required this.id,
    required this.requestId,
    required this.technicianId,
    required this.offerPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.transportFee = 0,
    this.estimatedDuration,
    this.message,
    this.photoUrls,
    this.expiresAt,
  });

  factory ServiceOffer.fromJson(Map<String, dynamic> json) {
    return ServiceOffer(
      id: json['id'] as String,
      requestId: json['request_id'] as String,
      technicianId: json['technician_id'] as String,
      offerPrice: (json['offer_price'] as num).toDouble(),
      status: OfferStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      transportFee: json['transport_fee'] != null
          ? (json['transport_fee'] as num).toDouble()
          : 0,
      estimatedDuration: json['estimated_duration'] as String?,
      message: json['message'] as String?,
      photoUrls: (json['photo_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : null,
    );
  }

  final String id;
  final String requestId;
  final String technicianId;
  final double offerPrice;
  final double transportFee;
  final String? estimatedDuration;
  final String? message;
  final List<String>? photoUrls;
  final OfferStatus status;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Total amount (offer price + transport)
  double get totalAmount => offerPrice + transportFee;

  /// Check if offer is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_id': requestId,
      'technician_id': technicianId,
      'offer_price': offerPrice,
      'transport_fee': transportFee,
      'estimated_duration': estimatedDuration,
      'message': message,
      'photo_urls': photoUrls,
      'status': status.name,
      'expires_at': expiresAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ServiceOffer copyWith({
    String? id,
    String? requestId,
    String? technicianId,
    double? offerPrice,
    double? transportFee,
    String? estimatedDuration,
    String? message,
    List<String>? photoUrls,
    OfferStatus? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceOffer(
      id: id ?? this.id,
      requestId: requestId ?? this.requestId,
      technicianId: technicianId ?? this.technicianId,
      offerPrice: offerPrice ?? this.offerPrice,
      transportFee: transportFee ?? this.transportFee,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      message: message ?? this.message,
      photoUrls: photoUrls ?? this.photoUrls,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Response dari accept_service_offer function
class AcceptOfferResult {
  const AcceptOfferResult({
    required this.success,
    required this.bookingId,
    required this.midtransOrderId,
    required this.totalAmount,
    required this.platformFee,
    required this.technicianIncome,
  });

  factory AcceptOfferResult.fromJson(Map<String, dynamic> json) {
    return AcceptOfferResult(
      success: json['success'] as bool,
      bookingId: json['booking_id'] as String,
      midtransOrderId: json['midtrans_order_id'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      platformFee: (json['platform_fee'] as num).toDouble(),
      technicianIncome: (json['technician_income'] as num).toDouble(),
    );
  }

  final bool success;
  final String bookingId;
  final String midtransOrderId;
  final double totalAmount;
  final double platformFee;
  final double technicianIncome;
}

/// Offer dengan technician profile (untuk display)
class OfferWithTechnician {
  const OfferWithTechnician({
    required this.offer,
    required this.technicianName,
    required this.technicianPhone,
    required this.technicianAvatar,
    this.technicianRating,
    this.completedJobs = 0,
  });

  final ServiceOffer offer;
  final String technicianName;
  final String? technicianPhone;
  final String? technicianAvatar;
  final double? technicianRating;
  final int completedJobs;
}
