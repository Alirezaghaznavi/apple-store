import 'package:apple_store/data/model/variant-type.dart';
import 'package:apple_store/data/model/varint.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variantList;
  ProductVariant(this.variantType, this.variantList);
}
