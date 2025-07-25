import 'package:chatmcp/mcp/models/json_rpc_message.dart';
import 'package:chatmcp/mcp/models/server.dart';
import 'package:logging/logging.dart';

import '../client/mcp_client_interface.dart';
import 'memory_server.dart';

class InMemoryClient implements McpClient {
  final MemoryServer server;

  InMemoryClient({required this.server});

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}

  @override
  Future<JSONRPCMessage> sendInitialize() async {
    Logger.root.fine('InMemoryClient sendInitialize');
    return sendMessage(JSONRPCMessage(id: 'init-1', method: 'initialize'));
  }

  @override
  Future<JSONRPCMessage> sendMessage(JSONRPCMessage message) async {
    final result = await server.onmessage(message);
    return result;
  }

  @override
  Future<JSONRPCMessage> sendPing() async {
    return sendMessage(JSONRPCMessage(id: 'ping-1', method: 'ping'));
  }

  @override
  Future<JSONRPCMessage> sendToolCall(
      {required String name,
      required Map<String, dynamic> arguments,
      String? id}) async {
    return sendMessage(JSONRPCMessage(
        id: id,
        method: 'tools/call',
        params: {'name': name, 'arguments': arguments}));
  }

  @override
  Future<JSONRPCMessage> sendToolList() async {
    return sendMessage(JSONRPCMessage(id: 'tool-list-1', method: 'tools/list'));
  }

  @override
  ServerConfig get serverConfig => throw UnimplementedError();
}
