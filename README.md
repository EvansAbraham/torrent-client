# Torrent-Client (aria2c) Automation Script

A simple bash script to automate torrent downloads using aria2c on macOS.
Designed to resume downloads gracefully and notify on completion or failure.

## Features

* Reads magnet link from a `magnet.txt` file
* Automatically downloads to `~/Downloads` folder
* Resumes interrupted downloads seamlessly
* Sends macOS notifications when download completes or fails
* Clears `magnet.txt` after successful download

## Requirements

* macOS
* [aria2](https://aria2.github.io/) installed (`brew install aria2` recommended)
* `magnet.txt` file containing the magnet link (one link per file)

## Usage

1. Place your magnet link inside a file named `magnet.txt` in the same directory as the script.
2. Run the script in terminal:

   ```bash
   ./torrent-client.sh
   ```
3. Wait for the download to complete or check notifications for status.

## How it works

* The script reads the magnet link from `magnet.txt`.
* Starts aria2c with options for zero seed time (no seeding after download), metadata saving, and no file allocation overhead.
* On successful download, it clears the magnet link file and notifies you via macOS notification center.
* On failure, it notifies you as well but leaves the magnet link for retry.

## Notes

* You can interrupt the script with `Ctrl+C`. The download will resume when you rerun the script.
* Make sure aria2 is installed and accessible in your PATH.
* Customize the download directory by modifying the `--dir` option in the script if desired.

## Warning

* Do NOT delete or modify any .aria2 files or partially downloaded content manually.
* These files are essential for aria2c’s resume functionality. Removing or changing them can corrupt or break your download progress.
* Always let the script or aria2c handle the download state to ensure smooth resumption.

## Contribution

Feel free to fork and improve the script. Pull requests are welcome!
