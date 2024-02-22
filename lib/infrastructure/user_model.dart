class UserModel{
  String id;
  String name;
  String email;
  String profile;
  String profession;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
    required this.profession
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profile,
    String? profession
  }){
    return UserModel(
      id: id ?? this.id, 
      name: name ?? this.name, 
      email: email ?? this.email, 
      profile: profile ?? this.profile,
      profession: profession ?? this.profession);
  }

}