
$(function(){
    Waves.displayEffect();
})

function fullPage() {
    if ($.util.supportsFullScreen){
        if ($.util.isFullScreen()){
            $.util.cancelFullScreen();
        }else  {
            $.util.requestFullScreen();
        }
    }else  {
        alert("当前浏览器不支持全屏 API，请更换至最新的 Chrome/Firefox/Safari 浏览器或通过 F11 快捷键进行操作。")
    }
}