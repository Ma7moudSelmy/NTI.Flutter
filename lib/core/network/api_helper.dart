import 'package:dio/dio.dart';
import 'package:nti_15_task/core/helper/get_helper.dart';
import 'package:nti_15_task/core/helper/my_logger.dart';
import 'package:nti_15_task/features/auth/views/login_page.dart';

import '../cache/cache_data.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_keys.dart';
import 'api_response.dart';
import 'end_points.dart';

class ApiHelper {
  // Singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() {
    // initialize the dio instance and the interceptors
    _instance.initDio();
    return _instance;
  }

  ApiHelper._init();

  // Dio instance with its options configured
  Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  void initDio() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Just Print the details of the call for observation purposes
          // MyLogger.yellow("--- Headers : ${options.headers.toString()}");
          MyLogger.yellow("Request --- endpoint : ${options.path.toString()}");
          // then continue the call
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Print the response in case of success
          MyLogger.green("--- Response : ${response.data.toString()}");
          // Continue the process
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          // Print the error Body in case of failure
          MyLogger.red("--- Error : ${error.response?.data.toString()}");

          // Check if the error is due to an expired token
          if (error.response?.data['message'].contains('expired')) {
            // refresh token
            try {
              ApiResponse apiResponse = await _instance.postRequest(
                endPoint: EndPoints.refreshToken,
                sendRefreshToken: true,
                isProtected: true,
              );
              // Check if the refresh token request was successful
              if (apiResponse.status) {
                // must update token & Cache it
                CacheData.accessToken = apiResponse.data['access_token'];
                await CacheHelper.saveData(
                  key: CacheKeys.accessToken,
                  value: CacheData.accessToken,
                );

                // Retry original request
                final options = error.requestOptions;
                if (options.data is FormData) {
                  final oldFormData = options.data as FormData;
                  // If the data is FormData, we need to rebuild it
                  // because Dio will not allow to send the old formdata again

                  // Convert FormData to map so it can be rebuilt
                  final Map<String, dynamic> formMap = {};
                  for (var entry in oldFormData.fields) {
                    formMap[entry.key] = entry.value;
                  }

                  // Add files if any
                  for (var file in oldFormData.files) {
                    formMap[file.key] = file.value;
                  }

                  // Rebuild new FormData
                  options.data = FormData.fromMap(formMap);
                }
                // Add the new token to the headers
                options.headers['Authorization'] =
                    'Bearer ${CacheData.accessToken}';
                final response = await dio.fetch(options);
                // because we handled the error and solved it
                return handler.resolve(response);
              } else {
                // In case Refresh token itself has expired or failed
                // must logout
                CacheHelper.removeData(key: CacheKeys.accessToken);
                CacheHelper.removeData(key: CacheKeys.refreshToken);
                GetHelper.pushReplaceAll(() => LoginPage());
                return handler.next(error);
              }
            } catch (e) {
              // In case of any error during the refresh token process
              // must logout
              CacheHelper.removeData(key: CacheKeys.accessToken);
              CacheHelper.removeData(key: CacheKeys.refreshToken);
              GetHelper.pushReplaceAll(() => LoginPage());
              return handler.next(error);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  // Post Request
  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
    bool sendRefreshToken = false,
  }) async {
    return ApiResponse.fromResponse(
      await dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isProtected)
              'Authorization':
                  'Bearer ${sendRefreshToken ? CacheHelper.getData(key: CacheKeys.refreshToken) : CacheData.accessToken}',
          },
        ),
      ),
    );
  }

  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    MyLogger.bgYellow("getRequest called");
    return await dio.get(
      endPoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
        },
      ),
    );
  }

  Future<Response> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    return await dio.put(
      endPoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
        },
      ),
    );
  }

  Future<Response> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    return await dio.delete(
      endPoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
        },
      ),
    );
  }
}
