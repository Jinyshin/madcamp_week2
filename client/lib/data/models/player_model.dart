class Player {
  final String userId;
  final String socketID;
  final double points;
  final String playerType;
  Player({
    required this.userId,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      userId: map['userId'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerType: map['playerType'] ?? '',
    );
  }

  Player copyWith({
    String? userId,
    String? socketID,
    double? points,
    String? playerType,
  }) {
    return Player(
      userId: userId ?? this.userId,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
