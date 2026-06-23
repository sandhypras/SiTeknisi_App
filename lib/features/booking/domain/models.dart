enum BookingStatus {
  pendingPayment('pending_payment'),
  confirmed,
  inProgress('in_progress'),
  completed,
  cancelled;

  const BookingStatus([this.value]);
  final String? value;

  String get dbValue => value ?? name;

  static BookingStatus fromString(String value) {
    return BookingStatus.values.firstWhere(
      (e) => e.dbValue == value,
      orElse: () => BookingStatus.pendingPayment,
    );
  }

  /// Status display name untuk UI
  String get displayName {
    switch (this) {
      case BookingStatus.pendingPayment:
        return 'Menunggu Pembayaran';
      case BookingStatus.confirmed:
        return 'Dikonfirmasi';
      case BookingStatus.inProgress:
        return 'Sedang Dikerjakan';
      case BookingStatus.completed:
        return 'Selesai';
      case BookingStatus.cancelled:
        return 'Dibatalkan';
    }
  }
}

class TechnicianLocation {
  const TechnicianLocation({
    required this.latitude,
    required this.longitude,
    required this.updatedAt,
  });

  final double latitude;
  final double longitude;
  final DateTime updatedAt;

  /// Check if location is stale (older than 5 minutes)
  bool get isStale =>
      DateTime.now().difference(updatedAt).inMinutes > 5;
}

class Booking {
  const Booking({
    required this.id,
    required this.requestId,
    required this.offerId,
    required this.customerId,
    required this.technicianId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.technicianLocation,
    this.arrivalTime,
    this.startedAt,
    this.workStartedAt,
    this.completedAt,
    this.workNotes,
    this.customerNotes,
    this.cancellationReason,
    this.cancelledBy,
    this.cancelledAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    TechnicianLocation? location;
    if (json['technician_location_lat'] != null &&
        json['technician_location_lng'] != null) {
      location = TechnicianLocation(
        latitude: (json['technician_location_lat'] as num).toDouble(),
        longitude: (json['technician_location_lng'] as num).toDouble(),
        updatedAt: json['location_updated_at'] != null
            ? DateTime.parse(json['location_updated_at'] as String)
            : DateTime.now(),
      );
    }

    return Booking(
      id: json['id'] as String,
      requestId: json['request_id'] as String,
      offerId: json['offer_id'] as String,
      customerId: json['customer_id'] as String,
      technicianId: json['technician_id'] as String,
      status: BookingStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      technicianLocation: location,
      arrivalTime: json['arrival_time'] != null
          ? DateTime.parse(json['arrival_time'] as String)
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'] as String)
          : null,
      workStartedAt: json['work_started_at'] != null
          ? DateTime.parse(json['work_started_at'] as String)
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      workNotes: json['work_notes'] as String?,
      customerNotes: json['customer_notes'] as String?,
      cancellationReason: json['cancellation_reason'] as String?,
      cancelledBy: json['cancelled_by'] as String?,
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'] as String)
          : null,
    );
  }

  final String id;
  final String requestId;
  final String offerId;
  final String customerId;
  final String technicianId;
  final BookingStatus status;
  final TechnicianLocation? technicianLocation;
  final DateTime? arrivalTime;
  final DateTime? startedAt;
  final DateTime? workStartedAt;
  final DateTime? completedAt;
  final String? workNotes;
  final String? customerNotes;
  final String? cancellationReason;
  final String? cancelledBy;
  final DateTime? cancelledAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Helper: check if technician has arrived
  bool get hasArrived => arrivalTime != null;

  /// Helper: check if work is in progress
  bool get isWorkInProgress => status == BookingStatus.inProgress;

  /// Helper: check if booking is active (not completed/cancelled)
  bool get isActive =>
      status != BookingStatus.completed && status != BookingStatus.cancelled;

  /// Helper: calculate work duration (if completed)
  Duration? get workDuration {
    if (completedAt != null && workStartedAt != null) {
      return completedAt!.difference(workStartedAt!);
    }
    return null;
  }

  /// Helper: calculate arrival time from booking creation
  Duration? get arrivalDuration {
    if (arrivalTime != null) {
      return arrivalTime!.difference(createdAt);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_id': requestId,
      'offer_id': offerId,
      'customer_id': customerId,
      'technician_id': technicianId,
      'status': status.dbValue,
      'technician_location_lat': technicianLocation?.latitude,
      'technician_location_lng': technicianLocation?.longitude,
      'location_updated_at': technicianLocation?.updatedAt.toIso8601String(),
      'arrival_time': arrivalTime?.toIso8601String(),
      'started_at': startedAt?.toIso8601String(),
      'work_started_at': workStartedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'work_notes': workNotes,
      'customer_notes': customerNotes,
      'cancellation_reason': cancellationReason,
      'cancelled_by': cancelledBy,
      'cancelled_at': cancelledAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// Booking dengan detail tambahan (service, technician, customer info)
class BookingDetail {
  const BookingDetail({
    required this.booking,
    required this.serviceTitle,
    required this.technicianName,
    required this.customerName,
    required this.address,
    this.technicianPhone,
    this.customerPhone,
    this.totalAmount,
  });

  final Booking booking;
  final String serviceTitle;
  final String technicianName;
  final String customerName;
  final String address;
  final String? technicianPhone;
  final String? customerPhone;
  final double? totalAmount;
}
