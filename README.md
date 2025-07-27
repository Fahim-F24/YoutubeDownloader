

# 🎬 YouTube Downloader (Batch Script)

A powerful and portable batch script to download YouTube videos using [`yt-dlp`](https://github.com/yt-dlp/yt-dlp),  
convert audio from **Opus** to **AAC**, and organize everything cleanly — perfect for playback in Windows apps like "Film & TV".

---

## 📁 Folder Structure

YoutubeDownloader  
├── Downloads  
│   ├── video\              ← Temporary processing folder  
│   └── *.mp4               ← Final downloaded videos  
├── yt-dlp.exe              ← Video downloader  
├── ffmpeg.exe              ← ffmpeg converter exe  
├── yt-dlp.conf             ← yt-dlp config file  
├── download.bat            ← Batch script  

> 💡 `ffmpeg` and `ffprobe` are **not stored here** but must be available in your system `PATH`.

---

## 📦 First-Time Setup Summary

1. Download the following into a folder (e.g., `YoutubeDownloader`):  
   - `download.bat`  
   - `yt-dlp.exe`  
   - `yt-dlp.conf`  
2. [Install and configure FFmpeg](#🔧-add-ffmpeg-to-system-path-windows)  
3. Run the batch script  
4. Paste in a YouTube link  
5. Videos will download, process, and appear in the `Downloads` folder  

---

## 🧰 System Requirements

The script depends on these tools being accessible globally via the command line:

### ✅ Required Tools

- [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) — Download tool (included in folder)  
- [`ffmpeg`](https://ffmpeg.org/) — Audio/video converter (must be in `PATH`)  
- `ffprobe` — Comes bundled with FFmpeg, used to detect audio codec  

---

## 🔧 Add FFmpeg to System PATH (Windows)

1. [Download FFmpeg](https://ffmpeg.org/download.html) (Windows ZIP version)  
2. Extract to a folder like: `C:\ffmpeg\bin`  
3. Press `Win + R`, type `SystemPropertiesAdvanced`, press **Enter**  
4. Click **Environment Variables**  
5. Under "System variables", find `Path`, click **Edit**  
6. Click **New**, paste the path to your FFmpeg `bin` folder:  

```

C:\ffmpeg\bin

````

7. Click OK to close all dialogs  
8. Restart your terminal or system to apply changes  

> ✅ Once done, both `ffmpeg` and `ffprobe` will work from anywhere.

---

## 🔍 Verifying Installation

To check if FFmpeg is correctly installed and available from the command line:

1. Open **Command Prompt**  
2. Type:  

```cmd
ffmpeg -version
````

3. If installed properly, you'll see output like:

   ```
   ffmpeg version 6.x Copyright ...
   configuration: ...
   ```

If you get an error like:

```
'ffmpeg' is not recognized as an internal or external command
```

Then FFmpeg is not added to your `PATH`. Follow the setup instructions above.

---

## 🛠 How to Use

1. Download the following files into one folder:

   * `download.bat`
   * `yt-dlp.exe`
   * `yt-dlp.conf`
2. Ensure `ffmpeg` and `ffprobe` are available via `PATH`
3. Run `download.bat` (double-click it)
4. Paste a YouTube URL when prompted
5. Wait for processing — the final files appear in the `Downloads` folder

---

## ⚙️ Example `yt-dlp.conf`

This config file controls video quality, output format, and merging behavior.

📝 The file `yt-dlp.conf` is **already included** in the repo.

### ✍️ Contents of `yt-dlp.conf`:

```txt
# Download best video+audio up to 720p
-f "bv[height<=720]+ba/b[height<=720]/b"

# Output format and filename
-o "%(title)s.%(ext)s"

# Merge audio and video into MP4 container
--merge-output-format mp4
```

---

## 📦 Output Behavior

* All videos are downloaded to `Downloads\video\`
* Videos with **Opus audio** are converted to **AAC**
* Final `.mp4` files are moved to `Downloads\`
* Duplicate filenames are handled safely:

  ```
  MyVideo.mp4
  MyVideo_1.mp4
  MyVideo_2.mp4
  ```

---

## 🧪 Tool Validation

Before doing anything, the script checks for:

* `yt-dlp`
* `ffmpeg`
* `ffprobe`

If any are missing, it stops and shows an error message.

---

## 👀 Output Sample

```text
[INFO] Downloading videos from: https://youtube.com/...
[INFO] Download folder: YourFolder\Downloads\video
[ACTION] Converting audio to AAC for: ExampleVideo.mp4
[SUMMARY] Converted audio in 2 files, skipped 1 files.
Video Download Completed!
```

---

## 🔐 License

This script is for **personal use only**.
No license is attached. Use responsibly and legally.

```

