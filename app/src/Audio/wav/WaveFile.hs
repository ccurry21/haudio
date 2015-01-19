
module WaveFile where

import Data.Word

data DataHeader = DataHeader {
        subchunkId   :: Word32, -- field size: 4, endian: big
        subchunkSize :: Word32  -- field size: 4, endian little
} deriving (Show, Eq)

data FmtSubChunk = FmtSubChunk {
        subchunkId    :: Word32, -- field size: 4, endian: big
        subchunkSize  :: Word32, -- field size: 4, endian: little
        audioFormat   :: Word16, -- field size: 2, endian: little
        numChannels   :: Word16, -- field size: 2, endian: little
        sampleRate    :: Word32, -- field size: 4, endian: little
        byteRate      :: Word32, -- field size: 4, endian: little
        blockAlign    :: Word16, -- field size 2, endian little
        bitsPerSample :: Word16  -- field size 2, endian little
} deriving (Show, Eq)

data RIFFHeader = RIFFHeader {
        chunkId     :: Word32, -- field size (in bytes): 4, endian: big
        chunkSize   :: Word32, -- field size: 4, endian: little
        format      :: Word32  -- field size: 4, endian, big
} deriving (Show, Eq)

data WaveHeader = WaveHeader {
        riffHeader     :: RIFFHeader,
        formatSubchunk :: FmtSubChunk,
        dataHeader     :: DataHeader
} deriving (Show, Eq)
