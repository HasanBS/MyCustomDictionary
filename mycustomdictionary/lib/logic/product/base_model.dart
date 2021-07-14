abstract class IBaseModel<T> {
  Map<String, dynamic> toMap();
  T fromJson(Map<String, dynamic> json);
}
