#!/bin/bash

# all directory names
DIRS=$(find . -mindepth 1 -type d -not -path '*/.*' -printf "%f\n")

###################
# SETUP TEMPLATES #
###################
CONTENT_TEMPLATE='CONTENT_TEMPLATE.md'
README_TEMPLATE='README_TEMPLATE.md'

TEMP_TEMPLATE='tmp.md'
EASY_TEMPLATE='EASY_TEMPLATE.md'
MEDIUM_TEMPLATE='MEDIUM_TEMPLATE.md'
HARD_TEMPLATE='HARD_TEMPLATE.md'
OTHERS_TEMPLATE='OTHERS_TEMPLATE.md'
NEW_README='NEW_README.md'

echo "## Easy" > $EASY_TEMPLATE
echo "## Medium" > $MEDIUM_TEMPLATE
echo "## Hard" > $HARD_TEMPLATE

####################################
# ITERATING DIRS TO EXTRACT VALUES #
####################################

for dir in $DIRS
do
	files=$(ls $dir)

	for file in $files
	do
	 	file_path="$dir/$file"

		######################
		# GETTING ALL VALUES #
		######################
		link=$(grep -i "Link:" $file_path | awk '{for(i=3;i<=NF;++i) printf "%s ", $i; print ""}')
		level=$(grep -i "Level:" $file_path | awk '{for(i=3;i<=NF;++i) printf "%s ", $i; print ""}')
		description=$(grep -i "Description:" $file_path | awk '{for(i=3;i<=NF;++i) printf "%s ", $i; print ""}')
		result=$(grep -i "Result:" $file_path | awk '{for(i=3;i<=NF;++i) printf "%s ", $i; print ""}')

		# %.* remove formatting
		# -F split the string
		# i=1 ignore initial argument in index 0
		# toupper substr 1,1 capitalize each word's first letter
		title=$(echo ${file%.*} | awk -F'-' '{for(i=1;i<=NF;++i) printf "%s ", toupper(substr($i,1,1)) substr($i, 2); print ""}')

		# -v do invert
		# \\ escape the -- (taking the comments)
		sql=$(grep -v '\-\-' $file_path)

		######################
		# REPLACING TEMPLATE #
		######################
		cp $CONTENT_TEMPLATE $TEMP_TEMPLATE
		sed -i "s|PLATFORM|${dir^}|" $TEMP_TEMPLATE
		sed -i "s|TITLE|${title}|" $TEMP_TEMPLATE
		sed -i "s|LINK|${link}|" $TEMP_TEMPLATE
		sed -i "s|DESCRIPTION|${description}|" $TEMP_TEMPLATE
		
		# https://superuser.com/a/1632938
		# use // to replace all literal newline to escaped newline
		sed -i "s|SQL|${sql//$'\n'/\\n}|" $TEMP_TEMPLATE
		sed -i "s|PICTURE|${result}|" $TEMP_TEMPLATE
		# sed adds extra whitespace... so, handle that...
		sed -i "s| )|)|" $TEMP_TEMPLATE
		sed -i "s|\s*$||" $TEMP_TEMPLATE
		echo "" >> $TEMP_TEMPLATE
		echo "" >> $TEMP_TEMPLATE
		# cat $TEMP_TEMPLATE

		###################
		# GROUPING LEVELS #
		###################
		# * is important, maybe there's a newline after the variable?
		case $level in
			Easy*)
				cat $TEMP_TEMPLATE >> $EASY_TEMPLATE ;;
			Medium*)
				cat $TEMP_TEMPLATE >> $MEDIUM_TEMPLATE ;;
			Hard*)
				cat $TEMP_TEMPLATE >> $HARD_TEMPLATE ;;
			*)
        echo "$level is not correct"
        exit 1
        ;;
		esac
	done
done

###################
# GROUPING LEVELS #
###################

cp $README_TEMPLATE $NEW_README
cat $EASY_TEMPLATE >> $NEW_README
cat $MEDIUM_TEMPLATE >> $NEW_README
cat $HARD_TEMPLATE >> $NEW_README
cat $OTHERS_TEMPLATE >> $NEW_README

#############
# FINALIZED #
#############

mv README.md OLD_README.md
mv $NEW_README README.md

############
# CLEAN UP #
############
rm $TEMP_TEMPLATE $EASY_TEMPLATE $MEDIUM_TEMPLATE $HARD_TEMPLATE 2> /dev/null
