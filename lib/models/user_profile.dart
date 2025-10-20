// lib/models/user_profile.dart

enum UserType {
  user,
  influencer,
  makeupArtist,
}

class UserProfile {
  final String id;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final UserType type;
  final int followersCount;
  final int followingCount;
  final int reviewsCount;
  final int postsCount;
  final String? location;
  final List<String>? favoriteProducts; // IDs prodotti preferiti
  final List<String>? tags; // es. ['skincare', 'makeup', 'luxury']
  
  // Info pelle (se pubbliche)
  final String? skinType;
  final String? skinTone;
  final String? undertone;
  
  UserProfile({
    required this.id,
    required this.username,
    this.displayName,
    this.avatarUrl,
    this.bio,
    required this.type,
    this.followersCount = 0,
    this.followingCount = 0,
    this.reviewsCount = 0,
    this.postsCount = 0,
    this.location,
    this.favoriteProducts,
    this.tags,
    this.skinType,
    this.skinTone,
    this.undertone,
  });
  
  // Conversione da JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      type: _userTypeFromString(json['type'] as String),
      followersCount: json['followersCount'] as int? ?? 0,
      followingCount: json['followingCount'] as int? ?? 0,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      postsCount: json['postsCount'] as int? ?? 0,
      location: json['location'] as String?,
      favoriteProducts: (json['favoriteProducts'] as List<dynamic>?)?.cast<String>(),
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      skinType: json['skinType'] as String?,
      skinTone: json['skinTone'] as String?,
      undertone: json['undertone'] as String?,
    );
  }
  
  // Conversione a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'type': _userTypeToString(type),
      'followersCount': followersCount,
      'followingCount': followingCount,
      'reviewsCount': reviewsCount,
      'postsCount': postsCount,
      'location': location,
      'favoriteProducts': favoriteProducts,
      'tags': tags,
      'skinType': skinType,
      'skinTone': skinTone,
      'undertone': undertone,
    };
  }
  
  // Helper per tipo utente
  static UserType _userTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'influencer':
        return UserType.influencer;
      case 'makeup_artist':
      case 'makeupartist':
        return UserType.makeupArtist;
      default:
        return UserType.user;
    }
  }
  
  static String _userTypeToString(UserType type) {
    switch (type) {
      case UserType.influencer:
        return 'Influencer';
      case UserType.makeupArtist:
        return 'Make-up Artist';
      case UserType.user:
        return 'Utente';
    }
  }
  
  String getTypeDisplayName() {
    return _userTypeToString(type);
  }
  
  // Helper per formattare i follower (es. 12.5K)
  String getFormattedFollowers() {
    if (followersCount >= 1000000) {
      return '${(followersCount / 1000000).toStringAsFixed(1)}M';
    } else if (followersCount >= 1000) {
      return '${(followersCount / 1000).toStringAsFixed(1)}K';
    }
    return followersCount.toString();
  }
}
