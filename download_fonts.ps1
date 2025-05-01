$fonts = @(
    @{name="Poppins-Regular.ttf"; url="https://fonts.gstatic.com/s/poppins/v20/pxiEyp8kv8JHgFVrJJfecg.woff2"},
    @{name="Poppins-Medium.ttf"; url="https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLGT9Z1xlEA.woff2"},
    @{name="Poppins-SemiBold.ttf"; url="https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLEj6Z1xlEA.woff2"},
    @{name="Poppins-Bold.ttf"; url="https://fonts.gstatic.com/s/poppins/v20/pxiByp8kv8JHgFVrLCz7Z1xlEA.woff2"}
)

foreach ($font in $fonts) {
    $output = "assets/fonts/$($font.name)"
    Write-Host "Downloading $($font.name)..."
    Invoke-WebRequest -Uri $font.url -OutFile $output
    Write-Host "Downloaded $($font.name)"
} 