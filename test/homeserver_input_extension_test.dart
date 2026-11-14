// SPDX-FileCopyrightText: 2019-Present Christian Kußowski
// SPDX-FileCopyrightText: 2019-Present Contributors to FluffyChat
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:fluffychat/utils/sign_in_flows/homeserver_input_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Homeserver input without scheme defaults to https', () {
    const expected = {
      'matrix.org': 'https://matrix.org',
      'example.org:8448': 'https://example.org:8448',
      'localhost:8448': 'https://localhost:8448',
      '127.0.0.1:8008': 'https://127.0.0.1:8008',
    };
    for (final MapEntry(key: input, value: url) in expected.entries) {
      final uri = Uri.parse(input.withHttpsAsDefaultScheme);
      expect(uri.toString(), url);
      expect(uri.host, isNotEmpty);
    }
  });

  test('Homeserver input with scheme is kept', () {
    for (final input in [
      'http://localhost:8008',
      'http://127.0.0.1:8008',
      'https://example.org:8448',
    ]) {
      expect(Uri.parse(input.withHttpsAsDefaultScheme).toString(), input);
    }
  });
}
