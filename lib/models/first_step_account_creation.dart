class FirstStepAccountCreation {
  final String? fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String vcn;

  FirstStepAccountCreation(
      {this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.password,
      this.vcn = ""});
}
