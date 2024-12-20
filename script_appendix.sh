###FFmpeg concatenation, transcoding, and downsampling script for UNIX-like systems###
###Amalia Skilton###
###July 2024, revised December 2024###

cat folders_to_transcode.txt | while read line
do
cd $line;
#Transcode and downsample files that DON'T require concatenation
#Edit the expression in backticks in the next line if you're using a different clip naming convention
for f in `ls *of1*`; do
	shortname=`echo $f | sed 's/_clip.*//'`;
	ffmpeg -i $f -y -acodec copy -vcodec copy ${shortname}_archive.mp4 < /dev/null;
	ffmpeg -nostdin -n -i $f  -map 0 -c:v libx264 -preset ultrafast -crf 23 -s 1280x720 -pix_fmt yuv420p -coder vlc -refs 1 -c:a aac -ab 256k -ac 2 -sn ${shortname}_720.mp4 < /dev/null;
	done
#Now transcode and edit the files that DO need concatenation
#Edit the expression in backticks in the next line if you're using a different clip naming convention
multi_clip_list=`ls *clip[^1]of[^1]*`;
for clipname in $multi_clip_list; do
	clip_basename=`echo $clipname | sed 's/_clip.*//'`;
	echo $clip_basename >> multi_clip_shortnames.txt;
	done
for shortname in `cat multi_clip_shortnames.txt | sort -u`; do
	cat_string=`ls $shortname* | tr '\n' '|' | sed 's/.$//'`;
	ffmpeg -i "concat:${cat_string}" -c copy ${shortname}_concat.MTS < /dev/null;
	ffmpeg -i ${shortname}_concat.MTS -y -acodec copy -vcodec copy ${shortname}_archive.mp4 < /dev/null;
	ffmpeg -nostdin -n -i ${shortname}_concat.MTS  -map 0 -c:v libx264 -preset ultrafast -crf 23 -s 1280x720 -pix_fmt yuv420p -coder vlc -refs 1 -c:a aac -ab 256k -ac 2 -sn ${shortname}_720.mp4 < /dev/null;
	rm *_concat.MTS;
done;
rm multi_clip_shortnames.txt;
mkdir Archive;
mkdir 720;
mv *_archive.mp4 Archive;
mv *_720.mp4 720;
cd ..;
done
