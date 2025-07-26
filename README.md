```
#### 🎬 YouTube Downloader (Batch Script)

A powerful and clean batch script to download videos using `yt-dlp`, convert incompatible audio formats (e.g., Opus ➜ AAC), and organize everything into a tidy folder structure. Perfect for keeping your YouTube library playback-ready for Windows apps like "Film & TV".

---
```markdown
## 📁 Folder Structure

C:\YoutubeDownloader
├── Downloads
│   ├── video\              ← Temporary processing folder
│   └── \*.mp4               ← Final downloaded videos
├── yt-dlp.exe
├── download.bat            ← This script

---

## ✅ Features

- ✅ Downloads playlists or single videos via `yt-dlp`
- ✅ Converts `.mp4` files with Opus audio to AAC (192k)
- ✅ Skips files already in AAC format
- ✅ Renames duplicates automatically
- ✅ Cleans up temp folders
- ✅ Auto-opens the `Downloads` folder after completion
- ✅ Displays a clear summary
- ✅ Validates required tools (`yt-dlp`, `ffmpeg`, `ffprobe`)

---

## 🧰 Requirements

Make sure these tools are in the same folder as the script or available in your system `%PATH%`:

- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [FFmpeg](https://ffmpeg.org/download.html) *(must include `ffprobe`)*

---

## 🛠 How to Use

1. Place this project in `C:\YoutubeDownloader`
2. Download yt-dlp.exe in the root folder
3. Place config (called yt-dlp.conf) in the root folder
4. Run the batch file:
   - Double-click `YoutuberDownload.bat`

It will prompt you to paste a url.

---

## ⚙️ Example `config.txt` for yt-dlp

Create a file named `config.txt` in the same folder with:

txt
# Download video up to 720p (fallback to best available)
-f "bv[height<=720]+ba/b[height<=720]/b"

# Output format and filename
-o "%(title)s.%(ext)s"

# Merge into MP4 container (video+audio)
--merge-output-format mp4
````

---

## 📦 Output Behavior

* Converted videos are stored in:
  `C:\YoutubeDownloader\Downloads`

---

## 🧪 Validation

The script will stop and display an error if:

* `yt-dlp` is missing
* `ffmpeg` is missing
* `ffprobe` is missing

No conversion or downloading will begin until all tools are verified.

---

## 👀 Output Sample


[INFO] Downloading videos from: https://youtube.com/...
[INFO] Download folder: C:\YoutubeDownloader\Downloads\video
[ACTION] Converting audio to AAC for: ExampleVideo.mp4
[SUMMARY] Converted audio in 2 files, skipped 1 files.
Video Download Completed!


---

## 🔐 License

This script is intended for **personal use only**.
No license is attached. Use responsibly.

---

## 🧠 Notes

* Pause is kept at the end to help you verify if anything failed
* The script handles naming conflicts automatically
* Avoid moving files during conversion to prevent errors

---
```
