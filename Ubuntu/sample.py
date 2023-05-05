from gi.repository import GObject, Gst
import gi
gi.require_version('Gst', '1.0')
Gst.init(None)

# GStreamerパイプラインを定義
pipeline = Gst.parse_launch("videotestsrc ! autovideosink")

# パイプラインを再生
pipeline.set_state(Gst.State.PLAYING)

# メインループを開始
loop = GObject.MainLoop()
loop.run()

# パイプラインを停止
pipeline.set_state(Gst.State.NULL)
