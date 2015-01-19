module Paths_haudio (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/chris/code/haskell/haudio/.cabal-sandbox/bin"
libdir     = "/Users/chris/code/haskell/haudio/.cabal-sandbox/lib/x86_64-osx-ghc-7.8.3/haudio-0.1.0.0"
datadir    = "/Users/chris/code/haskell/haudio/.cabal-sandbox/share/x86_64-osx-ghc-7.8.3/haudio-0.1.0.0"
libexecdir = "/Users/chris/code/haskell/haudio/.cabal-sandbox/libexec"
sysconfdir = "/Users/chris/code/haskell/haudio/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "haudio_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "haudio_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "haudio_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haudio_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haudio_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
