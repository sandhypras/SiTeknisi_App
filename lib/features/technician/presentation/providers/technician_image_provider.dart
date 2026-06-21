import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _ktpImageKey = 'technician_ktp_image';
const _profileImageKey = 'technician_profile_image';
const _offerImageKey = 'technician_offer_image';

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
  TechnicianImageState build() {
    unawaited(_restoreImages());
    return const TechnicianImageState();
  }

  void setKtp(Uint8List bytes) {
    state = state.copyWith(ktpBytes: bytes);
    unawaited(_saveImage(_ktpImageKey, bytes));
  }

  void setProfile(Uint8List bytes) {
    state = state.copyWith(profileBytes: bytes);
    unawaited(_saveImage(_profileImageKey, bytes));
  }

  void setOffer(Uint8List bytes) {
    state = state.copyWith(offerBytes: bytes);
    unawaited(_saveImage(_offerImageKey, bytes));
  }

  Future<void> _restoreImages() async {
    final preferences = await SharedPreferences.getInstance();
    final restored = TechnicianImageState(
      ktpBytes: _decodeImage(preferences.getString(_ktpImageKey)),
      profileBytes: _decodeImage(preferences.getString(_profileImageKey)),
      offerBytes: _decodeImage(preferences.getString(_offerImageKey)),
    );

    if (ref.mounted) state = restored;
  }

  Future<void> _saveImage(String key, Uint8List bytes) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, base64Encode(bytes));
  }

  Uint8List? _decodeImage(String? encodedImage) {
    if (encodedImage == null || encodedImage.isEmpty) return null;
    try {
      final bytes = base64Decode(encodedImage);
      return bytes.isEmpty ? null : bytes;
    } on FormatException {
      return null;
    }
  }
}

final technicianImageProvider =
    NotifierProvider<TechnicianImageController, TechnicianImageState>(
      TechnicianImageController.new,
    );
