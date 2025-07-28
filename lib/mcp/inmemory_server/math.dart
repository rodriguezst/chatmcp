import 'package:logging/logging.dart';
import 'dart:math' as math;

import '../inmemory/memory_server.dart';
import '../models/json_rpc_message.dart';

class MathServer extends MemoryServer {
  MathServer() : super(name: 'math-server') {
    addTool(Tool(
      name: 'add',
      description: 'Add two numbers',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Add two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'subtract',
      description: 'Subtract two numbers',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Subtract two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'multiply',
      description: 'Multiply two numbers',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Multiply two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'divide',
      description: 'Divide two numbers',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Divide two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'power',
      description: 'Power of two numbers',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Power of two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'sqrt',
      description: 'Square root of a number',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Square root of a number',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'cbrt',
      description: 'Cube root of a number',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Cube root of a number',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'abs',
      description: 'Calculate absolute value',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Calculate the absolute value of a number',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'sin',
      description: 'Calculate sine value',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Calculate the sine of an angle (input in radians)',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'cos',
      description: 'Calculate cosine value',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Calculate the cosine of an angle (input in radians)',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'tan',
      description: 'Calculate tangent value',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Calculate the tangent of an angle (input in radians)',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'log',
      description: 'Calculate logarithm',
      inputSchema: ToolInput(
        type: 'object',
        description:
            'Calculate the logarithm with specific base, defaults to natural logarithm',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'base', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'max',
      description: 'Find maximum value',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Return the maximum of two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'min',
      description: 'Find minimum value',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Return the minimum of two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'round',
      description: 'Round to nearest integer',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Round a number to the nearest integer',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'ceil',
      description: 'Round up to the nearest integer',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Round a number up to the nearest integer',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'floor',
      description: 'Round down to the nearest integer',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Round a number down to the nearest integer',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
      ),
    ));

    addTool(Tool(
      name: 'mod',
      description: 'Modulo operation',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Calculate the remainder of division of two numbers',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
          Property(name: 'b', type: ToolInputType.integer),
        ],
        required: ['a', 'b'],
      ),
    ));

    addTool(Tool(
      name: 'factorial',
      description: 'Calculate factorial',
      inputSchema: ToolInput(
        type: 'object',
        description: 'Calculate the factorial of a non-negative integer',
        properties: [
          Property(name: 'a', type: ToolInputType.integer),
        ],
        required: ['a'],
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
          .fine('memory_server onToolCall name: $name arguments: $arguments');

      // Execute operations based on tool name
      switch (name) {
        case 'add':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          return {'result': add(a, b)};
        case 'subtract':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          return {'result': subtract(a, b)};
        case 'multiply':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          return {'result': multiply(a, b)};
        case 'divide':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          if (b == 0) {
            return {'error': 'Division by zero is not allowed'};
          }
          return {'result': divide(a, b)};
        case 'power':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          try {
            return {'result': power(a, b)};
          } catch (e) {
            return {'error': 'Power operation error: $e'};
          }
        case 'sqrt':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          if (a < 0) {
            return {'error': 'Cannot compute square root of negative number'};
          }
          return {'result': sqrt(a)};
        case 'cbrt':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          return {'result': cbrt(a)};
        case 'abs':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          return {'result': abs(a)};
        case 'sin':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          return {'result': sin(a)};
        case 'cos':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          return {'result': cos(a)};
        case 'tan':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          // Check for singularities in the tan function
          if ((a % (math.pi / 2)).abs() < 1e-10 &&
              (a % math.pi).abs() > 1e-10) {
            return {'error': 'Tangent is undefined at π/2 + nπ'};
          }
          return {'result': tan(a)};
        case 'log':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          if (a <= 0) {
            return {'error': 'Logarithm requires a positive number'};
          }

          if (arguments.containsKey('base')) {
            var base = castToNumber(arguments['base']);
            if (base == null) {
              return {'error': 'Base parameter must be a valid number'};
            }
            if (base <= 0 || base == 1) {
              return {
                'error': 'Logarithm base must be positive and not equal to 1'
              };
            }
            return {'result': logWithBase(a, base)};
          } else {
            return {'result': log(a)};
          }
        case 'max':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          return {'result': max(a, b)};
        case 'min':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          return {'result': min(a, b)};
        case 'round':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          return {'result': round(a)};
        case 'ceil':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          return {'result': ceil(a)};
        case 'floor':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          return {'result': floor(a)};
        case 'mod':
          if (!_validateRequiredArgs(arguments, ['a', 'b'])) {
            return {'error': 'Missing required parameters: a, b'};
          }
          var a = castToNumber(arguments['a']);
          var b = castToNumber(arguments['b']);
          if (a == null || b == null) {
            return {'error': 'Parameters must be valid numbers'};
          }
          if (b == 0) {
            return {'error': 'Modulo by zero is not allowed'};
          }
          return {'result': mod(a, b)};
        case 'factorial':
          if (!_validateRequiredArgs(arguments, ['a'])) {
            return {'error': 'Missing required parameter: a'};
          }
          var a = castToNumber(arguments['a']);
          if (a == null) {
            return {'error': 'Parameter must be a valid number'};
          }
          if (a < 0) {
            return {'error': 'Factorial cannot be applied to negative numbers'};
          }
          if (a > 20) {
            return {
              'error':
                  'Factorial too large, please use a number less than or equal to 20'
            };
          }
          try {
            return {'result': factorial(a)};
          } catch (e) {
            return {'error': 'Factorial calculation error: $e'};
          }
        default:
          return {'error': 'Unknown tool: $name'};
      }
    } catch (e, stackTrace) {
      Logger.root.severe('MathServer error: $e\n$stackTrace');
      return {'error': 'Error occurred during calculation: $e'};
    }
  }

  // 验证必要参数是否存在
  bool _validateRequiredArgs(
      Map<String, dynamic> args, List<String> requiredArgs) {
    for (var arg in requiredArgs) {
      if (!args.containsKey(arg) || args[arg] == null) {
        return false;
      }
    }
    return true;
  }

  int add(num a, num b) {
    return a.toInt() + b.toInt();
  }

  int subtract(num a, num b) {
    return a.toInt() - b.toInt();
  }

  int multiply(num a, num b) {
    return a.toInt() * b.toInt();
  }

  double divide(num a, num b) {
    if (b == 0) {
      throw ArgumentError('Division by zero is not allowed');
    }
    return a / b;
  }

  int power(num a, num b) {
    if (b < 0) {
      throw ArgumentError(
          'Negative exponents are not supported in this implementation');
    }
    return math.pow(a, b).toInt();
  }

  double sqrt(num a) {
    if (a < 0) {
      throw ArgumentError('Cannot compute square root of negative number');
    }
    return math.sqrt(a);
  }

  double cbrt(num a) {
    return math.pow(a.abs(), 1 / 3).toDouble() * (a < 0 ? -1 : 1);
  }

  int abs(num a) {
    return a.abs().toInt();
  }

  double sin(num a) {
    return math.sin(a);
  }

  double cos(num a) {
    return math.cos(a);
  }

  double tan(num a) {
    // Check for singularities in the tan function
    if ((a % (math.pi / 2)).abs() < 1e-10 && (a % math.pi).abs() > 1e-10) {
      throw ArgumentError('Tangent is undefined at π/2 + nπ');
    }
    return math.tan(a);
  }

  double log(num a) {
    if (a <= 0) {
      throw ArgumentError('Logarithm requires a positive number');
    }
    return math.log(a);
  }

  double logWithBase(num a, num base) {
    if (a <= 0) {
      throw ArgumentError('Logarithm requires a positive number');
    }
    if (base <= 0 || base == 1) {
      throw ArgumentError('Logarithm base must be positive and not equal to 1');
    }
    return math.log(a) / math.log(base);
  }

  num max(num a, num b) {
    return math.max(a, b);
  }

  num min(num a, num b) {
    return math.min(a, b);
  }

  int round(num a) {
    return a.round();
  }

  int ceil(num a) {
    return a.ceil();
  }

  int floor(num a) {
    return a.floor();
  }

  int mod(num a, num b) {
    if (b == 0) {
      throw ArgumentError('Modulo by zero is not allowed');
    }
    return a.toInt() % b.toInt();
  }

  int factorial(num a) {
    if (a < 0) {
      throw ArgumentError('Factorial cannot be applied to negative numbers');
    }
    if (a > 20) {
      throw ArgumentError(
          'Factorial too large, please use a number less than or equal to 20');
    }
    if (a <= 1) {
      return 1;
    }
    return a.toInt() * factorial(a - 1);
  }
}

int? castToNumber(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is double) {
    return value.toInt();
  }

  if (value is String) {
    if (value.trim().isEmpty) {
      return null;
    }

    try {
      var parsed = num.tryParse(value);
      if (parsed == null) {
        return null;
      }
      return parsed.toInt();
    } catch (_) {
      return null;
    }
  }

  return null;
}
