
```markdown
# YouTube Video Downloader (MP3 & MP4)

This Flutter-based application allows users to download YouTube videos in either MP3 (audio) or MP4 (video) format. With a simple and intuitive interface, you can quickly download and share your favorite YouTube content.

## Features

- **Download in MP3 or MP4**: Choose between audio (MP3) or video (MP4) format for downloads.
- **YouTube Playback**: Integrated YouTube player to preview videos before downloading.
- **Share Downloads**: Share downloaded files directly from the app using the Share button.
- **Permissions Handling**: Automatic permissions request for storage, camera, and internet access.
- **Customizable UI**: Uses beautiful fonts and icons to give the app a polished look.

## Packages Used

## important Note!!!\

## Add your youtube API key in the strings.dart file

```

The following packages are used in this project:

- **`cupertino_icons: ^1.0.8`**: iOS-style icons for the app's UI.
- **`google_fonts: ^6.2.1`**: Custom fonts to improve text styling.
- **`auto_size_text: ^3.0.0`**: Auto-resizes text to fit its container.
- **`share_plus: ^10.1.2`**: Allows sharing of downloaded files via the device’s sharing options.
- **`dio: ^5.7.0`**: For network requests, including downloading video/audio files.
- **`permission_handler: ^11.3.1`**: Handles permissions for storage and internet access.
- **`youtube_explode_dart: ^2.3.5`**: Extracts YouTube video information and download links.
- **`ffmpeg_kit_flutter: ^6.0.3`**: For converting and processing video/audio formats (e.g., MP3 and MP4).
- **`youtube_player_flutter: ^9.1.1`**: Embeds YouTube videos for in-app playback.
- **`rename_app: ^1.6.1`**: Utility to rename app configurations for different environments.

## Installation

Follow these steps to get your project up and running.

### 1. Clone the Repository

Clone the project repository from GitHub:

```bash
git clone https://github.com/yourusername/youtube_video_downloader.git
cd youtube_video_downloader
```

### 2. Install Dependencies

Run the following command to install the required Flutter packages:

```bash
flutter pub get
```

### 3. Set Up Permissions

To ensure your app works correctly, you’ll need to configure permissions for both Android and iOS.

#### Android

In your `AndroidManifest.xml`, make sure you request the necessary permissions for internet access and external storage:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

#### iOS

For iOS, you’ll need to add appropriate permission descriptions in the `Info.plist` file located in `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to save downloaded files.</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera for certain features.</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need access to your microphone for audio downloads.</string>
```

### 4. Run the App

Once the dependencies are installed and permissions are configured, you can run the app on a physical device or emulator:

```bash
flutter run
```

## Usage

### 1. Search and Enter YouTube URL

- Open the app and either paste a YouTube video URL or search directly within the app for the video you want to download.

### 2. Choose Format

- After fetching the video, select the download format (MP3 for audio or MP4 for video).

### 3. Download the Video

- Tap the "Download" button to begin the download process. The video will be saved to your device.

### 4. Share Downloaded Files

- Once the download is complete, you can share the video or audio file with others using the **Share** button.

### 5. Preview the Video

- Use the integrated **YouTube Player** to preview the video before downloading. This allows you to confirm that you are downloading the correct video.

## Contributing

We welcome contributions! If you'd like to help improve this project, please follow these steps:

1. Fork the repository.
2. Clone your fork to your local machine.
3. Create a new branch (`git checkout -b feature-name`).
4. Make your changes and commit them (`git commit -m 'Add new feature'`).
5. Push to your fork (`git push origin feature-name`).
6. Create a pull request to the `main` branch.

Please ensure that your changes are well-tested and adhere to the existing code style.

## License

This project is open-source and available under the [MIT License](LICENSE).

---

For any issues or questions, feel free to open an issue in the repository or reach out to the project maintainers.

```

### Key Sections of the `README.md`:

- **Project Overview**: Briefly describes the app's purpose and its core features.
- **Packages Used**: Lists and explains the Flutter packages that were incorporated in the project.
- **Installation Instructions**: Step-by-step guidance on how to set up the project locally.
- **Permissions Setup**: Instructions on setting up Android and iOS permissions required for the app to function correctly.
- **Usage**: Clear, concise instructions on how users can interact with the app to download YouTube videos in MP3 or MP4 format.
- **Contributing**: Guidelines for contributing to the project, including how to fork, branch, and submit pull requests.
- **License**: Specifies the licensing terms for the project.

This `README.md` file should provide users and developers with everything they need to understand, install, and contribute to the project. You can modify or extend any section as per your needs.