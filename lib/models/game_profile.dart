class GameProfile {
  final String id;
  final String name;
  final String packageName;
  bool doNotDisturb;
  bool keepScreenOn;
  bool blockNotifications;

  GameProfile({
    required this.id,
    required this.name,
    required this.packageName,
    this.doNotDisturb = true,
    this.keepScreenOn = true,
    this.blockNotifications = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'packageName': packageName,
        'doNotDisturb': doNotDisturb,
        'keepScreenOn': keepScreenOn,
        'blockNotifications': blockNotifications,
      };

  factory GameProfile.fromJson(Map<String, dynamic> json) => GameProfile(
        id: json['id'],
        name: json['name'],
        packageName: json['packageName'],
        doNotDisturb: json['doNotDisturb'],
        keepScreenOn: json['keepScreenOn'],
        blockNotifications: json['blockNotifications'],
      );
}
