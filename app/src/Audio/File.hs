
module Audio.File (readFormat,
                   AudioFile,
                   AudioFormat) where

import Audio.Data

import Data.String
import System.IO
import System.FilePath
import System.FilePath.Posix

readFormat :: FilePath -> Maybe AudioFormat
readFormat fp 
    | takeExtension fp == ".wav" = Just WAVE
    | otherwise                  = Nothing 

parseAudio :: Handle -> AudioFormat -> AudioProperties
parseAudio handle format = case WAVE => -- TODO: Finish

class AudioFile a where
    parseAudio  :: Handle -> AudioFormat -> AudioProperties

data AudioFormat = WAVE deriving (Show, Enum)

