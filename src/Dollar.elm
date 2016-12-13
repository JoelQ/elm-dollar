module Dollar
    exposing
        ( Dollar
        , zero
        , toInt
        , fromInt
        , add
        , subtract
        , map
        , map2
        , map3
        , map4
        , map5
        , map6
        )

{-| This library provides a `Dollar` type that wraps an `Int`. This adds greater
type safety to your function than a simple type alias would by guaranteeing you
can't mistakenly pass a `Dollar` where you meant to use some other type of `Int`
or mistakenly trying to add a `Dollar` value with another `Int`.

The `Dollar` module provides a bunch of helper functions to make it easy to
perform operations on the wrapped value as well as some generic helpers to allow
you to write your own operations. For example:

    -- given this type

    type alias Person =
      { age : Int
      , savings : Int
      }

    -- this incorrect function will compile

    totalCoupleSavings : Person -> Person -> Int
    totalCoupleSavings person1 person2 =
      person1.savings + person2.age

    -- whereas using a Dollar instead of an Int will catch
    -- the error at compile time since you can't add an Int
    -- and a Dollar.

    type alias Person =
      { age : Int
      , savings : Dollar
      }

    -- the correct implementation of totalCoupleSavings now
    -- looks like:

    totalCoupleSavings : Person -> Person -> Dollar
    totalCoupleSavings person1 person2 =
      Dollar.add person1.savings person2.savings


# Definition
@docs Dollar

# Constructing and Destructing
@docs zero, toInt, fromInt

# Common math operations
@docs add, subtract

# Abstract helpers
@docs map, map2, map3, map4, map5, map6
-}


{-| Represents a dollar value. These are their own type and cannot be combined
with other integers without explicitly doing so by using a helper function,
adding to the type safety of your operations.
-}
type Dollar
    = Dollar Int


{-| Zero dollars

    Dollar.zero == Dollar.fromInt 0
-}
zero : Dollar
zero =
    Dollar 0


{-| Construct a `Dollar` value from an integer.

    Dollar.fromInt 0 == Dollar.zero
-}
fromInt : Int -> Dollar
fromInt =
    Dollar


{-| Unwrap a `Dollar` value to get at the integer inside. You probably don't
want to do this most of the time. Use one of the mapping functions.
instead.

    Dollar.zero |> Dollar.toInt == 0

-}
toInt : Dollar -> Int
toInt (Dollar a) =
    a


{-| Add two `Dollar` values together without needing to unwrap. This is a
specialized form of `map2` and is implemented as `map2 (+)`

    Dollar.add (Dollar.fromInt 3) (Dollar.fromInt 2) == Dollar.fromInt 5
-}
add : Dollar -> Dollar -> Dollar
add =
    map2 (+)


{-| Subtract a `Dollar` value from another without needing to unwrap. This is a
specialized form of `map2` and is implemented as `map2 (-)`

    Dollar.subtract (Dollar.fromInt 5) (Dollar.fromInt 2) == Dollar.fromInt 3
-}
subtract : Dollar -> Dollar -> Dollar
subtract =
    map2 (-)


{-| Apply a function to the value wrapped by a `Dollar` without having to
unwrap and re-wrap.

    Dollar.map ((*) 2) (Dollar.fromInt 3) == Dollar.fromInt 6

-}
map : (Int -> Int) -> Dollar -> Dollar
map f (Dollar a) =
    Dollar (f a)


{-| Apply a function to the values wrapped by two `Dollar`s without having to
unwrap and re-wrap.

    Dollar.map2 (+) (Dollar.fromInt 3) (Dollar.fromInt 2) == Dollar.fromInt 5

-}
map2 : (Int -> Int -> Int) -> Dollar -> Dollar -> Dollar
map2 f (Dollar a) (Dollar b) =
    Dollar (f a b)


{-| Apply a function to the values wrapped by three `Dollar`s without having to
unwrap and re-wrap.
-}
map3 : (Int -> Int -> Int -> Int) -> Dollar -> Dollar -> Dollar -> Dollar
map3 f (Dollar a) (Dollar b) (Dollar c) =
    Dollar (f a b c)


{-| Apply a function to the values wrapped by four `Dollar`s without having to
unwrap and re-wrap.
-}
map4 :
    (Int -> Int -> Int -> Int -> Int)
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
map4 f (Dollar a) (Dollar b) (Dollar c) (Dollar d) =
    Dollar (f a b c d)


{-| Apply a function to the values wrapped by five `Dollar`s without having to
unwrap and re-wrap.
-}
map5 :
    (Int -> Int -> Int -> Int -> Int -> Int)
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
map5 f (Dollar a) (Dollar b) (Dollar c) (Dollar d) (Dollar e) =
    Dollar (f a b c d e)


{-| Apply a function to the values wrapped by five `Dollar`s without having to
unwrap and re-wrap.
-}
map6 :
    (Int -> Int -> Int -> Int -> Int -> Int -> Int)
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
    -> Dollar
map6 f (Dollar a) (Dollar b) (Dollar c) (Dollar d) (Dollar e) (Dollar g) =
    Dollar (f a b c d e g)
