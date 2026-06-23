import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';
import '../data/booking_repository.dart';

// Repository provider
final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepository(Supabase.instance.client);
});

// ==================== READ PROVIDERS ====================

/// Get booking by ID
final bookingByIdProvider =
    FutureProvider.family<Booking?, String>((ref, bookingId) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getBookingById(bookingId);
});

/// Get booking detail with joined data
final bookingDetailProvider =
    FutureProvider.family<BookingDetail?, String>((ref, bookingId) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getBookingDetail(bookingId);
});

/// Get customer's bookings
final myBookingsProvider =
    FutureProvider.family<List<Booking>, BookingStatus?>((ref, status) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getMyBookings(status: status);
});

/// Get technician's bookings
final technicianBookingsProvider =
    FutureProvider.family<List<Booking>, BookingStatus?>((ref, status) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getTechnicianBookings(status: status);
});

/// Get active bookings (for tracking)
final activeBookingsProvider = FutureProvider<List<Booking>>((ref) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getActiveBookings();
});

/// Get all bookings (admin)
final allBookingsProvider =
    FutureProvider.family<List<Booking>, BookingStatus?>((ref, status) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getAllBookings(status: status);
});

/// Get booking statistics (admin)
final bookingStatisticsProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getBookingStatistics();
});

/// Get technician performance
final technicianPerformanceProvider =
    FutureProvider.family<Map<String, dynamic>?, String>(
  (ref, technicianId) async {
    final repository = ref.watch(bookingRepositoryProvider);
    return repository.getTechnicianPerformance(technicianId);
  },
);

// ==================== ACTION PROVIDERS ====================

/// Confirm booking (technician, after payment)
final confirmBookingProvider = Provider<Future<Booking> Function(String)>(
  (ref) {
    return (bookingId) async {
      final repository = ref.read(bookingRepositoryProvider);
      final booking = await repository.confirmBooking(bookingId);

      // Invalidate relevant providers
      ref.invalidate(bookingByIdProvider(bookingId));
      ref.invalidate(bookingDetailProvider(bookingId));
      ref.invalidate(technicianBookingsProvider);
      ref.invalidate(activeBookingsProvider);

      return booking;
    };
  },
);

/// Mark as arrived (technician)
final markArrivedProvider = Provider<Future<Booking> Function(String)>((ref) {
  return (bookingId) async {
    final repository = ref.read(bookingRepositoryProvider);
    final booking = await repository.markArrived(bookingId);

    // Invalidate relevant providers
    ref.invalidate(bookingByIdProvider(bookingId));
    ref.invalidate(bookingDetailProvider(bookingId));
    ref.invalidate(technicianBookingsProvider);

    return booking;
  };
});

/// Start work (technician)
final startWorkProvider = Provider<Future<Booking> Function(String)>((ref) {
  return (bookingId) async {
    final repository = ref.read(bookingRepositoryProvider);
    final booking = await repository.startWork(bookingId);

    // Invalidate relevant providers
    ref.invalidate(bookingByIdProvider(bookingId));
    ref.invalidate(bookingDetailProvider(bookingId));
    ref.invalidate(technicianBookingsProvider);
    ref.invalidate(activeBookingsProvider);

    return booking;
  };
});

/// Complete booking (technician)
final completeBookingProvider =
    Provider<Future<Booking> Function(String, String?)>((ref) {
  return (bookingId, workNotes) async {
    final repository = ref.read(bookingRepositoryProvider);
    final booking =
        await repository.completeBooking(bookingId, workNotes: workNotes);

    // Invalidate all booking providers
    ref.invalidate(bookingByIdProvider(bookingId));
    ref.invalidate(bookingDetailProvider(bookingId));
    ref.invalidate(myBookingsProvider);
    ref.invalidate(technicianBookingsProvider);
    ref.invalidate(activeBookingsProvider);

    return booking;
  };
});

/// Cancel booking
final cancelBookingProvider =
    Provider<Future<Booking> Function(CancelBookingParams)>((ref) {
  return (params) async {
    final repository = ref.read(bookingRepositoryProvider);
    final booking = await repository.cancelBooking(
      bookingId: params.bookingId,
      reason: params.reason,
      cancelledBy: params.cancelledBy,
    );

    // Invalidate all booking providers
    ref.invalidate(bookingByIdProvider(params.bookingId));
    ref.invalidate(bookingDetailProvider(params.bookingId));
    ref.invalidate(myBookingsProvider);
    ref.invalidate(technicianBookingsProvider);
    ref.invalidate(activeBookingsProvider);

    return booking;
  };
});

/// Update technician location (GPS tracking)
final updateTechnicianLocationProvider =
    Provider<Future<Booking> Function(UpdateLocationParams)>((ref) {
  return (params) async {
    final repository = ref.read(bookingRepositoryProvider);
    final booking = await repository.updateTechnicianLocation(
      bookingId: params.bookingId,
      latitude: params.latitude,
      longitude: params.longitude,
    );

    // Only invalidate location-specific data
    ref.invalidate(bookingByIdProvider(params.bookingId));

    return booking;
  };
});

/// Update customer notes
final updateCustomerNotesProvider =
    Provider<Future<Booking> Function(String, String)>((ref) {
  return (bookingId, notes) async {
    final repository = ref.read(bookingRepositoryProvider);
    final booking = await repository.updateCustomerNotes(
      bookingId: bookingId,
      notes: notes,
    );

    ref.invalidate(bookingByIdProvider(bookingId));
    ref.invalidate(bookingDetailProvider(bookingId));

    return booking;
  };
});

/// Update work notes
final updateWorkNotesProvider =
    Provider<Future<Booking> Function(String, String)>((ref) {
  return (bookingId, notes) async {
    final repository = ref.read(bookingRepositoryProvider);
    final booking = await repository.updateWorkNotes(
      bookingId: bookingId,
      notes: notes,
    );

    ref.invalidate(bookingByIdProvider(bookingId));
    ref.invalidate(bookingDetailProvider(bookingId));

    return booking;
  };
});

// ==================== PARAMETER CLASSES ====================

class CancelBookingParams {
  const CancelBookingParams({
    required this.bookingId,
    required this.reason,
    required this.cancelledBy,
  });

  final String bookingId;
  final String reason;
  final String cancelledBy; // 'customer' or 'technician'
}

class UpdateLocationParams {
  const UpdateLocationParams({
    required this.bookingId,
    required this.latitude,
    required this.longitude,
  });

  final String bookingId;
  final double latitude;
  final double longitude;
}
