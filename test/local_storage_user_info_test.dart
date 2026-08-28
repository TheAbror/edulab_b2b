import 'package:flutter_test/flutter_test.dart';
import 'package:edulab_b2b/core/local_datasource/model/local_storage_user_info.dart';

void main() {
  test('LocalStorageUserInfo round-trips profile fields through json', () {
    final original = LocalStorageUserInfo(
      id: 14,
      username: '1001',
      firstName: 'Anna',
      lastName: 'Kareemoffa',
      account_type_str: 'Instructor',
      email: 'annaWatson@gmail.com',
      status: 'ACTIVE',
      profile_photo: null,
      phone: '998000000002',
      department: 'Marketing Department',
      jobPosition: 'Senior Marketing Specialist',
    );

    final restored = LocalStorageUserInfo.fromJson(original.toJson());

    expect(restored.phone, '998000000002');
    expect(restored.department, 'Marketing Department');
    expect(restored.jobPosition, 'Senior Marketing Specialist');
    expect(restored.username, '1001');
    expect(restored.email, 'annaWatson@gmail.com');
  });

  test('LocalStorageUserInfo tolerates missing profile fields', () {
    final restored = LocalStorageUserInfo.fromJson({
      'id': 1,
      'username': 'u',
      'firstName': 'a',
      'lastName': 'b',
    });

    expect(restored.phone, anyOf(isNull, isEmpty));
    expect(restored.department, anyOf(isNull, isEmpty));
    expect(restored.jobPosition, anyOf(isNull, isEmpty));
  });
}
