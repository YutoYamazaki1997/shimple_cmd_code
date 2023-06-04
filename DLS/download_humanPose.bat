

setlocal

set MODELS_PATH="human-pose-estimation-0001"

if NOT DEFINED MODELS_PATH (
    echo ERROR: MODELS_PATH not set
    EXIT /B 1
)

echo Downloading models to folder %MODELS_PATH%

pip show -qq openvino-dev
if ERRORLEVEL 1 (
  echo "Script requires Open Model Zoo python modules, please install via 'pip install openvino-dev[onnx]'";
  EXIT /B 1
)

mkdir "%MODELS_PATH%"
omz_downloader --name "%MODELS_PATH%" -o "%MODELS_PATH%"
omz_converter --name "%MODELS_PATH%" -o "%MODELS_PATH%" -d "%MODELS_PATH%"