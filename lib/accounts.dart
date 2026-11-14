
class Account {
  String email;
  String phone;
  String companyId;
  String password;

  Account({
    required this.email,
    required this.phone,
    required this.companyId,
    required this.password,
  });
}

List<Account> accounts = [
  Account(
    email: 'tonald@work.com',
    phone: '82150005000',
    companyId: '11234',
    password: '12345678',
  ),
];

Account? currentAccount;

String normalizePhone(String text) {
  String digits = text.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.startsWith('62')) digits = digits.substring(2);
  if (digits.startsWith('0')) digits = digits.substring(1);
  return digits;
}

Account? findByEmail(String email) {
  for (Account account in accounts) {
    if (account.email.toLowerCase() == email.trim().toLowerCase()) return account;
  }
  return null;
}

Account? findByCompanyId(String id) {
  for (Account account in accounts) {
    if (account.companyId == id.trim()) return account;
  }
  return null;
}

Account? findByPhone(String phone) {
  String wanted = normalizePhone(phone);
  if (wanted.isEmpty) return null;
  for (Account account in accounts) {
    if (normalizePhone(account.phone) == wanted) return account;
  }
  return null;
}