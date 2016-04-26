Goal of this project
====================

Find out which historic versions in TimeBackup consume space and which files are included

Steps:
- Create a list of all files in unix filesystem

	cd /volume2/Backup/TimeBackup/DiskStation_00113204F932/task_2
	for i in *
	do
		find $i -exec stat -t {} \; > /volume1/Stefan/$i.txt
	done

- convert to csv
- import to Excel
- analyze
