/*
 * Copyright 2018 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

part of communication;

/// Holds a list of text (SMS) messages from the device.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TextMessageLogDatum extends CARPDatum {
  static const DataFormat CARP_DATA_FORMAT = DataFormat(NameSpace.CARP, CommunicationSamplingPackage.TEXT_MESSAGE_LOG);
  DataFormat get format => CARP_DATA_FORMAT;

  List<TextMessage> textMessageLog;

  TextMessageLogDatum({this.textMessageLog}) : super() {
    textMessageLog ??= List<TextMessage>();
  }

  factory TextMessageLogDatum.fromJson(Map<String, dynamic> json) => _$TextMessageLogDatumFromJson(json);
  Map<String, dynamic> toJson() => _$TextMessageLogDatumToJson(this);

  String toString() => "Text Message Log - size: ${textMessageLog.length}";
}

/// Holds a single text (SMS) message as a [Datum] object.
///
/// Wraps a [TextMessage].
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TextMessageDatum extends CARPDatum {
  static const DataFormat CARP_DATA_FORMAT = DataFormat(NameSpace.CARP, CommunicationSamplingPackage.TEXT_MESSAGE);
  DataFormat get format => CARP_DATA_FORMAT;

  TextMessage textMessage;

  TextMessageDatum() : super();
  factory TextMessageDatum.fromTextMessage(TextMessage msg) => TextMessageDatum()..textMessage = msg;

  factory TextMessageDatum.fromJson(Map<String, dynamic> json) => _$TextMessageDatumFromJson(json);
  Map<String, dynamic> toJson() => _$TextMessageDatumToJson(this);

  String toString() => "Text Message - $textMessage";
}

/// Holds a text messages (SMS).
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TextMessage extends Serializable {
  int id;

  /// The receiver address of this message
  String address;

  /// The text body of this message.
  String body;

  /// The size in bytes of the body of the message.
  int size;
  bool isRead;

  /// The date this message was created.
  DateTime date;

  /// The date this message was sent.
  DateTime dateSent;

  /// The kind of message:
  ///  - draft
  ///  - received
  ///  - sent
  String kind;

  /// The state of the message:
  ///  - delivered
  ///  - fail
  ///  - none
  ///  - sending
  ///  - sent
  String state;

  TextMessage({this.id, this.address, this.body, this.isRead, this.date, this.dateSent, this.kind, this.state})
      : super();

  factory TextMessage.fromSmsMessage(SmsMessage sms) {
    TextMessage msg = new TextMessage(
        id: sms.id, address: sms.address, body: sms.body, isRead: sms.isRead, date: sms.date, dateSent: sms.dateSent);

    if (sms.body != null) msg.size = sms.body.length;

    switch (sms.kind) {
      case SmsMessageKind.Sent:
        msg.kind = 'sent';
        break;
      case SmsMessageKind.Received:
        msg.kind = 'received';
        break;
      case SmsMessageKind.Draft:
        msg.kind = 'draft';
        break;
    }

    switch (sms.state) {
      case SmsMessageState.Delivered:
        msg.state = 'delivered';
        break;
      case SmsMessageState.Fail:
        msg.state = 'fail';
        break;
      case SmsMessageState.None:
        msg.state = 'none';
        break;
      case SmsMessageState.Sending:
        msg.state = 'sending';
        break;
      case SmsMessageState.Sent:
        msg.state = 'sent';
        break;
    }

    return msg;
  }

  factory TextMessage.fromJson(Map<String, dynamic> json) => _$TextMessageFromJson(json);
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);

  String toString() =>
      "Text Message - id: $id, address: $address, is_read: $isRead, date: $date, date_send: $dateSent, kind: $kind, state: $state\n$body";
}

/// Holds a phone log, i.e. a list of phone calls made on the device.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PhoneLogDatum extends CARPDatum {
  static const DataFormat CARP_DATA_FORMAT = DataFormat(NameSpace.CARP, CommunicationSamplingPackage.PHONE_LOG);
  DataFormat get format => CARP_DATA_FORMAT;

  List<PhoneCall> phoneLog = new List<PhoneCall>();

  PhoneLogDatum() : super();

  factory PhoneLogDatum.fromJson(Map<String, dynamic> json) => _$PhoneLogDatumFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneLogDatumToJson(this);

  String toString() => "Phone Log - size: ${phoneLog.length}";
}

/// Phone call data.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PhoneCall extends Serializable {
  /// Date & Time of the call.
  DateTime timestamp;

  /// Type of call:
  ///  - answered
  ///  - incoming
  ///  - blocked
  ///  - missed
  ///  - outgoing
  ///  - rejected
  ///  - voice_mail
  String callType;

  /// Duration of call in ms.
  int duration;

  /// The formatted version of the phone number (if available).
  String formattedNumber;

  /// The phone number
  String number;

  /// The name of the caller (if available).
  String name;

  PhoneCall([this.timestamp, this.callType, this.duration, this.formattedNumber, this.number, this.name]);

  factory PhoneCall.fromCallLogEntry(CallLogEntry call) {
    DateTime timestamp = DateTime.fromMicrosecondsSinceEpoch(call.timestamp);
    String type = "unknown";

    switch (call.callType) {
      case CallType.answeredExternally:
        type = 'answered_externally';
        break;
      case CallType.blocked:
        type = 'blocked';
        break;
      case CallType.incoming:
        type = 'incoming';
        break;
      case CallType.missed:
        type = 'missed';
        break;
      case CallType.outgoing:
        type = 'outgoing';
        break;
      case CallType.rejected:
        type = 'rejected';
        break;
      case CallType.voiceMail:
        type = 'voice_mail';
        break;
      default:
        type = "unknown";
        break;
    }

    return PhoneCall(timestamp, type, call.duration, call.formattedNumber, call.number, call.name);
  }

  factory PhoneCall.fromJson(Map<String, dynamic> json) => _$PhoneCallFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneCallToJson(this);

  String toString() =>
      "phone_call: {timestamp: $timestamp, call_type: $callType, duration: $duration, number: $number, formatted_number: $formattedNumber, name: $name}";
}
