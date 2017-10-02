#!/bin/bash
git add *.md
git add *.h
git add *.cpp
git add *.pro
git add *.qml
git add *.qrc
git add *.conf
git add *.AppImage
git add *.sh
git commit -m "$1"
git push -u origin master
