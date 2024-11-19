class ContactModal {
  late int id;
  late String name, phoneNo, email;

  ContactModal(
      {required this.id,
      required this.name,
      required this.phoneNo,
      required this.email});

  factory ContactModal.fromMap(Map m1) {
    return ContactModal(
        id: m1['id'],
        name: m1['name'],
        phoneNo: m1['phoneNo'],
        email: m1['email']);
  }
}

Map toMap(ContactModal contact)
{
  return {
    'id' : contact.id,
    'name' : contact.name,
    'phoneNo' : contact.phoneNo,
    'email' : contact.email,
  };
}
