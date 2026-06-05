#!/bin/bash
export ANDROID_HOME=/home/runner/workspace/android-sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
export GRADLE_USER_HOME=/home/runner/workspace/.gradle
export TMPDIR=/home/runner/workspace/.tmp
export _JAVA_OPTIONS="-Djava.io.tmpdir=/home/runner/workspace/.tmp"

mkdir -p $TMPDIR

echo "=== APK BUILD STARTED $(date) ===" | tee /home/runner/workspace/apk-build.log

cd /home/runner/workspace/artifacts/edupress/android

./gradlew assembleDebug --no-daemon 2>&1 | tee -a /home/runner/workspace/apk-build.log

EXIT=$?
echo "=== BUILD EXIT: $EXIT at $(date) ===" | tee -a /home/runner/workspace/apk-build.log

if [ $EXIT -eq 0 ]; then
  APK=$(find /home/runner/workspace/artifacts/edupress/android/app/build/outputs/apk/debug -name "*.apk" | head -1)
  echo "=== APK READY: $APK ===" | tee -a /home/runner/workspace/apk-build.log
  cp "$APK" /home/runner/workspace/EduPress-debug.apk
  echo "=== COPIED TO: /home/runner/workspace/EduPress-debug.apk ===" | tee -a /home/runner/workspace/apk-build.log
fi

# Keep alive so workflow doesn't restart
while true; do sleep 60; done
