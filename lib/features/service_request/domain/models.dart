enum RequestStatus {
  draft,
  open,
  offered,
  booked,
  inProgress('in_progress'),
  completed,
  cancelled;

  const RequestStatus([this.value]);
  final String? value;

  String get dbValue => value ?? name;

  static RequestStatus fromString(String value) {
    return RequestStatus.values.firstWhere(
      (e) => e.dbValue == value,
      orElse: () => RequestStatus.draft,
    );
  }
}

enum RequestUrgency {
  normal,
  urgent;

  static RequestUrgency fromString(String value) {
    return RequestUrgency.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RequestUrgency.normal,
    );
  }
}

class ServiceRequest {
  const ServiceRequest({
    required this.id,
    required this.customerId,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.latitude,
    this.longitude,
    this.photoUrl,
    this.photoUrls,
    this.preferredSchedule,
    this.budgetMin,
    this.budgetMax,
    this.urgency = RequestUrgency.normal,
    this.notes,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      serviceId: json['service_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      status: RequestStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      photoUrl: json['photo_url'] as String?,
      photoUrls: (json['photo_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferredSchedule: json['preferred_schedule'] != null
          ? DateTime.parse(json['preferred_schedule'] as String)
          : null,
      budgetMin: json['budget_min'] != null
          ? (json['budget_min'] as num).toDouble()
          : null,
      budgetMax: json['budget_max'] != null
          ? (json['budget_max'] as num).toDouble()
          : null,
      urgency: json['urgency'] != null
          ? RequestUrgency.fromString(json['urgency'] as String)
          : RequestUrgency.normal,
      notes: json['notes'] as String?,
    );
  }

  final String id;
  final String customerId;
  final String serviceId;
  final String title;
  final String description;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? photoUrl;
  final List<String>? photoUrls;
  final DateTime? preferredSchedule;
  final double? budgetMin;
  final double? budgetMax;
  final RequestStatus status;
  final RequestUrgency urgency;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'service_id': serviceId,
      'title': title,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'photo_url': photoUrl,
      'photo_urls': photoUrls,
      'preferred_schedule': preferredSchedule?.toIso8601String(),
      'budget_min': budgetMin,
      'budget_max': budgetMax,
      'status': status.dbValue,
      'urgency': urgency.name,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ServiceRequest copyWith({
    String? id,
    String? customerId,
    String? serviceId,
    String? title,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    String? photoUrl,
    List<String>? photoUrls,
    DateTime? preferredSchedule,
    double? budgetMin,
    double? budgetMax,
    RequestStatus? status,
    RequestUrgency? urgency,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceRequest(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      serviceId: serviceId ?? this.serviceId,
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photoUrl: photoUrl ?? this.photoUrl,
      photoUrls: photoUrls ?? this.photoUrls,
      preferredSchedule: preferredSchedule ?? this.preferredSchedule,
      budgetMin: budgetMin ?? this.budgetMin,
      budgetMax: budgetMax ?? this.budgetMax,
      status: status ?? this.status,
      urgency: urgency ?? this.urgency,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
