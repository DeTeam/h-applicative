-- Functors and Applicatives

-- Hey there!
-- This is a codesheet with few lines, I hope you'll get today.

-- We'll use functors and applicatives!
module Main where

-- Here we put our Person model for later usage
import Models.Person

-- We'll use those two functions later!
import Control.Applicative ((<$>), (<*>))


main = do
  -- Here we go! Let's start with functors.
  -- http://hackage.haskell.org/package/base-4.6.0.1/docs/Data-Functor.html

  -- Docs says, Functor - is a data structure you can map over.
  -- Awesome. Almost every container is a functor.
  -- And there's `fmap` to use (map is for lists, fmap is for functors).

  -- List - is a Functor too, look:
  print $ fmap (+1) [1..10]

  -- What else?
  -- Type 'Hello' here ;)
  line <- fmap (++ " World") getLine
  putStrLn line

  -- IO Actions are Functors.
  -- Here we created new action, which get a line and append " World " at the end.

  -- Maybe is another Functor.

  -- Here we use fmap for instance create with Just constructor.
  -- We'll get 6.
  let just5 = Just 5 in print $ fmap (+1) just5

  -- And now let's apply (+1) to Nothing ;)
  -- +1 to Nothing - you get Nothing.
  print $ fmap (+1) Nothing

  -- I'm not sure why, but we can do things like that:
  let superPlusOne :: Functor f => f Int -> f Int
      superPlusOne = fmap (+1)

  -- Dude! We can use same function for absolutely different types!
  -- Awesome!
  -- It's so DRY :D
  print $ superPlusOne [1..10]
  print $ superPlusOne Nothing
  print $ superPlusOne (Just 5)

  -- However, it's not cool to wrap pure functions in fmap everytime.
  -- We can use DSLish function (infix alias for fmap):
  print $ (+1) <$> Nothing
  print $ (+1) <$> [1..10]

  -- fmap and its alias <$> limit us.
  -- We can't do some cool stuff.
  -- Let's meet Applicative
  print $ (+) <$> Just 5 <*> Just 10

  -- You already know <$>
  -- What's <*> ?
  -- http://hackage.haskell.org/package/base-4.6.0.1/docs/Control-Applicative.html
  -- When we apply (+) to content of Just 5 we get a function inside of Just
  -- To get a value we need one more argument.
  --    (+) <$> Just 5 <*> Just 10
  --    Just (+) <*> Just 4 <*> Just 10
  --    Just (4+) <*> Just 10
  --    Just (4+10)
  --    Just 14
  --
  -- Why is this awesome?

  --  Because you can do thing like that whithout checking for NULL ;)
  print $ (+) <$> Just 5 <*> Nothing

  -- Or concat two lines together
  l <- (++) <$> getLine <*> getLine
  print l

  -- Or create data structure instances from user input:
  person <- Person <$> getLine <*> getLine
  print person

  -- Actually applicative style is very popular for building parsers (may check some attoparsec tutors). 

  -- Here are few more examples:

  let myMap = [
          ("firstName", "Haskell"),
          ("lastName", "Curry")
        ]
      getField = flip lookup $ myMap

  -- getField may find something or may not, so we're working with Maybe type
  -- As we seen before Maybe has two constructors: Just and Nothin
  print $ Person <$> (getField "firstName") <*> (getField "lastName")


  let somePerson = Person <$> (getField "uknownField") <*> (getField "lastName")
      fullName (Person f l) = f ++ " " ++ l

  print $ fullName <$> somePerson

  
