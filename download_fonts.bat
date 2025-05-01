@echo off
echo Downloading Poppins fonts...

curl -o "assets/fonts/Poppins-Regular.ttf" "https://fonts.gstatic.com/s/poppins/v20/pxiEyp8kv8JHgFVrJJfecg.woff2"
curl -o "assets/fonts/Poppins-Medium.ttf" "https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLGT9Z1xlEA.woff2"
curl -o "assets/fonts/Poppins-SemiBold.ttf" "https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLEj6Z1xlEA.woff2"
curl -o "assets/fonts/Poppins-Bold.ttf" "https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLCz7Z1xlEA.woff2"

echo Fonts downloaded successfully! 