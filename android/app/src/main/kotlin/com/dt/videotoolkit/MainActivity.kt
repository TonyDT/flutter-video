package com.dt.videotoolkit

import android.content.ContentValues
import android.media.MediaScannerConnection
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream

class MainActivity : FlutterActivity() {
    private val channelName = "xixi_media_tool/media_saver"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "saveAudioFile" -> {
                    val path = call.argument<String>("path")
                    val name = call.argument<String>("name")
                    val mimeType = call.argument<String>("mimeType") ?: "audio/*"
                    result.success(saveAudioFile(path, name, mimeType))
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun saveAudioFile(path: String?, name: String?, mimeType: String): Boolean {
        if (path.isNullOrBlank()) return false

        val source = File(path)
        if (!source.exists() || source.length() <= 0L) return false

        val displayName = sanitizeFileName(name ?: source.name)
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            saveAudioFileToMediaStore(source, displayName, mimeType)
        } else {
            saveAudioFileLegacy(source, displayName)
        }
    }

    private fun saveAudioFileToMediaStore(source: File, displayName: String, mimeType: String): Boolean {
        val resolver = applicationContext.contentResolver
        val values = ContentValues().apply {
            put(MediaStore.Audio.Media.DISPLAY_NAME, displayName)
            put(MediaStore.Audio.Media.MIME_TYPE, mimeType)
            put(MediaStore.Audio.Media.RELATIVE_PATH, "${Environment.DIRECTORY_MUSIC}/ToolKit")
            put(MediaStore.Audio.Media.IS_PENDING, 1)
        }

        val uri = resolver.insert(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, values) ?: return false
        return try {
            resolver.openOutputStream(uri)?.use { output ->
                FileInputStream(source).use { input ->
                    input.copyTo(output)
                }
            } ?: return false

            values.clear()
            values.put(MediaStore.Audio.Media.IS_PENDING, 0)
            resolver.update(uri, values, null, null)
            true
        } catch (_: Exception) {
            resolver.delete(uri, null, null)
            false
        }
    }

    private fun saveAudioFileLegacy(source: File, displayName: String): Boolean {
        return try {
            val musicDir = File(
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_MUSIC),
                "ToolKit"
            )
            if (!musicDir.exists() && !musicDir.mkdirs()) return false

            val target = File(musicDir, displayName)
            source.copyTo(target, overwrite = true)
            MediaScannerConnection.scanFile(
                applicationContext,
                arrayOf(target.absolutePath),
                null,
                null
            )
            true
        } catch (_: Exception) {
            false
        }
    }

    private fun sanitizeFileName(name: String): String {
        val cleaned = name.replace(Regex("[\\\\/:*?\"<>|]"), "_").trim()
        return cleaned.ifEmpty { "audio_${System.currentTimeMillis()}.mp3" }
    }
}
