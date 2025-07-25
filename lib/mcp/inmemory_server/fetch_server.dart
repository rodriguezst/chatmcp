import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'package:html2md/html2md.dart' as html2md;
import 'dart:convert';

import '../inmemory/memory_server.dart';
import '../models/json_rpc_message.dart';

class FetchServer extends MemoryServer {
  static final Map<String, dynamic> _cache = {};
  static const Duration _cacheTimeout = Duration(minutes: 5);

  FetchServer() : super(name: 'fetch-server') {
    addTool(Tool(
      name: 'fetch',
      description: 'Fetches a URL from the internet and optionally extracts its contents as markdown. '
          'This tool grants internet access to fetch up-to-date information from web pages.',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Fetch a URL and return its content',
        properties: [
          Property(name: 'url', type: ToolInputType.string),
          Property(name: 'max_length', type: ToolInputType.integer),
          Property(name: 'start_index', type: ToolInputType.integer),
          Property(name: 'raw', type: ToolInputType.boolean),
        ],
        required: ['url'],
      ),
    ));
  }

  @override
  Future<Map<String, dynamic>> onToolCall(JSONRPCMessage message) async {
    try {
      String name = message.params?['name'];
      
      Map<String, dynamic>? arguments = message.params?['arguments'];
      if (arguments == null) {
        return {'error': 'Arguments cannot be empty'};
      }

      Logger.root
          .fine('fetch_server onToolCall name: $name arguments: $arguments');

      switch (name) {
        case 'fetch':
          return await _handleFetch(arguments);
        default:
          return {'error': 'Unknown tool: $name'};
      }
    } catch (e, stackTrace) {
      Logger.root.severe('FetchServer error: $e\n$stackTrace');
      return {'error': 'Error occurred during fetch: $e'};
    }
  }

  Future<Map<String, dynamic>> _handleFetch(Map<String, dynamic> arguments) async {
    // Validate required parameter
    if (!arguments.containsKey('url') || arguments['url'] == null) {
      return {'error': 'Missing required parameter: url'};
    }

    String url = arguments['url'].toString().trim();
    if (url.isEmpty) {
      return {'error': 'URL cannot be empty'};
    }

    // Validate URL format
    Uri? uri;
    try {
      uri = Uri.parse(url);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return {'error': 'URL must be a valid HTTP or HTTPS URL'};
      }
    } catch (e) {
      return {'error': 'Invalid URL format: $e'};
    }

    // Parse optional parameters
    int maxLength = _getIntParameter(arguments, 'max_length', 5000);
    int startIndex = _getIntParameter(arguments, 'start_index', 0);
    bool raw = _getBoolParameter(arguments, 'raw', false);

    // Validate parameters
    if (maxLength <= 0 || maxLength > 1000000) {
      return {'error': 'max_length must be between 1 and 1,000,000'};
    }
    if (startIndex < 0) {
      return {'error': 'start_index must be non-negative'};
    }

  Future<Map<String, dynamic>> _handleFetch(Map<String, dynamic> arguments) async {
    // Validate required parameter
    if (!arguments.containsKey('url') || arguments['url'] == null) {
      return {'error': 'Missing required parameter: url'};
    }

    String url = arguments['url'].toString().trim();
    if (url.isEmpty) {
      return {'error': 'URL cannot be empty'};
    }

    // Validate URL format
    Uri? uri;
    try {
      uri = Uri.parse(url);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return {'error': 'URL must be a valid HTTP or HTTPS URL'};
      }
    } catch (e) {
      return {'error': 'Invalid URL format: $e'};
    }

    // Parse optional parameters
    int maxLength = _getIntParameter(arguments, 'max_length', 5000);
    int startIndex = _getIntParameter(arguments, 'start_index', 0);
    bool raw = _getBoolParameter(arguments, 'raw', false);

    // Validate parameters
    if (maxLength <= 0 || maxLength > 1000000) {
      return {'error': 'max_length must be between 1 and 1,000,000'};
    }
    if (startIndex < 0) {
      return {'error': 'start_index must be non-negative'};
    }

    try {
      return await _fetchUrl(url, raw, maxLength, startIndex);
    } catch (e) {
      return {'error': 'Failed to fetch URL: $e'};
    }
  }

  Future<Map<String, dynamic>> _fetchUrl(String url, bool raw, int maxLength, int startIndex) async {
    try {
      final client = http.Client();
      
      // Set reasonable timeout and headers
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'ChatMCP/1.0 (+https://github.com/rodriguezst/chatmcp)',
        },
      ).timeout(Duration(seconds: 30));
      
      client.close();
      
      if (response.statusCode >= 400) {
        return {
          'error': 'Failed to fetch $url - status code ${response.statusCode}'
        };
      }
      
      String content = response.body;
      
      // Convert HTML to markdown if not raw
      if (!raw) {
        try {
          content = html2md.convert(content);
        } catch (e) {
          Logger.root.warning('Failed to convert HTML to markdown: $e');
          // Continue with raw HTML if conversion fails
        }
      }
      
      int originalLength = content.length;
      
      // Handle start_index
      if (startIndex >= originalLength) {
        return {
          'result': {
            'content': 'No more content available.',
            'url': url,
            'length': originalLength,
            'truncated': false,
          }
        };
      }
      
      // Apply truncation
      String truncatedContent = content.substring(
        startIndex, 
        (startIndex + maxLength < originalLength) ? startIndex + maxLength : originalLength
      );
      
      bool isTruncated = startIndex + maxLength < originalLength;
      
      String result = 'Contents of $url:\n$truncatedContent';
      
      if (isTruncated) {
        int nextStart = startIndex + maxLength;
        result += '\n\nContent truncated. Call the fetch tool with a start_index of $nextStart to get more content.';
      }
      
      return {
        'result': result
      };
      
    } catch (e) {
      return {'error': 'Failed to fetch $url: $e'};
    }
  }

  int _getIntParameter(Map<String, dynamic> arguments, String key, int defaultValue) {
    if (!arguments.containsKey(key) || arguments[key] == null) {
      return defaultValue;
    }
    
    dynamic value = arguments[key];
    if (value is int) {
      return value;
    }
    if (value is String) {
      try {
        return int.parse(value);
      } catch (e) {
        return defaultValue;
      }
    }
    if (value is double) {
      return value.toInt();
    }
    return defaultValue;
  }

  bool _getBoolParameter(Map<String, dynamic> arguments, String key, bool defaultValue) {
    if (!arguments.containsKey(key) || arguments[key] == null) {
      return defaultValue;
    }
    
    dynamic value = arguments[key];
    if (value is bool) {
      return value;
    }
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return defaultValue;
  }

  // This method would handle the actual HTTP request
  // Currently commented out as it requires async support
  /*
  Future<Map<String, dynamic>> _fetchUrl(String url, bool raw, int maxLength, int startIndex) async {
    try {
      final client = http.Client();
      
      // Set reasonable timeout and headers
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'ChatMCP/1.0 (+https://github.com/rodriguezst/chatmcp)',
        },
      ).timeout(Duration(seconds: 30));
      
      client.close();
      
      if (response.statusCode >= 400) {
        return {
          'error': 'Failed to fetch $url - status code ${response.statusCode}'
        };
      }
      
      String content = response.body;
      
      // Convert HTML to markdown if not raw
      if (!raw) {
        try {
          content = html2md.convert(content);
        } catch (e) {
          Logger.root.warning('Failed to convert HTML to markdown: $e');
          // Continue with raw HTML if conversion fails
        }
      }
      
      int originalLength = content.length;
      
      // Handle start_index
      if (startIndex >= originalLength) {
        return {
          'result': {
            'content': 'No more content available.',
            'url': url,
            'length': originalLength,
            'truncated': false,
          }
        };
      }
      
      // Apply truncation
      String truncatedContent = content.substring(
        startIndex, 
        (startIndex + maxLength < originalLength) ? startIndex + maxLength : originalLength
      );
      
      bool isTruncated = startIndex + maxLength < originalLength;
      
      String result = 'Contents of $url:\n$truncatedContent';
      
      if (isTruncated) {
        int nextStart = startIndex + maxLength;
        result += '\n\nContent truncated. Call the fetch tool with a start_index of $nextStart to get more content.';
      }
      
      return {
        'result': {
          'content': result,
          'url': url,
          'original_length': originalLength,
          'start_index': startIndex,
          'returned_length': truncatedContent.length,
          'truncated': isTruncated,
        }
      };
      
    } catch (e) {
      return {'error': 'Failed to fetch $url: $e'};
    }
  }
  */
}