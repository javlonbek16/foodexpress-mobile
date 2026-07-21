abstract class AppCoordinate {
  final String _name;
  final String _path;

  AppCoordinate._(this._name, this._path);

  @override
  String toString() => "name=$_name, path=$_path";
}
