import System.Environment
import System.Directory
import System.IO
import Data.List
import Control.Exception

import qualified Data.ByteString.Lazy as BL
import Data.Binary.Get
import Data.Word
import Data.Array

import Audio.File

--main :: IO()
--main = do 
--    input <- BL.getContents
--    print $ runGet deserializeWaveHeader input

main :: IO ()
main = do
    (command:argList) <- getArgs
    dispatch command argList

dispatch :: String -> [String] -> IO ()
dispatch "read" = readAudio

readAudio :: [String] -> IO ()
readAudio [filename] = putStrLn $ parseFormat $ readFormat filename 
readAudio _          = putStrLn "Could not parse aguments"

parseFormat :: Maybe AudioFormat -> String
parseFormat a = case a of
                    Just a  -> show a
                    Nothing -> "Could not find a parser for this file format" 

deserializeWaveHeader :: Get (Word32)
deserializeWaveHeader = do
    length <- getWord32be
    return (length)

-- TODO: These should exist in a seperate module (WAVE)

data WaveFile = WaveFile {
    header    :: WaveHeader,
    dataArray :: Array Int Word8
}

data WaveHeader = WaveHeader {
    riffHeader     :: RIFFHeader,
    formatSubchunk :: FmtSubChunk,
    dataHeader     :: DataHeader

} deriving (Show, Eq)

data RIFFHeader = RIFFHeader {
    chunkId     :: Word32, -- field size (in bytes): 4, endian: big
    chunkSize   :: Word32, -- field size: 4, endian: little
    format      :: Word32  -- field size: 4, endian, big
} deriving (Show, Eq)

data FmtSubChunk = FmtSubChunk {
    fmtChunkId    :: Word32, -- field size: 4, endian: big
    fmtChunkSize  :: Word32, -- field size: 4, endian: little
    audioFormat   :: Word16, -- field size: 2, endian: little
    numChannels   :: Word16, -- field size: 2, endian: little
    sampleRate    :: Word32, -- field size: 4, endian: little
    byteRate      :: Word32, -- field size: 4, endian: little
    blockAlign    :: Word16, -- field size 2, endian little
    bitsPerSample :: Word16  -- field size 2, endian little
} deriving (Show, Eq)

data DataHeader = DataHeader {
    dataChunkId   :: Word32, -- field size: 4, endian: big
    dataChunkSize :: Word32  -- field size: 4, endian little
} deriving (Show, Eq)
    

