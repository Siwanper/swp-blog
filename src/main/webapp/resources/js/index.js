var click = device.mobile() ? 'touchstart' : 'click';
$(function(){
    // 侧边栏操作按钮
    $(document).on(click,'#guide',function () {
        $(this).toggleClass('toggled');
        $("#sidebar").toggleClass('toggled');
    })
    // 个人资料
    $(".s-profile a").click(function () {
        $(this).next().slideToggle(200);
        $(this).parent().toggleClass('toggled');
    })
    // 二级菜单点击
    $(".sub-menu a").click(function () {
        $(this).next().slideToggle(200);
        $(this).parent().toggleClass('toggled');
    })

    // Waves初始化（点击效果）
    Waves.displayEffect();
    // 滚动条初始化
    $('#sidebar').mCustomScrollbar({
        theme: 'minimal-dark',
        scrollInertia: 100,
        axis: 'yx',
        mouseWheel: {
            enable: true,
            axis: 'y',
            preventDefault: true
        }
    });
})

// 全屏模式
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