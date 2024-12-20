# System requirements

- You must have access to a Unix shell. This means Terminal on Mac or a Unix emulator, such as Cygwin, for Windows.

- You must have FFmpeg installed and added to the path variable. Test this by typing `which ffmpeg` (with no arguments) at the command line and hitting enter. If this prints a path, you have FFmpeg installed.

# Purpose

- Concatenate MTS video clips with shared filenames. 

- Transcode them to MP4 without any other changes for archiving. 

- Also, downsample the concatenated files to 720p resolution and MP4 format for annotation.

# First time running a shell script?

Take a few minutes to check out a tutorial on Unix shell basics. My favorite is https://swcarpentry.github.io/shell-novice/. If you're running Windows, many tutorials will show you ow to download a Unix emulator.

# How to run the script

1. As described in the input requirements, organize your video files into folders and create a text file listing the folders to transcode.

2. Open the command line, type `bash script_appendix.sh` and hit enter. 

If you are not in the directory that contains the script, you will need to type `bash` followed by a path to the script, e.g. `bash ~/Documents/Archiving_Files/script_appendix.sh.`.

# Input requirements

1. You must create a text file named `folders_to_transcode.txt` with a list of the paths to the FOLDERS that need to be transcoded and downsampled. 

2. All files from the same camera at the same session (i.e., everything that should be concatenated together) must be in the SAME FOLDER. 

3. All files from the same camera at the same session must have the SAME BASE FILENAME, and it must be followed by a unique clip ID of the format `clip{1-9}of{1-9}`. 

4. If a clip should not be concatenated with anything else, its name must contain the string `clip1of1`.

Examples of valid filenames:
`session1_clip1of2.MTS`, `session1_clip2of2.MTS`
`session1_camera1_clip1of2.MTS`, `session1_camera1_clip2of2.MTS`
`session1_camera2_clip1of2.MTS`, `session1_camera2_clip2of2.MTS` (will NOT concatenate with the `camera1` files)
`session1_clip1of1.MTS`

Examples of invalid filenames:
`session1.2_clip1.MTS`, `session1.2_clip2.MTS`
`session1.MTS`

# Output details

When you run the script, it will:

1. Create a single MP4 for each session for ARCHIVING. This file will have the same video and audio encoding as the inputs. Its name will be the same as the original session file name, but end in _archive.mp4.

2. Create a single MP4 for each session with AAC audio and 720p resolution. This file is DOWNSAMPLED so that it's suitable for annotating in ELAN. Its name will end in _720.mp4.

# Additional details

- Your input files must be in a format that can be concatenated to MTS. This probably means they're also MTS.

- If you want to change the file name requirements, edit the lines in the script indicated with comments.# auto-ffmpeg
