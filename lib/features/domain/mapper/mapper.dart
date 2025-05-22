abstract class Mapper<From, To> {
  To mapFrom(From dto);
}

abstract class Transfer<To> {
  To transfer();
}
