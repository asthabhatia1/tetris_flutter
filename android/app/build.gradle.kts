import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

/* -------------------- LOAD KEYSTORE -------------------- */
val keystoreProperties = Properties()
val keystoreFile = rootProject.file("key.properties")
if (keystoreFile.exists()) {
    keystoreProperties.load(FileInputStream(keystoreFile))
} else {
    println("Warning: key.properties not found. Release signing will fail if used.")
}

/* -------------------- ANDROID CONFIG -------------------- */
android {
    namespace = "app.astha.tetris"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "app.astha.tetris"
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    /* -------------------- SIGNING CONFIG -------------------- */
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as? String ?: ""
            keyPassword = keystoreProperties["keyPassword"] as? String ?: ""
            storePassword = keystoreProperties["storePassword"] as? String ?: ""
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }?.takeIf { it.exists() }

            if (storeFile == null) {
                throw GradleException(
                    "Keystore file not found or path is incorrect: ${keystoreProperties["storeFile"]}\n" +
                    "Please check your key.properties and ensure the .jks file exists."
                )
            }
        }
    }

    /* -------------------- BUILD TYPES -------------------- */
   
    buildTypes {
    release {
        signingConfig = signingConfigs.getByName("release")
        isMinifyEnabled = false
        isShrinkResources = false

        ndk {
            debugSymbolLevel = "none"
        }
    }
}


    }

    packagingOptions {
        jniLibs {
            doNotStrip += setOf("**/*.so")
        }
    }

} // <-- This closes android { ... }

/* -------------------- FLUTTER -------------------- */
flutter {
    source = "../.."
}
