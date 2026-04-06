import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../models/user_model.dart';

/// Authentication service using Firebase Auth
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in anonymously
  Future<User?> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('Error signing in anonymously: $e');
      return null;
    }
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is signed in
  bool get isSignedIn => _auth.currentUser != null;

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Get user ID
  String? get userId => _auth.currentUser?.uid;

  /// Initialize user data in Firestore (to be implemented)
  Future<void> initializeUserData(String userId) async {
    // This will be implemented when Firestore service is ready
    print('User data initialization for: $userId');
  }
}

/// Riverpod provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Riverpod provider for authentication state
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Riverpod provider for current user ID
final userIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.value?.uid;
});

/// Local user data provider using Hive
class UserLocalService {
  static const String _userBoxName = 'user_data';

  Future<Box> _openBox() async {
    return await Hive.openBox<UserModel>(_userBoxName);
  }

  /// Save user data locally
  Future<void> saveUserLocally(UserModel user) async {
    final box = await _openBox();
    await box.put('current_user', user);
  }

  /// Get local user data
  Future<UserModel?> getLocalUser() async {
    final box = await _openBox();
    return box.get('current_user');
  }

  /// Clear local user data
  Future<void> clearLocalUser() async {
    final box = await _openBox();
    await box.clear();
  }

  /// Check if user data exists locally
  Future<bool> hasLocalUser() async {
    final box = await _openBox();
    return box.containsKey('current_user');
  }
}

/// Riverpod provider for UserLocalService
final userLocalServiceProvider = Provider<UserLocalService>((ref) {
  return UserLocalService();
});

/// Combined authentication state provider
final combinedAuthProvider = Provider<AsyncValue<({bool isAuthenticated, String? userId, UserModel? userData})>>((ref) {
  final authState = ref.watch(authStateProvider);
  final localService = ref.watch(userLocalServiceProvider);

  return authState.when(
    data: (user) async {
      if (user == null) {
        // Not authenticated, check local data
        final localUser = await localService.getLocalUser();
        return AsyncData((
          isAuthenticated: false,
          userId: null,
          userData: localUser
        ));
      } else {
        // Authenticated, try to get local data
        final localUser = await localService.getLocalUser();
        return AsyncData((
          isAuthenticated: true,
          userId: user.uid,
          userData: localUser
        ));
      }
    },
    loading: () => const AsyncLoading(),
    error: (error, stack) => AsyncError(error, stack),
  );
});