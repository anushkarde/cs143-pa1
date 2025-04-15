-- Test for identifiers
class IdentifierTest {
  -- Valid object identifiers
  normal_id : Int;
  _underscore_id : Int;
  id_with_numbers123 : Int;
  a : Int; -- Single character
  averyverylongidentifierthatisvalidbutprobablynotgoodpractice : Int;
  
  -- Valid type identifiers
  objectOfType : MyType;
  objectOfPredefinedType : String;
  objectOfSimpleType : T;
  objectOfLongTypeNameThatIsValidButProbablyNotGoodPractice : VeryLongTypeName;
  
  -- Edge cases and error cases
  id_with_special_char$ : Int; -- Should flag an error
  123invalid_starting_with_number : Int; -- Should flag an error
  spécial_chârs : Int; -- Non-ASCII characters
  
  main(): Object {
    let self_type : SELF_TYPE,
        t : T,
        io : IO,
        obj : Object,
        str : String,
        int : Int,
        bool : Bool
    in {
      self;
    }
  };
};