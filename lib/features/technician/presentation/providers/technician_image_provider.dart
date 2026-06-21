import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TechnicianImageState {
  const TechnicianImageState({
    this.ktpBytes,
    this.profileBytes,
    this.offerBytes,
  });

  final Uint8List? ktpBytes;
  final Uint8List? profileBytes;
  final Uint8List? offerBytes;

  TechnicianImageState copyWith({
    Uint8List? ktpBytes,
    Uint8List? profileBytes,
    Uint8List? offerBytes,
  }) {
    return TechnicianImageState(
      ktpBytes: ktpBytes ?? this.ktpBytes,
      profileBytes: profileBytes ?? this.profileBytes,
      offerBytes: offerBytes ?? this.offerBytes,
    );
  }
}

class TechnicianImageController extends Notifier<TechnicianImageState> {
  @override
  TechnicianImageState build() => const TechnicianImageState();

  void setKtp(Uint8List bytes) {
    state = state.copyWith(ktpBytes: bytes);
  }

  void setProfile(Uint8List bytes) {
    state = state.copyWith(profileBytes: bytes);
  }

  void setOffer(Uint8List bytes) {
    state = state.copyWith(offerBytes: bytes);
  }
}

final technicianImageProvider =
    NotifierProvider<TechnicianImageController, TechnicianImageState>(
      TechnicianImageController.new,
    );
