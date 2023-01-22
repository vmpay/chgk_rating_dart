import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/token_request.dart';
import 'package:chgk_rating/src/models/token_response.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'player_unit_test.mocks.dart';

void main() {
  final MockDio mockDio = MockDio();
  final ChgkRating chgkRating = ChgkRating.init(mockDio);

  final TokenRequest mockTokenRequest =
      TokenRequest(email: 'email', password: 'password');
  final TokenResponse mockTokenResponse = TokenResponse(token: 'token');

  group('postToken', () {
    test('empty', () async {
      when(mockDio.post('/authentication_token',
              data: mockTokenRequest.toRawJson()))
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: ''),
              response: Response<dynamic>(
                data:
                    '{"type":"https:\/\/tools.ietf.org\/html\/rfc2616#section-10","title":"An error occurred","detail":"Not Found"}',
                statusCode: 401,
                requestOptions: RequestOptions(path: ''),
              )));
      final TokenResponse? tokenResponse =
          await chgkRating.postToken('email', 'password');
      expect(tokenResponse, null);
    });

    test('fail response', () async {
      when(mockDio.post('/authentication_token',
              data: mockTokenRequest.toRawJson()))
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: ''),
              response: Response<dynamic>(
                data:
                    '{"type":"https:\/\/tools.ietf.org\/html\/rfc2616#section-10","title":"An error occurred","detail":"Bad Request"}',
                statusCode: 400,
                requestOptions: RequestOptions(path: ''),
              )));
      expect(() => chgkRating.postToken('email', 'password'),
          throwsA(predicate((e) => e is DioError)));
    });

    test('success', () async {
      when(mockDio.post('/authentication_token',
              data: mockTokenRequest.toRawJson()))
          .thenAnswer((_) async => Response<String>(
              data: mockTokenResponse.toRawJson(),
              requestOptions: RequestOptions(path: '')));
      final TokenResponse? tokenResponse =
          await chgkRating.postToken('email', 'password');
      expect(tokenResponse, mockTokenResponse);
    });
  });
}
