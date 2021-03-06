AndroidNative Installation Guide
================================

Step 1 - Download source package
-----------------------------

It is recommended to install AndroidNative via qpm

    qpm install android.native.pri
   
Step 2 - Setup import path [Optional]
---------------------------

In case, you are using Qt <= 5.6 , you need to add the import path manually

    engine.addImportPath("qrc:/qt-project.org/imports");

Step 3 - JNI_OnLoad
-------------------

In you main.cpp, add following lines:

```
#ifdef Q_OS_ANDROID
#include <AndroidNative/systemdispatcher.h>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>

JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void*) {
    Q_UNUSED(vm);
    qDebug("NativeInterface::JNI_OnLoad()");

    // It must call this function within JNI_OnLoad to enable System Dispatcher
    AndroidNative::SystemDispatcher::registerNatives();

    return JNI_VERSION_1_6;
}
#endif
```

Example: [main.cpp](https://github.com/benlau/androidnative.pri/blob/master/examples/androidnativeexample/main.cpp#L18)

Step 4 - Modify build.gradle
----------------------------

AndroidNative only supports gradle build system, and you must have AndroidManifest.xml and build.gradle file is generated. If you don't know how to do, please check the document below for "Create templates"

[Deploying Applications to Android Devices | Qt Creator Manual](http://doc.qt.io/qtcreator/creator-deploying-android.html)

1) Copy [androidnative.gradle](https://github.com/benlau/androidnative.pri/blob/master/examples/androidnativeexample/android-sources/androidnative.gradle) to ANDROID_PACKAGE_SOURCE_DIR

2) Add the following lines **at the end** of your build.gradle

    apply from: "androidnative.gradle"
    setAndroidNativePath("/../vendor/android/native/pri")

The input argument of `setAndroidNativePath` is the relative path from the ANDROID_PACKAGE_SOURCE_DIR to the installation path of AndroidNative (the folder contains `androidnative.pri`). You need to modify it in case your AndroidNative is not installed via qpm or the ANDROID_PACKAGE_SOURCE_DIR is not set to the default path.

Example: [build.gradle](https://github.com/benlau/androidnative.pri/blob/master/examples/androidnativeexample/android-sources/build.gradle#L59)

Step 5 - Modify your Android activity [Optional]
------------------------------------------------

*If you don't need to use feature like ImagePicker, you may skip this step.*

If you don't have your own custom Android activity, modify AndroidManifest.xml, change activity.name to "androidnative.AndroidnativeActivity"

Example: [AndroidManifest.xml](https://github.com/benlau/androidnative.pri/blob/master/examples/androidnativeexample/android-sources/AndroidManifest.xml)

If you have your own custom Android activity, add following lines to your activity class:

```
import androidnative.SystemDispatcher;
```

```
@Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        SystemDispatcher.onActivityResult(requestCode,resultCode,data);
    }
```

Example: [AndroidNativeActivity.java](https://github.com/benlau/androidnative.pri/blob/master/java/src/androidnative/AndroidNativeActivity.java)


