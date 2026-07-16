#!/bin/bash
SCRIPT_NAME="Konverze CZEPS factsheetu z RGB do CMYK a vykrivkovani"
VERSION_NUMBER="v2023-02-02"
AUTHOR="made by Martin Brozkeff Malec, martin.malec@czeps.org"
CONFIG_FILE="conf/config.conf"
cd "$(dirname "$0")" || exit
SCRIPT_DIR=$(pwd)

echo "${SCRIPT_NAME} ${VERSION_NUMBER}"
echo "${AUTHOR}"
echo "Využívám konfigurační soubor: ${CONFIG_FILE}"
. ${CONFIG_FILE}

echo "Spustit skript na konverzi PDF factsheetů z RGB do CMYKu a vykřivkování? Je potřeba mít nainstalovaný Ghostscript."
select yn in "Ano" "Ne"; do
    case $yn in
        Ano ) break;;
        Ne ) exit;;
    esac
done

echo "Spouštím Ghostscript pro konverzi PDF do CMYKu a vykřivkovávání fontů"

for FILENAME in ${PDF_RGB}/*.pdf; do
gs -o "${PDF_CMYK}/${FILENAME##*/}" \
		-dQUIET \
		-dNoOutputFonts \
		-sDEVICE=pdfwrite \
		-sColorConversionStrategy=CMYK \
		-sSourceObjectICC="${ICC_DIRECTORY}/${GS_CONTROL_FILE}" \
		"${FILENAME}"
done

# ChatGPT k tomu dal Explanation:
#    for filename in $PDF_RGB/*.pdf; do - This line will iterate over all PDF files in the $PDF_RGB directory.
#    filename##*/ - This line will extract the file name (without the directory path) from the full path stored in the filename variable.
#    $filename - This line uses the value stored in the filename variable as the input file for the Ghostscript command.

echo "Asi hotovo :)"