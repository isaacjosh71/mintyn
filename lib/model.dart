class User {
  final String place;
  final String location;
  final String years;
  final String help;
  final String pounds;
  final String plants;
  final List<String> tags;
  final String profileImage;

  User({
    required this.place,
    required this.location,
    required this.years,
    required this.help,
    required this.pounds,
    required this.plants,
    required this.tags,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      place: json['place'],
      location: json['location'],
      years: json['years'],
      help: json['help'],
      pounds: json['pounds'],
      plants: json['plants'],
      tags: List<String>.from(json['tags']),
      profileImage: json['profileImage'],
    );
  }
}
