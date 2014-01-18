-- Here's another module!
-- We export Person data type and all constructor fucntions.
module Models.Person (
  Person(..)
) where

-- Two fields - first name, last name
-- We derive instances for Show type class, for pretty printing
data Person = Person String String deriving (Show)