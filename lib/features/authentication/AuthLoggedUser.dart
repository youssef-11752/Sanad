import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {
  final String id;
  final String fullName;
  final String? email;
  final String? phone;
  final String? profileImage;
  final int userTypeId;
  final String role; // "customer" | "provider" | "admin"

  UserProfile({
    required this.id,
    required this.fullName,
    this.email,
    this.phone,
    this.profileImage,
    required this.userTypeId,
    required this.role,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      fullName: (map['full_name'] ?? '') as String,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      profileImage: map['profile_image'] as String?,
      userTypeId: map['user_type_id'] as int,
      role: (map['user_types']?['name'] ?? 'customer') as String,
    );
  }
}

class AuthLoggedUser extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  StreamSubscription<AuthState>? _sub;

  Session? session;
  UserProfile? profile;
  bool loading = true;

  bool get isLoggedIn => session != null;
  String? get role => profile?.role;
  bool get isProvider => role == 'provider';

  AuthLoggedUser() {
    _init();
  }

  Future<void> _init() async {
    // 1. Restore the saved session (Supabase persists it on the device)
    session = _client.auth.currentSession;
    if (session != null) {
      await _loadProfile(session!.user.id);
    }
    loading = false;
    notifyListeners();

    // 2. React to login / logout / token refresh
    _sub = _client.auth.onAuthStateChange.listen((data) async {
      session = data.session;
      if (session != null) {
        await _loadProfile(session!.user.id);
      } else {
        profile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadProfile(String userId) async {
    try {
      final data = await _client
          .from('users')
          .select('*, user_types(name)')
          .eq('id', userId)
          .single();
      profile = UserProfile.fromMap(data);
    } catch (e) {
      debugPrint('Failed to load profile: $e');
      profile = null;
    }
  }

  Future<void> signIn(String email, String password) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    // These values are read by the handle_new_user() trigger
    await _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName, 'phone': phone},
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}