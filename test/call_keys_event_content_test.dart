// SPDX-FileCopyrightText: 2019-Present Christian Kußowski
// SPDX-FileCopyrightText: 2019-Present Contributors to FluffyChat
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:fluffychat/utils/matrix_live_kit_calls/call_keys_event_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const keys = {'index': 3, 'key': 'c2VjcmV0'};
  const member = {'claimed_device_id': 'DEVICE', 'id': '@a:example.org:DEVICE'};

  test('Parse call keys as sent by matrix-js-sdk, without session', () {
    final content = CallKeysEventContent.fromJson({
      'room_id': '!room:example.org',
      'member_id': '@a:example.org:DEVICE',
      'media_key': keys,
      'keys': keys,
      'member': member,
    });

    expect(content.roomId, '!room:example.org');
    expect(content.keys.index, 3);
    expect(content.keys.key, 'c2VjcmV0');
    expect(content.member.claimedDeviceId, 'DEVICE');
    expect(content.session, null);
    expect(content.toJson().containsKey('session'), false);
  });

  test('Parse call keys with session', () {
    final content = CallKeysEventContent.fromJson({
      'room_id': '!room:example.org',
      'keys': keys,
      'member': member,
      'session': {'application': 'm.call', 'call_id': '', 'scope': 'm.room'},
      'sent_ts': 1794560058437,
    });

    expect(content.session?.callId, '');
    expect(content.sentTs, 1794560058437);
    expect(content.toJson()['session'], {
      'application': 'm.call',
      'call_id': '',
      'scope': 'm.room',
    });
  });
}
