import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/data/model/product-image.dart';
import 'package:apple_store/data/model/product-property.dart';
import 'package:apple_store/data/model/product-variant.dart';
import 'package:apple_store/data/model/variant-type.dart';
import 'package:apple_store/data/model/varint.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImage>> getGallery(String productId);

  Future<List<VariantType>> getVariantTypes();

  Future<List<Variant>> getVariants(String productId);

  Future<List<ProductVariant>> getProductVariants(String productId);

  Future<Category> getCategory(String categoryId);

  Future<List<ProductProperty>> getProperties(String productId);
}

class ProductDetailRemote extends IProductDetailDatasource {
  final Dio _dio = locatore.get();

  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    final Map<String, String> qParams = {'filter': "productId='$productId'"};

    try {
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);

      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variant_types/records');

      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJosn(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<List<Variant>> getVariants(String productId) async {
    final Map<String, String> qParams = {
      'expand': 'variantId',
      'filter': 'id="$productId"'
    };
    try {
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      var data = response.data['items'][0]['expand']['variantId'];

      List<Variant> variantList = [];
      for (var element in data) {
        Variant variant = Variant.fromJson(element);
        variantList.add(variant);
      }

      return variantList;
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }

    // return response.data['items'][0]
    //     .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
    //     .cast<String, dynamic>()
    //     .toList();
  }

  @override
  Future<List<ProductVariant>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants(productId);

    List<ProductVariant> productVariantList = [];

    for (var variantType in variantTypeList) {
      var mainVariantList = variantList
          .where((element) => element.typeId == variantType.id)
          .toList();

      productVariantList.add(ProductVariant(variantType, mainVariantList));
    }
    return productVariantList;
  }

  @override
  Future<Category> getCategory(String categoryId) async {
    final Map<String, String> qParams = {"filter": 'id="$categoryId"'};
    try {
      var response = await _dio.get('collections/categories/records/',
          queryParameters: qParams);
      return Category.fromMapJson(response.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<List<ProductProperty>> getProperties(String productId) async {
    final Map<String, String> qParams = {"filter": 'productId="$productId"'};

    try {
      var response = await _dio.get(
        'collections/properties/records',
        queryParameters: qParams,
      );

      return response.data['items']
          .map<ProductProperty>(
              (jsonObject) => ProductProperty.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
