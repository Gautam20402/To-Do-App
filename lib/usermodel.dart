class Usermodel {
  String? uid;
  String? email;
  String? firstname;
  String? secondname;

  Usermodel({
    this.uid ,this.email ,
    this.firstname,this.secondname
});

  factory Usermodel.fromMap(map){
    return Usermodel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstname'],
      secondname: map['secondname']
    );
  }

  Map<String,dynamic>toMap(){
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'secondname': secondname,
    };
  }
}

