import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:skool_ui/core/network/dio_client.dart';

/// Provides a single shared Dio instance throughout the app.
final dioProvider = Provider<Dio>((ref) => DioClient.create());
