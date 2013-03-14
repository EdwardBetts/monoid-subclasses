{- 
    Copyright 2011-2013 Mario Blazevic

    License: BSD3 (see BSD3-LICENSE.txt file)
-}

-- | This module defines the MonoidNull class and some of its instances.
-- 

{-# LANGUAGE Haskell2010 #-}

module Data.Monoid.Null (
   MonoidNull(..)
   )
where

import Prelude hiding (null)
   
import Data.Monoid (Monoid(mempty), First(..), Last(..), Dual(..), Sum(..), Product(..), All(getAll), Any(getAny))
import qualified Data.List as List
import Data.Ord (Ordering(EQ))
import qualified Data.ByteString as ByteString
import qualified Data.ByteString.Lazy as LazyByteString
import qualified Data.Text as Text
import qualified Data.Text.Lazy as LazyText
import qualified Data.IntMap as IntMap
import qualified Data.IntSet as IntSet
import qualified Data.Map as Map
import qualified Data.Sequence as Sequence
import qualified Data.Set as Set
import qualified Data.Vector as Vector

-- | Extension of 'Monoid' that allows testing a value for equality with 'mempty'. The following law must hold:
-- 
-- prop> null x == (x == mempty)
class Monoid m => MonoidNull m where
   null :: m -> Bool

instance MonoidNull () where
   null () = True

instance MonoidNull Ordering where
   null = (== EQ)

instance MonoidNull All where
   null = getAll

instance MonoidNull Any where
   null = not . getAny

instance MonoidNull (First a) where
   null (First Nothing) = True
   null _ = False

instance MonoidNull (Last a) where
   null (Last Nothing) = True
   null _ = False

instance MonoidNull a => MonoidNull (Dual a) where
   null (Dual a) = null a

instance (Num a, Eq a) => MonoidNull (Sum a) where
   null (Sum a) = a == 0

instance (Num a, Eq a) => MonoidNull (Product a) where
   null (Product a) = a == 1

instance Monoid a => MonoidNull (Maybe a) where
   null Nothing = True
   null _ = False

instance (MonoidNull a, MonoidNull b) => MonoidNull (a, b) where
   null (a, b) = null a && null b

instance MonoidNull [x] where
   null = List.null

instance MonoidNull ByteString.ByteString where
   null = ByteString.null

instance MonoidNull LazyByteString.ByteString where
   null = LazyByteString.null

instance MonoidNull Text.Text where
   null = Text.null

instance MonoidNull LazyText.Text where
   null = LazyText.null

instance Ord k => MonoidNull (Map.Map k v) where
   null = Map.null

instance MonoidNull (IntMap.IntMap v) where
   null = IntMap.null

instance MonoidNull IntSet.IntSet where
   null = IntSet.null

instance MonoidNull (Sequence.Seq a) where
   null = Sequence.null

instance Ord a => MonoidNull (Set.Set a) where
   null = Set.null

instance MonoidNull (Vector.Vector a) where
   null = Vector.null