#!/bin/sh

clear
printf "\e[0;32mAzure Terraform Dev Container: $(basename $PWD)\e[0m\n"
printf "-----------------------------------------------------\n"
printf "$(terraform -v)\n"
printf "-----------------------------------------------------\n"
printf "Trivy $(trivy -v)\n"
printf "-----------------------------------------------------\n"
printf "$(tflint -v)\n"
printf "-----------------------------------------------------\n"
printf "$(aztfexport -v)\n"
printf "-----------------------------------------------------\n"