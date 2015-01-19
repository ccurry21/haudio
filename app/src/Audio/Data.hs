
module Audio.Data (AudioProperties, SampleType, ChannelFormat) where

data SampleType = UNKNOWN | BIT8 | BIT16 |
                  BIT24 | BIT32 | IEEE_FLOAT  
                  deriving (Show, Eq, Enum)

data ChannelFormat = STDWAVE | MC_MONO | MC_STEREO |
                     MC_QUAD | MC_LCRS | MC_DOLBY_5_1 | MC_WAVE_EX 
                     deriving (Show, Eq, Enum)
                    
data AudioProperties = AudioProperties {
    sampleRate       :: Int,
    numberOfChannels :: Int,
    sampleType       :: SampleType,
    channelFormat    :: ChannelFormat
} deriving (Show, Eq)
