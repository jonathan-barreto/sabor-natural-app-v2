import 'package:flutter_test/flutter_test.dart';
import 'package:natural_app/src/features/home/data/models/product_response_model.dart';

const nextPageUrl = "nextPageUrl.com";

final productMock = ProductResponse(
  nextPageUrl: nextPageUrl,
  products: [],
);

const json = {
  "next_page_url": nextPageUrl,
  "data": [],
};

const listProductsMock = <ProductResponse>[];

void main() {
  test('test product response model', () {
    //arrange -> organizar || preparar
    const response = json;

    //act -> agir
    final result = ProductResponse.fromJson(response);

    //assert -> afirmar || declarar
    expect(result.nextPageUrl, productMock.nextPageUrl);

    expect(result.products.length, productMock.products.length);
  });
}
