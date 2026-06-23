import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';

class BookingRepository {
  BookingRepository(this._supabase);

  final SupabaseClient _supabase;

  // ==================== READ ====================

  /// Get booking by ID
  Future<Booking?> getBookingById(String bookingId) async {
    final response = await _supabase
        .from('bookings')
        .select()
        .eq('id', bookingId)
        .maybeSingle();

    if (response == null) return null;
    return Booking.fromJson(response);
  }

  /// Get booking detail dengan joined data
  Future<BookingDetail?> getBookingDetail(String bookingId) async {
    final response = await _supabase
        .from('bookings')
        .select('''
          *,
          service_requests!inner (
            title,
            address
          ),
          technician:technician_id (
            full_name,
            phone
          ),
          customer:customer_id (
            full_name,
            phone
          ),
          payments (
            gross_amount
          )
        ''')
        .eq('id', bookingId)
        .maybeSingle();

    if (response == null) return null;

    final request = response['service_requests'] as Map<String, dynamic>;
    final technician = response['technician'] as Map<String, dynamic>?;
    final customer = response['customer'] as Map<String, dynamic>?;
    final payments = response['payments'] as List<dynamic>?;

    return BookingDetail(
      booking: Booking.fromJson(response),
      serviceTitle: request['title'] as String,
      address: request['address'] as String,
      technicianName: technician?['full_name'] as String? ?? 'Unknown',
      customerName: customer?['full_name'] as String? ?? 'Unknown',
      technicianPhone: technician?['phone'] as String?,
      customerPhone: customer?['phone'] as String?,
      totalAmount: payments?.isNotEmpty == true
          ? (payments!.first['gross_amount'] as num?)?.toDouble()
          : null,
    );
  }

  /// Get customer's bookings
  Future<List<Booking>> getMyBookings({
    BookingStatus? status,
    int limit = 50,
  }) async {
    final customerId = _supabase.auth.currentUser!.id;

    var query = _supabase
        .from('bookings')
        .select()
        .eq('customer_id', customerId)
        .order('created_at', ascending: false)
        .limit(limit);

    if (status != null) {
      query = query.eq('status', status.dbValue);
    }

    final response = await query;
    return (response as List).map((json) => Booking.fromJson(json)).toList();
  }

  /// Get technician's bookings
  Future<List<Booking>> getTechnicianBookings({
    BookingStatus? status,
    int limit = 50,
  }) async {
    final technicianId = _supabase.auth.currentUser!.id;

    var query = _supabase
        .from('bookings')
        .select()
        .eq('technician_id', technicianId)
        .order('created_at', ascending: false)
        .limit(limit);

    if (status != null) {
      query = query.eq('status', status.dbValue);
    }

    final response = await query;
    return (response as List).map((json) => Booking.fromJson(json)).toList();
  }

  /// Get active bookings (for tracking)
  Future<List<Booking>> getActiveBookings() async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from('bookings')
        .select()
        .or('customer_id.eq.$userId,technician_id.eq.$userId')
        .in_(
          'status',
          ['pending_payment', 'confirmed', 'in_progress'],
        )
        .order('created_at', ascending: false);

    return (response as List).map((json) => Booking.fromJson(json)).toList();
  }

  /// Get all bookings (admin)
  Future<List<Booking>> getAllBookings({
    BookingStatus? status,
    int limit = 100,
  }) async {
    var query = _supabase
        .from('bookings')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    if (status != null) {
      query = query.eq('status', status.dbValue);
    }

    final response = await query;
    return (response as List).map((json) => Booking.fromJson(json)).toList();
  }

  // ==================== STATUS UPDATES ====================

  /// Teknisi confirm booking (after payment)
  Future<Booking> confirmBooking(String bookingId) async {
    final response = await _supabase.rpc(
      'confirm_booking',
      params: {'booking_id_param': bookingId},
    );

    return Booking.fromJson(response as Map<String, dynamic>);
  }

  /// Teknisi mark as arrived
  Future<Booking> markArrived(String bookingId) async {
    final response = await _supabase.rpc(
      'mark_technician_arrived',
      params: {'booking_id_param': bookingId},
    );

    return Booking.fromJson(response as Map<String, dynamic>);
  }

  /// Teknisi start work
  Future<Booking> startWork(String bookingId) async {
    final response = await _supabase.rpc(
      'start_booking_work',
      params: {'booking_id_param': bookingId},
    );

    return Booking.fromJson(response as Map<String, dynamic>);
  }

  /// Teknisi complete booking
  Future<Booking> completeBooking(String bookingId, {String? workNotes}) async {
    final response = await _supabase.rpc(
      'complete_booking',
      params: {
        'booking_id_param': bookingId,
        'work_notes_param': workNotes,
      },
    );

    return Booking.fromJson(response as Map<String, dynamic>);
  }

  /// Cancel booking
  Future<Booking> cancelBooking({
    required String bookingId,
    required String reason,
    required String cancelledBy, // 'customer' or 'technician'
  }) async {
    final response = await _supabase.rpc(
      'cancel_booking',
      params: {
        'booking_id_param': bookingId,
        'cancellation_reason_param': reason,
        'cancelled_by_param': cancelledBy,
      },
    );

    return Booking.fromJson(response as Map<String, dynamic>);
  }

  // ==================== LOCATION TRACKING ====================

  /// Update technician location (GPS tracking)
  Future<Booking> updateTechnicianLocation({
    required String bookingId,
    required double latitude,
    required double longitude,
  }) async {
    final response = await _supabase.rpc(
      'update_technician_location',
      params: {
        'booking_id_param': bookingId,
        'latitude': latitude,
        'longitude': longitude,
      },
    );

    return Booking.fromJson(response as Map<String, dynamic>);
  }

  // ==================== NOTES ====================

  /// Update customer notes
  Future<Booking> updateCustomerNotes({
    required String bookingId,
    required String notes,
  }) async {
    final response = await _supabase
        .from('bookings')
        .update({'customer_notes': notes})
        .eq('id', bookingId)
        .select()
        .single();

    return Booking.fromJson(response);
  }

  /// Update work notes
  Future<Booking> updateWorkNotes({
    required String bookingId,
    required String notes,
  }) async {
    final response = await _supabase
        .from('bookings')
        .update({'work_notes': notes})
        .eq('id', bookingId)
        .select()
        .single();

    return Booking.fromJson(response);
  }

  // ==================== REALTIME ====================

  /// Subscribe ke booking status changes
  RealtimeChannel subscribeToBookingStatus(
    String bookingId,
    void Function(Booking) onUpdate,
  ) {
    return _supabase
        .channel('booking_$bookingId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'bookings',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: bookingId,
          ),
          callback: (payload) {
            final booking = Booking.fromJson(
              payload.newRecord as Map<String, dynamic>,
            );
            onUpdate(booking);
          },
        )
        .subscribe();
  }

  /// Subscribe ke technician location updates (for customer tracking)
  RealtimeChannel subscribeToLocationUpdates(
    String bookingId,
    void Function(TechnicianLocation) onLocationUpdate,
  ) {
    return _supabase
        .channel('location_$bookingId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'bookings',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: bookingId,
          ),
          callback: (payload) {
            final record = payload.newRecord as Map<String, dynamic>;
            if (record['technician_location_lat'] != null &&
                record['technician_location_lng'] != null) {
              final location = TechnicianLocation(
                latitude: (record['technician_location_lat'] as num).toDouble(),
                longitude:
                    (record['technician_location_lng'] as num).toDouble(),
                updatedAt: record['location_updated_at'] != null
                    ? DateTime.parse(record['location_updated_at'] as String)
                    : DateTime.now(),
              );
              onLocationUpdate(location);
            }
          },
        )
        .subscribe();
  }

  // ==================== STATISTICS ====================

  /// Get booking statistics (admin)
  Future<Map<String, dynamic>?> getBookingStatistics() async {
    final response =
        await _supabase.from('booking_statistics').select().maybeSingle();

    return response;
  }

  /// Get technician performance
  Future<Map<String, dynamic>?> getTechnicianPerformance(
    String technicianId,
  ) async {
    final response = await _supabase
        .from('technician_performance')
        .select()
        .eq('technician_id', technicianId)
        .maybeSingle();

    return response;
  }
}
