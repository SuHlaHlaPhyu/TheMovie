import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constance.dart';
part 'production_countries_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_PRODUCTION_COUNTRY_VO,
    adapterName: "ProductionCountriesVOAdapter")
class ProductionCountriesVO {
  @JsonKey(name: "iso_3166_1")
  @HiveField(0)
  String? iso31661;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  ProductionCountriesVO(this.iso31661, this.name);

  factory ProductionCountriesVO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesVOToJson(this);
}
