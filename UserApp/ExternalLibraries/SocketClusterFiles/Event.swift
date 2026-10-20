import Foundation

// MARK: - Codable Wrapper for Dynamic Values
struct CodableValue: Codable {
    var value: Any

    init(_ value: Any) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let string = try? container.decode(String.self) {
            value = string
        } else if let dict = try? container.decode([String: CodableValue].self) {
            value = dict
        } else if let array = try? container.decode([CodableValue].self) {
            value = array
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported Codable type")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch value {
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let bool as Bool:
            try container.encode(bool)
        case let string as String:
            try container.encode(string)
        case let dict as [String: CodableValue]:
            try container.encode(dict)
        case let array as [CodableValue]:
            try container.encode(array)
        default:
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: container.codingPath, debugDescription: "Unsupported Codable type"))
        }
    }
}

// MARK: - Core Models
struct EmitEvent: Codable {
    var event: String
    var data: CodableValue?
    var cid: Int
}

struct ReceiveEvent: Codable {
    var data: CodableValue?
    var error: CodableValue?
    var rid: Int
}

struct Channel: Codable {
    var channel: String
    var data: CodableValue?
}

struct AuthChannel: Codable {
    var channel: String
    var data: ChannelData?
}

struct ChannelData: Codable {
    var jwt: String?
}

struct AuthData: Codable {
    var authToken: String?
}

struct HandShake: Codable {
    var event: String
    var data: AuthData
    var cid: Int
}

// MARK: - Factory Methods
class Model {
    
    static func getEmitEventObject(eventName: String, data: Any?, messageId: Int) -> EmitEvent {
        return EmitEvent(event: eventName, data: data.map(CodableValue.init), cid: messageId)
    }

    static func getReceiveEventObject(data: Any?, error: Any?, messageId: Int) -> ReceiveEvent {
        return ReceiveEvent(data: data.map(CodableValue.init), error: error.map(CodableValue.init), rid: messageId)
    }

    static func getChannelObject(data: Any?) -> Channel? {
        guard let dict = data as? [String: Any],
              let channel = dict["channel"] as? String else {
            return nil
        }

        let payload = dict["data"].map(CodableValue.init)
        return Channel(channel: channel, data: payload)
    }

    static func getSubscribeEventObject(channelName: String, messageId: Int) -> EmitEvent {
        let channel = Channel(channel: channelName, data: nil)
        return EmitEvent(event: "#subscribe", data: CodableValue(channel), cid: messageId)
    }

    static func getSubscribeEventObject(channelName: String, messageId: Int, token: String? = nil) -> EmitEvent {
        let authChannel = AuthChannel(channel: channelName, data: ChannelData(jwt: token))
        return EmitEvent(event: "#subscribe", data: CodableValue(authChannel), cid: messageId)
    }

    static func getUnsubscribeEventObject(channelName: String, messageId: Int) -> EmitEvent {
        return EmitEvent(event: "#unsubscribe", data: CodableValue(channelName), cid: messageId)
    }

    static func getPublishEventObject(channelName: String, data: Any?, messageId: Int) -> EmitEvent {
        let channel = Channel(channel: channelName, data: data.map(CodableValue.init))
        return EmitEvent(event: "#publish", data: CodableValue(channel), cid: messageId)
    }

    static func getHandshakeObject(authToken: String?, messageId: Int) -> HandShake {
        return HandShake(event: "#handshake", data: AuthData(authToken: authToken), cid: messageId)
    }
}

